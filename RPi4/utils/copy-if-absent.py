#!/usr/bin/env python3

import os, sys, shutil, argparse, re, glob


def normalize_dir(path):
	return os.path.expanduser(path).rstrip('/')+'/'


def get_cue_filelist(fn):
	dir = os.path.dirname(fn)
	entries = [L for L in open(fn).readlines() if L.strip().startswith('FILE')]
	out = [L[L.find('"')+1:L.rfind('"')] for L in entries]
	return [dir+'/'+f for f in out]


def getFileSize(path, fn):
	if not path:
		return 0
	try:
		return os.path.getsize(path+fn)
	except:
		return 0


def copyOverFiles(src_full, dst_path):
	global move
	try:
		os.makedirs(os.path.dirname(dst_path), exist_ok = True)
		src_patn = src_full.rsplit('.', 1)[0] + '.*'
		print(f'Copying {src_patn} -> {dst_path}', file = sys.stderr)
		for file in glob.glob(src_patn):
			if move:
				shutil.move(file, dst_path)
			else:
				shutil.copy(file, dst_path)
		if src_full.lower().endswith('.cue'):
			for file in get_cue_filelist(src_full):
				if move:
					shutil.move(file, dst_path)
				else:
					shutil.copy(file, dst_path)
	except Exception as e:
		print(f'Error: {str(e)}', file = sys.stderr)
		return False
	return True


def get_fullnames(path, ext):
	if ' ' in ext:
		return [fn for ext1 in ext.split() for fn in get_fullnames(path, ext1)]
	return [fn for fn in glob.glob(path + '*.' + ext.upper()) + glob.glob(path + '*.' + ext.lower())]


if __name__ == '__main__':
	parser = argparse.ArgumentParser(usage = '$0 [options] "rom_exts ..." dst_dir src_dirs ... 1>output 2>progress',
	                                 description = 'copy ROM files from source directory to destination directory if the normalized ROM name is not found',
	                                 formatter_class = argparse.ArgumentDefaultsHelpFormatter)
	parser.add_argument('--move', '-m', help = 'move files over instead of copying files', action = 'store_true')
	parser.add_argument('--norm', '-n', help = 'the Python code for normalizing ROM names from ROM filename',
	                    default = "re.sub(' +', ' ', re.sub('\[.*\]', '', s.rsplit('.',1)[0].replace('!',''))).lower().strip()")
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



