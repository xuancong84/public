#!/usr/bin/env python3

import os, sys, shutil, argparse, re, glob


def normalize_dir(path):
	return os.path.expanduser(path).rstrip('/')+'/'


def glob_find(patn):
	return glob.glob(patn.replace('[','[[]').replace(']','[]]'))


def get_cue_filelist(fn):
	dir = os.path.dirname(fn)
	entries = [L for L in open(fn).readlines() if L.strip().startswith('FILE')]
	out = [L[L.find('"')+1:L.rfind('"')] for L in entries]
	return [dir+'/'+f for f in out]


def get_m3u_filelist(fn):
	dir = os.path.dirname(fn)
	entries = [L.strip() for L in open(fn).readlines() if L.strip()]
	return [dir+'/'+f for f in entries]


def getFileSize(path, fn=''):
	if not path:
		return 0
	try:
		return os.path.getsize(path+fn)
	except:
		return 0


def copyOverFiles(src_full, dst_path):
	global move

	def transfer(src_fn, tgt):
		dst_fn = tgt+os.path.basename(src_fn) if os.path.isdir(tgt) else tgt
		src_size, dst_size = getFileSize(src_fn), getFileSize(dst_fn)
		if src_size != dst_size and src_size:
			print(f'%s {src_fn} -> {tgt}' % ('Moving' if move else 'Copying'), file = sys.stderr)
			(shutil.move if move else shutil.copy)(src_fn, tgt)
		else:
			print(f'Skipping {src_fn} == {dst_fn}', file = sys.stderr)

	try:
		os.makedirs(os.path.dirname(dst_path), exist_ok = True)
		src_patn = src_full.rsplit('.', 1)[0] + '.*'
		print(f'%s {src_patn} -> {dst_path}'%('Moving' if move else 'Copying'), file = sys.stderr)
		for file in glob_find(src_patn):
			transfer(file, dst_path)
		if src_full.lower().endswith('.cue'):
			for file in get_cue_filelist(src_full):
				transfer(file, dst_path)
		elif src_full.lower().endswith('.m3u'):
			for file in get_m3u_filelist(src_full):
				transfer(file, dst_path)
	except Exception as e:
		print(f'Error: {str(e)}', file = sys.stderr)
		return False
	return True


def get_fullnames(path, ext):
	if ' ' in ext:
		return [fn for ext1 in ext.split() for fn in get_fullnames(path, ext1)]
	return [fn for fn in glob_find(path + '*.' + ext.lstrip('.').upper()) + glob_find(path + '*.' + ext.lstrip('.').lower())]


if __name__ == '__main__':
	parser = argparse.ArgumentParser(usage = '$0 [options] "rom_exts ..." dst_dir src_dirs ... 1>output 2>progress',
	                                 description = 'copy ROM files from source directory to destination directory if the normalized ROM name is not found',
	                                 formatter_class = argparse.ArgumentDefaultsHelpFormatter)
	parser.add_argument('--move', '-m', help = 'move files over instead of copying files', action = 'store_true')
	parser.add_argument('--norm', '-n', help = 'the Python code for normalizing ROM names from ROM filename',
	                    default = 're.sub(r" +", " ", re.sub("\[.*\]", "", s.rsplit(".",1)[0].replace("!", "").replace("(USA)","(U)").replace("(US)","(U)").replace("(Europe)", "(E)"))).strip().lower()')
	parser.add_argument('rom_exts', help = 'ROM file extension(s) delimited by space (case-insensitive), e.g., "iso chd cue"')
	parser.add_argument('dst_dir', help = 'destination directory')
	parser.add_argument('src_dirs', help = 'source directories', nargs = '+')
	# nargs='?': optional positional argument; action='append': multiple instances of the arg; type=; default=
	opt = parser.parse_args()
	globals().update(vars(opt))

	src_dirs, dst_dir = [normalize_dir(src_dir) for src_dir in src_dirs], normalize_dir(dst_dir)
	normalize = lambda s: eval(norm)

	# get destination ROM set
	dst_rom_set = set([normalize(os.path.basename(fn)) for fn in get_fullnames(dst_dir, rom_exts)])

	# main loop
	for src_dir in src_dirs:
		for fn in get_fullnames(src_dir, rom_exts):
			new_rom = normalize(os.path.basename(fn))
			if new_rom not in dst_rom_set:
				if copyOverFiles(fn, dst_dir):
					dst_rom_set.add(new_rom)



