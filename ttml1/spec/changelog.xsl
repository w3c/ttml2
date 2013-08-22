<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
		xmlns:h="http://www.w3.org/1999/xhtml"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:a="http://www.w3.org/2005/Atom">
    <xsl:template match="a:entry">
        <xsl:if test="a:author/a:name!='@@ADDNAME@@'">
	  <tr>
	    <td>
	      <xsl:value-of select="substring-before(a:published, 'T')"/>
	    </td>
	    <td>
	      <xsl:value-of select="a:author/a:name"/>
	    </td>
	    <td>
	      <xsl:value-of select="a:content/h:div/h:pre"/>
	    </td>
	  </tr>
	</xsl:if>
    </xsl:template>
    <xsl:template match="a:feed">
        <table border="1">
            <tr>
                <th>Date</th>
                <th>Editor</th>
                <th>Description</th>
            </tr>
            <xsl:apply-templates select="a:entry">
                <xsl:sort select="a:published" order="descending"/>
            </xsl:apply-templates>
        </table>
    </xsl:template>
</xsl:stylesheet>
