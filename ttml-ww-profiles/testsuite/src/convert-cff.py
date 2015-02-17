# lxml must be installed, e.g. using 'pip install lxml'


from lxml import etree
import os
import os.path
import fnmatch
import shutil

indir = '..\\input\\dece-20141120'
outdir = '..\\dece'

selecteddirs = [
"Solekai022_854_29_640x75_MaxSdSubtitle_v7_subtitles",
"Solekai052_1920_23_5x75_Sync_Subs_Img_HD_v7_subtitles",
"Solekai055_640_23_1x1_TimeReps_SD_v7_subtitles",
"Solekai022_854_29_640x75_MaxSdSubtitle_v7_subtitles",
"Solekai023_1920_23_1x1_MaxHdSubtitle_v7_subtitles",
"Solekai044_640_23_1x1_Sync_Subs_Txt_SD_v7_subtitles",
"Solekai045_1920_23_1x1_Sync_Subs_Txt_HD_v7_subtitles",
"Solekai046_640_23_1x1_Sync_Subs_Img_SD_v7_subtitles",
"Solekai047_1920_23_1x1_Sync_Subs_Img_HD_v7_subtitles",
"Solekai049_854_23_426x75_Sync_Subs_Txt_SD_v7_subtitles",
"Solekai050_854_23_426x75_Sync_Subs_Img_SD_v7_subtitles",
"Solekai051_1920_23_5x75_Sync_Subs_Txt_HD_v7_subtitles"
]


transform = etree.XSLT(etree.parse('convert-cff.xsl'))


for dir, dirs, files in os.walk(indir):
	if not (os.path.basename(dir) in selecteddirs):
		continue
	for file in files:
	
		srcfile = os.path.join(dir, file)
		destdir = os.path.join(outdir, os.path.relpath(dir, indir));
		destfile = os.path.join(destdir, file)
		
		if not os.path.exists(destdir):
			os.makedirs(destdir)
	
		if fnmatch.fnmatch(file, '*.ttml'):
			imsc1ttml = transform(etree.parse(srcfile), pngbasename="'" + file[:-6] + "'")
			print(file)
			f = open(destfile, 'wb');
			imsc1ttml.write(f, encoding='UTF-8', xml_declaration=True, pretty_print=True)
			f.close()
		elif fnmatch.fnmatch(file, '*.png'):
			if not os.path.exists(destfile):
				shutil.copyfile(srcfile, destfile)
			