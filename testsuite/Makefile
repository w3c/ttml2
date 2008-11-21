TEST_SUBDIRS=\
Parameters \
Content \
Styling \
Layout \
Timing \
Animation \
Metadata \
Specification

DATE=$(shell date "+%Y%m%d")

main: filelist archive

filelist:
	echo "<files>" > filelist.xml
	for DIR in $(TEST_SUBDIRS) ; do \
          for file in $$DIR/*[0-9][0-9][0-9].xml ; do \
	    echo "<file>$$file</file>" >>filelist.xml ; \
	  done \
	done
	echo "</files>" >>filelist.xml

archive: filelist
	rm -f testsuite.zip
	zip testsuite.zip filelist.xml LICENSE
	for DIR in $(TEST_SUBDIRS) ; do \
          for file in $$DIR/*[0-9][0-9][0-9].xml ; do \
	    zip testsuite.zip "$$file" ; \
	  done \
	done

release: archive
	cp testsuite.zip testsuite-$(DATE).zip

release-framework: filelist
	rm -f testsuite-and-framework.zip
	zip testsuite-and-framework.zip filelist.xml LICENSE
	for DIR in $(TEST_SUBDIRS) ; do \
          for file in $$DIR/*[0-9][0-9][0-9].xml ; do \
	    zip testsuite-and-framework.zip "$$file" ; \
	  done \
	done
	for file in web-framework/*.js web-framework/*.css web-framework/*.html web-framework/*.flv web-framework/README ; do \
	  zip testsuite-and-framework.zip "$$file" ; \
	done


