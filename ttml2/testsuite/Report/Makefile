SAXON=saxon

TARGET_REPORT=$(HOME)/WWW/2008/10/dfxp-test-coverage.html

main: report

report: report.xslt ../filelist.xml
	$(SAXON) ../filelist.xml report.xslt >report.html

publish: report.html
	cp report.html $(TARGET_REPORT)
	regreplace 'href="../' 'href="http://dev.w3.org/cvsweb/~checkout~/2008/tt/testsuite/'  $(TARGET_REPORT)
	regreplace '.xml">' '.xml?content-type=application/xml">'  $(TARGET_REPORT)
