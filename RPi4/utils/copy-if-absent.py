#!/usr/bin/env python3

import os, sys, shutil, argparse, re, glob


def normalize_dir(path):
	return os.path.expanduser(path).rstrip('/')+'/'


def getFileSize(path, fn):
	if not path:
		return 0
	try:
		return os.path.getsize(path+fn)
	except:
		return 0


def copyOverFiles(src_full, dst_path):
	try:
		os.makedirs(os.path.dirname(dst_path), exist_ok = True)
		src_patn = src_full.rsplit('.', 1) + '.*'
		print(f'Copying {src_patn} -> {dst_path}', file = sys.stderr)
		for file in glob.glob(src_patn):
			shutil.copy(file, dst_path)
	except Exception as e:
		print(f'Error: {str(e)}', file = sys.stderr)


def get_fullnames(path, ext):
	if ' ' in ext:
		return [fn for ext1 in ext.split() for fn in get_fullnames(path, ext1)]
	return [fn for fn in glob.glob(path + '*.' + ext.upper()) + glob.glob(path + '*.' + ext.lower())]


if __name__ == '__main__':
	parser = argparse.ArgumentParser(usage = '$0 [options] src_dir src_ext dst_dir dst_ext 1>output 2>progress',
	                                 description = 'copy ROM files from source directory to target directory if the normalized ROM name is not found',
	                                 formatter_class = argparse.ArgumentDefaultsHelpFormatter)
	parser.add_argument('src_dir', help = 'source directory')
	parser.add_argument('src_ext', help = 'source extension(s) delimited by space')
	parser.add_argument('dst_dir', help = 'destination directory')
	parser.add_argument('dst_ext', help = 'desination extension(s) delimited by space')
	parser.add_argument('--norm', '-n', help = 'the Python code for normalizing ROM names from ROM filename',
	                    default = "re.sub(' +', ' ', re.sub('\[.*\]', '', s.rsplit('.',1)[0].replace('!',''))).lower().strip()")
	# nargs='?': optional positional argument; action='append': multiple instances of the arg; type=; default=
	opt = parser.parse_args()
	globals().update(vars(opt))

	src_dir, dst_dir = normalize_dir(src_dir), normalize_dir(dst_dir)
	normalize = lambda s: eval(norm)

	# get destination ROM set
	dst_rom_set = set([normalize(os.path.basename(fn)) for fn in get_fullnames(dst_dir, dst_ext)])

	# main loop
	for fn in get_fullnames(src_dir, src_ext):
		if normalize(os.path.basename(fn)) not in dst_rom_set:
			copyOverFiles(fn, dst_dir)



