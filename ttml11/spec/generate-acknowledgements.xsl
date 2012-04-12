<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:html="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="html"
  version="1.0">

  <xsl:output
    method="text"
    indent="yes"
    encoding="utf-8"
    />

  <xsl:param name="participating" />

  <xsl:template match="/">
    <xsl:call-template name="list-participants">
      <xsl:with-param name="participating" select="$participating"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="html:tr">
      <xsl:value-of select="html:th[@class='name']/html:a"/>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="html:td[@class='orgname']"/>
      <xsl:text>)</xsl:text>
  </xsl:template>

  <xsl:template name="list-participants">
    <xsl:param name="participating"/>
    <xsl:variable name="status">
      <xsl:choose>
	<xsl:when test="$participating = 1">
	  <xsl:text>good standing</xsl:text>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:text>no longer participating</xsl:text>	  
	</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:for-each select="//html:dl[contains(@class, 'group-member')
			  and contains(normalize-space(html:dd[@class='status']), $status)]">
      <xsl:value-of select="html:dt[@class='foaf-name']"/>
      <xsl:if test="$participating = 1"><xsl:text> (</xsl:text>
      <xsl:value-of select="html:dd[@class='orgname']"/>
      <xsl:text>)</xsl:text></xsl:if>
      <xsl:if test="position()!=last()">
	<xsl:text>, </xsl:text>
      </xsl:if>
      <xsl:if test="position()=last()">
	<xsl:text>.</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
