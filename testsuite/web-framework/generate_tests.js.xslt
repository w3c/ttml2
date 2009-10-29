<?xml version="1.0" ?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tt="http://www.w3.org/ns/ttml"
    xmlns:ttm="http://www.w3.org/ns/ttml#metadata"
    xmlns="http://www.w3.org/1999/xhtml"
    xml:lang="en">

    <xsl:output encoding="utf-8" method="text" />

    <xsl:template match="/">
      <xsl:for-each select='/files/file'>
	<xsl:text>addTest("</xsl:text>
	<xsl:value-of select='concat("../", text())'/>
	<xsl:text>","</xsl:text>
	<xsl:call-template name='filename'>
	  <xsl:with-param name='f' select='text()'/>
	</xsl:call-template>
	<xsl:text>",</xsl:text>
	<xsl:apply-templates select='document(concat("../", text()))/tt:tt' />
	<xsl:text>);
</xsl:text>
      </xsl:for-each>

    </xsl:template>

    <xsl:template name='filename'>
      <xsl:param name='f'/>

      <xsl:choose>
	<xsl:when test='contains($f, "/")'>
	  <xsl:value-of select='substring-before(substring-after($f, "/"), ".")'/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select='substring-before($f, ".")'/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:template>

    <xsl:template match="tt:tt">
      <xsl:text>"</xsl:text>
      <xsl:value-of select='normalize-space(tt:head/tt:metadata/ttm:desc)'/>
      <xsl:text>","</xsl:text>
      <xsl:value-of select='normalize-space(substring-before(tt:head/tt:metadata/ttm:title, "-"))'/>
      <xsl:text>"</xsl:text>
    </xsl:template>

</xsl:stylesheet>
