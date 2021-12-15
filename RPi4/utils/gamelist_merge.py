#!/usr/bin/env python3

import os, sys, shutil, argparse, re
import xml.etree.ElementTree as ET


def normalize_dir(path):
	return os.path.expanduser(path).rstrip('/')+'/'


def get_game_id(game):
	global key
	if game.find(key) == None:
		return None
	rom_name = os.path.basename(game.find(key).text)
	game_id = os.path.splitext(rom_name)[0].strip().lower()
	game_id = re.sub(r'!', '', game_id)
	return re.sub(r' +', ' ', game_id.strip())


def getFileSize(path, fn):
	if not path:
		return 0
	try:
		return os.path.getsize(path+fn)
	except:
		return 0


def deleteFileIfNeeded(path, fn):
	try:
		print(f'Deleting {path+fn} ...', file = sys.stderr)
		os.remove(path+fn)
	except Exception as e:
		print(f'Error: {str(e)}', file = sys.stderr)


def copyOverFileIfNeeded(src_path, src_fn, dst_path, dst_fn):
	try:
		if src_path=='' or dst_path=='' or not src_fn.startswith('./') or not dst_fn.startswith('./'):
			return
		src_full = src_path + src_fn
		dst_full = dst_path + dst_fn
		src_size, dst_size = getFileSize(src_path, src_fn), getFileSize(dst_path, dst_fn)
	except:
		pass
	if src_size != dst_size and src_size:
		try:
			print(f'Copying {src_full} -> {dst_full}', file = sys.stderr)
			os.makedirs(os.path.dirname(dst_full), exist_ok = True)
			shutil.copyfile(src_full, dst_full)
		except Exception as e:
			print(f'Error: {str(e)}', file = sys.stderr)


def gamelist_merge(output, sources, out_path, src_dirs, rule):
	if not sources:
		return ET.ElementTree()

	game_dict = {}
	print(f'Parsing {sources[0]} as baseline ...', end = ' ', flush = True)
	out_tree = ET.parse(sources[0])
	out_root = out_tree.getroot()
	print(f"{len(out_root)} entries")

	# clear output
	for i in out_root.findall('game'):
		out_root.remove(i)

	# iterate over every source file
	for source, src_path in zip(sources, src_dirs):
		print(f'Parsing {source} ...', end = ' ', flush = True)
		src_tree = ET.parse(source)
		src_root = src_tree.getroot()
		print(f"{len(src_root)} entries")

		# main loop
		for game in src_root.findall('game'):
			game_id = get_game_id(game)
			if not game_id: continue
			if game_id not in game_dict:
				game_dict[game_id] = game
				out_root.append(game)
				for entry in game:
					if entry.text and entry.text.startswith('./'):
						copyOverFileIfNeeded(src_path, entry.text, out_path, entry.text)
				continue
			if not rule:
				continue

			# do internal merge: choose baseline or source
			bl_game = game_dict[game_id]
			bl_info = {d.tag: d.text for d in bl_game}
			new_info = {d.tag: d.text for d in game}
			for k, v in new_info.items():
				if k not in bl_info:    # for new field just add
					e = ET.Element(k)
					e.text = v
					if len(bl_game):
						e.tail = bl_game[-1].tail
						bl_game[-1].tail = bl_game[0].tail
					bl_game.append(e)
					copyOverFileIfNeeded(src_path, v, out_path, v)
					continue
				if v is None:   # None will not overwrite anything
					continue
				if v.startswith('./'):  # is a filename field
					bl_filesize = getFileSize(out_path, v)
					new_filesize = getFileSize(src_path, v)
					if bl_filesize != new_filesize:
						rule1 = rule.get(k, rule.get('<file>', 'bigger'))
						if (new_filesize>bl_filesize and rule1=='bigger') or (new_filesize<bl_filesize and rule1=='smaller'):
							if out_path not in sources:
								deleteFileIfNeeded(out_path, bl_game.find(k).text)
							bl_game.find(k).text = v
							copyOverFileIfNeeded(src_path, v, out_path, v)
				else:   # is a string field
					bl_strlen = len(bl_info[k])
					new_strlen = len(v)
					if bl_strlen != new_strlen:
						rule1 = rule.get(k, rule.get('<string>', 'longer'))
						if (new_strlen>bl_strlen and rule1=='longer') or (new_strlen<bl_strlen and rule1=='shorter'):
							bl_game.find(k).text = v

	print(f"\nWriting output xml file to {output} ... ({len(out_tree.findall('game'))} entries)")
	out_tree.write(output, encoding = "UTF-8", xml_declaration = True)


if __name__ == '__main__':
	parser = argparse.ArgumentParser(usage = '$0 <output> <sources> ... [options] 1>output 2>progress',
	                                 description = 'The world\'s best program (up to today) for merging gamelist.xml (it can merge multiple game lists in one go)\n'
	                                               'It can resolve duplicates both within the same gamelist.xml and across multiple gamelist.xml\n'
	                                               'It can work on just the list files (gamelist.xml) only or together with the directory of all the files\n'
	                                               'For input: you can keep different sources into different folders or lump everything into one single folder\n'
	                                               'For output: you can modify resources inplace (same input/output <rootdir>) or output to a different folder\n'
	                                               'You can specify merge rules (or no internal merge), for string field keep "longer" or "shorter", for file keep "bigger" or "smaller"\n'
	                                               'By default, it will keep longer string field (expect more detailed description), smaller ROM file (more efficient compression), bigger resource file (better resolution image/video)',
	                                 formatter_class = argparse.ArgumentDefaultsHelpFormatter)
	parser.add_argument('output', help = 'output gamelist.xml file')
	parser.add_argument('sources', help = 'input gamelist.xml files, first file has the highest priority in the event of tie rule or no merge', nargs = '+')
	parser.add_argument('--key', '-k', help = 'the key field for distinguishing different games', default = 'path')
	parser.add_argument('--source-dir', '-sd', help = 'the root directory(ies) containing all the ROM/preview files, if present, resource files will be moved, if multiple are specified, its number must match that in <sources>', default = [], nargs = '+')
	parser.add_argument('--output-dir', '-od', help = 'the output directory containing all the ROM/preview files, if present, resource files will be moved, can be the same as any <source-dir>', default = '')
	parser.add_argument('--mergerule', '-m', help = 'the merge rule, <file> refer to all filename fields, <string> refer to all non-filename fields, set to {} for no internal merge',
	                    default = "{'path':'smaller', '<files>':'bigger', '<string>':'longer'}")
	# nargs='?': optional positional argument; action='append': multiple instances of the arg; type=; default=
	opt = parser.parse_args()
	globals().update(vars(opt))

	if not source_dir:
		source_dir = ['']*len(sources)
	elif len(source_dir)==1:
		source_dir = source_dir*len(sources)
	else:
		assert len(source_dir)==len(sources), 'Number of items in <output-dir> must match that in <sources> (or be 1 (the same for every <source>))'

	rule = eval(mergerule)

	gamelist_merge(os.path.expanduser(output), [os.path.expanduser(fn) for fn in sources], normalize_dir(output_dir), [normalize_dir(p) for p in source_dir], rule)
