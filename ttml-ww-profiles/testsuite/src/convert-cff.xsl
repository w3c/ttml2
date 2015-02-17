<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cff="http://www.decellc.org/schema/2012/01/cff-tt-meta"
    xmlns:itts="http://www.w3.org/ns/ttml/profile/imsc1#styling"
    xmlns:ittp="http://www.w3.org/ns/ttml/profile/imsc1#parameter"
    xmlns:ittm="http://www.w3.org/ns/ttml/profile/imsc1#metadata"
    xmlns:ttm="http://www.w3.org/ns/ttml#metadata"
    xmlns:tts="http://www.w3.org/ns/ttml#styling"
    xmlns:ttp="http://www.w3.org/ns/ttml#parameter"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:smpte="http://www.smpte-ra.org/schemas/2052-1/2010/smpte-tt"
    xmlns:tt="http://www.w3.org/ns/ttml"
    exclude-result-prefixes="cff xsi">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:param name="pngbasename" />
    
    <xsl:template match="comment()"/>
    
    <xsl:template match="@cff:forcedDisplayMode">
        <xsl:attribute name="itts:forcedDisplay"><xsl:value-of select="."/></xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@cff:progressivelyDecodable">
        <xsl:attribute name="ittp:progressivelyDecodable"><xsl:value-of select="."/></xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@smpte:backgroundImage">
        <xsl:attribute name="smpte:backgroundImage"><xsl:value-of select="concat($pngbasename, substring-after(.,'urn:dece:container:subtitleimageindex:'))"/></xsl:attribute>
    </xsl:template>
    
    <xsl:template match="@xsi:schemaLocation"/>
    
    <xsl:template match="processing-instruction('xml-stylesheet')"/>
    
    <xsl:template match="processing-instruction('access-control')"/>
    
    <xsl:template match="ttp:profile"/>
    
    <xsl:template match="@ttp:profile"/>
    
    <xsl:template match="/tt:tt">
        <tt
            xmlns:itts="http://www.w3.org/ns/ttml/profile/imsc1#styling"
            xmlns:ittp="http://www.w3.org/ns/ttml/profile/imsc1#parameter"
            xmlns:ittm="http://www.w3.org/ns/ttml/profile/imsc1#metadata"
            xmlns:ttm="http://www.w3.org/ns/ttml#metadata"
            xmlns:tts="http://www.w3.org/ns/ttml#styling"
            xmlns:ttp="http://www.w3.org/ns/ttml#parameter"
            xmlns:smpte="http://www.smpte-ra.org/schemas/2052-1/2010/smpte-tt"
            xmlns="http://www.w3.org/ns/ttml">
            
            <xsl:apply-templates select="@*"/>
            
            <xsl:apply-templates/>
            
        </tt>
    </xsl:template>
    
    <xsl:template match="*">
        <xsl:element name="{name()}" namespace="{namespace-uri()}">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="@*|text()">
        <xsl:copy/>
    </xsl:template>
    
</xsl:stylesheet>