TEST_SUBDIRS=\
Parameters \
Content \
Styling \
Metadata \
Timing

# Specification

# Layout \
# Animation \

DATE=$(shell date "+%Y%m%d")

TARGET_DIR=$(HOME)/WWW/2008/10/

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
	rm -f dfxp-testsuite.zip
	zip dfxp-testsuite.zip filelist.xml LICENSE
	for DIR in $(TEST_SUBDIRS) ; do \
          for file in $$DIR/*[0-9][0-9][0-9].xml ; do \
	    zip dfxp-testsuite.zip "$$file" ; \
	  done \
	done
	mv dfxp-testsuite.zip $(TARGET_DIR)

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


