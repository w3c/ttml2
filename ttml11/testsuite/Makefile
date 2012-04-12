TEST_SUBDIRS=\
Parameters \
Content \
Styling \
Metadata \
Timing \
Animation

# Specification

# Layout \

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

validate-rnc:
	@rm -f validate-report-rnc.txt
	@echo "Validating with RNC Schema"
	@for DIR in $(TEST_SUBDIRS) ; do \
	  echo Checking $$DIR ... ; \
	  java -jar ../spec/jing/jing.jar -c ../spec/rnc/ttaf1-dfxp.rnc $$DIR/*[0-9][0-9][0-9].xml >>validate-report-rnc.txt ; \
	done

validate-xsd:
	@rm -f validate-report-xsd.txt
	@echo "Validating with XSD Schema"
	@for DIR in $(TEST_SUBDIRS) ; do \
	  echo Checking $$DIR ... ; \
	  java -jar ../spec/jing/jing.jar ../spec/xsd/ttaf1-dfxp.xsd $$DIR/*[0-9][0-9][0-9].xml >>validate-report-xsd.txt ; \
	done

validate: validate-rnc validate-xsd

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


