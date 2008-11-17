
main: filelist

filelist:
	generate_filelist.xml.sh

tests: filelist
	xsltproc generate_tests.js.xslt  filelist.xml > tests.js
