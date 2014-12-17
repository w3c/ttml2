# lxml must be installed, e.g. using 'pip install lxml'


from lxml import etree
import os
import os.path
import fnmatch
import shutil

indir = '..\\input\\dece-20141120'
outdir = '..\\dece'

transform = etree.XSLT(etree.parse('convert-cff.xsl'))


for dir, dirs, files in os.walk(indir):
	for file in files:
	
		srcfile = os.path.join(dir, file)
		destdir = os.path.join(outdir, os.path.relpath(dir, indir));
		destfile = os.path.join(destdir, file)
		
		if not os.path.exists(destdir):
			os.makedirs(destdir)
	
		if fnmatch.fnmatch(file, '*.ttml'):
			imsc1ttml = transform(etree.parse(srcfile))
			print(file)
			f = open(destfile, 'wb');
			imsc1ttml.write(f, encoding='UTF-8', xml_declaration=True, pretty_print=True)
			f.close()
		elif fnmatch.fnmatch(file, '*.png'):
			if not os.path.exists(destfile):
				shutil.copyfile(srcfile, destfile)
			