#!/usr/bin/env python3

import os, sys, shutil, argparse, re, glob, shutil
import xml.etree.ElementTree as ET


def normalize_dir(path):
	return os.path.expanduser(path).rstrip('/')+'/'


def get_cue_filelist(fn):
	dir = os.path.dirname(fn)
	entries = [L for L in open(fn).readlines() if L.strip().startswith('FILE')]
	out = [L[L.find('"')+1:L.rfind('"')] for L in entries]
	return [dir+'/'+f for f in out]


def get_m3u_filelist(fn):
	dir = os.path.dirname(fn)
	entries = [L.strip() for L in open(fn).readlines() if L.strip()]
	return [dir+'/'+f for f in entries]


def get_game_id(game):
	global key, normalize
	if game.find(key) == None:
		return None
	s = os.path.basename(game.find(key).text)
	return normalize(s)


def getFileSize(fn):
	try:
		ret = os.path.getsize(fn)
		if fn.lower().endswith('.cue'):
			ret += sum([os.path.getsize(f1) for f1 in get_cue_filelist(fn)])
		elif fn.lower().endswith('.m3u'):
			ret += sum([os.path.getsize(f1) for f1 in get_m3u_filelist(fn)])
		return ret
	except:
		return 0


def deleteFileIfNeeded(path, fn):   # non-ROM
	try:
		print(f'Deleting {path+fn} ...', file = sys.stderr)
		os.remove(path+fn)
	except FileNotFoundError as e:
		pass
	except Exception as e:
		print(f'Error: {str(e)}', file = sys.stderr)


def deleteRomFiles(src_full):
	def del_file(filename):
		print(f'Deleting {filename} ...', file = sys.stderr)
		try:
			os.remove(filename)
		except FileNotFoundError:
			pass
		except Exception as e:
			print(f'Error: {str(e)}', file = sys.stderr)
	src_patn = src_full.rsplit('.', 1)[0] + '.*'
	for filename in glob.glob(src_patn.replace('[','[[]').replace(']','[]]')):
		if filename.lower().endswith('.cue'):
			for fn in get_cue_filelist(filename):
				del_file(fn)
		elif filename.lower().endswith('.m3u'):
			for fn in get_m3u_filelist(filename):
				del_file(fn)
		del_file(filename)


def gamelist_verify(source, src_path):
	print(f'Parsing {source} ...', end = ' ', flush = True, file = sys.stderr)
	src_tree = ET.parse(source)
	src_root = src_tree.getroot()
	print(f"{len(src_root)} entries", file = sys.stderr)

	# main loop
	for game in src_root.findall('game'):
		game_info = {d.tag: d.text for d in game}
		for k, v in game_info.items():
			if v is None: continue
			if not v.startswith('./'): continue
			if getFileSize(src_path, v[2:]) == 0:
				print(f'Missing file: {src_path+v[2:]}')
			elif v.lower().endswith('.m3u'):
				for fn in get_m3u_filelist(src_path+v[2:]):
					if getFileSize(fn) == 0:
						print(f'Missing M3U: {src_path+v[2:]}')
			elif v.lower().endswith('.cue'):
				for fn in get_cue_filelist(src_path+v[2:]):
					if getFileSize(fn) == 0:
						print(f'Missing CUE: {src_path+v[2:]}')


class String(str):
	for func in dir(str):
		if not func.startswith('_'):
			exec(f'{func}=lambda *args, **kwargs: [(String(i) if type(i)==str else ([String(j) for j in i] if type(i)==list else i)) for i in [str.{func}(*args, **kwargs)]][0]')

	def __init__(self, value='', **kwargs):
		super().__init__()

	def sub(self, src, tgt):
		return String(re.sub(src, tgt, self))


if __name__ == '__main__':
	parser = argparse.ArgumentParser(usage = '$0 <gamelist1.xml> ... [options] 1>output 2>progress',
	                                 description = 'This program verifies gamelist.xml',
	                                 formatter_class = argparse.ArgumentDefaultsHelpFormatter)
	parser.add_argument('sources', help = 'input gamelist.xml files', nargs = '+')
	parser.add_argument('--source-dir', '-sd', help = 'the root directory(ies) containing all the ROM/preview files, if present, resource files will be moved, if multiple are specified, its number must match that in <sources>', default = [], nargs = '+')
	# nargs='?': optional positional argument; action='append': multiple instances of the arg; type=; default=
	opt = parser.parse_args()
	globals().update(vars(opt))

	if not source_dir:
		source_dir = [os.path.dirname(src1) for src1 in sources]
	elif len(source_dir)==1:
		source_dir = source_dir*len(sources)
	else:
		assert len(source_dir)==len(sources), 'Number of items in <output-dir> must match that in <sources> (or be 1 (the same for every <source>))'

	normalize = lambda s: eval(norm)

	for src_xml, src_dir in zip(sources, source_dir):
		gamelist_verify(os.path.expanduser(src_xml), normalize_dir(src_dir))
