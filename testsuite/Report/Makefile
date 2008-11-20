SAXON=saxon

main: report

report: report.xslt ../filelist.xml
	$(SAXON) ../filelist.xml report.xslt >report.html
