<?xml version="1.0" ?>
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tt="http://www.w3.org/ns/ttml"
    xmlns:tts="http://www.w3.org/ns/ttml#styling" 
    xmlns:ttm="http://www.w3.org/ns/ttml#metadata"
    xmlns:ttp="http://www.w3.org/ns/ttml#parameter"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.w3.org/1999/xhtml"
    xmlns:r='http://www.w3.org/2008/11/dfxp-report'
    xml:lang="en" exclude-result-prefixes='tt tts ttm ttp xs t r'>

    <xsl:output omit-xml-declaration="yes" encoding="utf-8" method="xml" indent='yes'/>

    <xsl:variable name='entries' select='document("spec_toc.xml")'/>

    <xsl:template match="/">
<html>
    <head>
      <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
      <title>DFXP 1.0 test suite coverage</title>
      <link type="text/css" rel="stylesheet" href="report.css" />
      <script type="text/javascript" src='tabs.js'>
//nothing
</script>
    </head>
    <body onload="W3C.init('menu', 'tabs')">
      <xsl:variable name='files' select='/files/file'/>
      <xsl:variable name='tests'>
	<xsl:for-each select='/files/file'>
	  <xsl:apply-templates select='document(text())' mode='copy'/>
	</xsl:for-each>
      </xsl:variable>
      <h1>DFXP 1.0 test suite coverage</h1>

      <ul id='menu' style='display: none'>
	<li>Descriptions</li>
	<li>Features</li>
      </ul>

      <div id='tabs'>
      <div id='descriptions' class='tab'>
<table>
<caption><xsl:text>General description of </xsl:text>
<xsl:value-of select='count(/files/file)'/>
<xsl:text> tests</xsl:text></caption>
<thead>
<tr>
<th>File</th>
<th>Description</th>
</tr>
</thead>
<tbody>
  <xsl:for-each select='$tests/tt:tt'>
    <xsl:variable name='doc_number' select='position()'/>
    <xsl:variable name='doc' select='$files[position()=$doc_number]'/>
    <tr>
      <th><a href='{concat("http://dev.w3.org/cvsweb/~checkout~/2008/tt/testsuite/", $doc, "?content-type=application/xml")}'><xsl:value-of select='tt:head/tt:metadata/ttm:title'/></a></th>
      <td><xsl:value-of select='tt:head/tt:metadata/ttm:desc'/></td>	
    </tr>
  </xsl:for-each>
</tbody>
</table>
<p><a href='dfxp-testsuite.zip'>Zip archives containing all tests</a></p>
      </div>
      <div id="features" class='tab'>
<table>
<caption>DFXP features in use</caption>
<thead>
<tr>
<th>Feature</th>
<th>Section</th>
<th># of tests</th>
<th>Usage</th>
</tr>
</thead>
<tbody>
   <tr>
      <th>ttp:profile</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.1.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttp:profile])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//ttp:profile)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>ttp:features</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.1.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttp:features])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//ttp:features)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>ttp:feature</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.1.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttp:feature])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//ttp:feature)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>ttp:extensions</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.1.4</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttp:extensions])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//ttp:extensions)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>ttp:extension</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.1.5</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttp:extension])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//ttp:extension)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:cellResolution</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:cellResolution[matches(., "^\d+ \d+$")]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:cellResolution[matches(., "^\d+ \d+$")])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:clockMode</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:clockMode])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:clockMode)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:clockMode="local"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:clockMode="local"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:clockMode[.="local"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:clockMode="gps"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:clockMode="gps"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:clockMode[.="gps"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:clockMode="utc"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:clockMode="utc"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:clockMode[.="utc"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:frameRate</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:frameRate[matches(., "^\d+$")]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:frameRate[matches(., "^\d+$")])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:frameRateMultiplier</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.4</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:frameRateMultiplier[matches(., "^\d+(:\d+)?$")]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:frameRateMultiplier[matches(., "^\d+(:\d+)?$")])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:markerMode</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.5</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:markerMode])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:markerMode)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:markerMode="continuous"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.5</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:markerMode="continuous"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:markerMode[.="continuous"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:markerMode="discontinuous"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.5</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:markerMode="discontinuous"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:markerMode[.="discontinuous"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:pixelAspectRatio</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.6</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:pixelAspectRatio[matches(., "^\d+(:\d+)?$")]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:pixelAspectRatio[matches(., "^\d+(:\d+)?$")])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:profile</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.7</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:profile[starts-with(., "http://www.w3.org/ns/ttml#profile-dfxp")]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:profile[starts-with(., "http://www.w3.org/ns/ttml#profile-dfxp")])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:smpteMode</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.8</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:smpteMode])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:smpteMode)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:smpteMode="dropNTSC"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.8</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:smpteMode="dropNTSC"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:smpteMode[.="dropNTSC"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:smpteMode="dropPAL"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.8</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:smpteMode="dropPAL"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:smpteMode[.="dropPAL"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:smpteMode="nonDrop"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.8</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:smpteMode="nonDrop"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:smpteMode[.="nonDrop"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:subFrameRate</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.9</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:subFrameRate])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:subFrameRate)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:subFrameRate</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.9</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:subFrameRate[matches(., "^\d+$")]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:subFrameRate[matches(., "^\d+$")])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:tickRate</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.10</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:tickRate[matches(., "^\d+$")]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:tickRate[matches(., "^\d+$")])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:timeBase</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.11</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:timeBase])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:timeBase)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:timeBase="media"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.11</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:timeBase="media"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:timeBase[.="media"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:timeBase="smpte"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.11</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:timeBase="smpte"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:timeBase[.="smpte"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttp:timeBase="clock"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>6.2.11</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:timeBase="clock"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttp:timeBase[.="clock"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>tt:tt</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>7.1.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt)'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:tt)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>tt:head</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>7.1.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:head])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:head)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>tt:body</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>7.1.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:body])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:body)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>tt:div</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>7.1.4</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:div])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:div)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>tt:p</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>7.1.5</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:p])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:p)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>tt:span</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>7.1.6</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:span])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:span)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>tt:br</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>7.1.7</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:br])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:br)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@xml:id</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>7.2.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@xml:id])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@xml:id)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@xml:lang</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>7.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@xml:lang])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@xml:lang)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@xml:space</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>7.2.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@xml:space])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@xml:space)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@xml:space="default"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>7.2.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@xml:space="default"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@xml:space[.="default"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@xml:space="preserve"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>7.2.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@xml:space="preserve"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@xml:space[.="preserve"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>tt:styling</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.1.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:styling])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:styling)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>tt:style</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.1.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:style])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@style</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@style])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@style)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:backgroundColor</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:backgroundColor])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style/@tts:backgroundColor|$tests//tt:body/@tts:backgroundColor|$tests//tt:div/@tts:backgroundColor|$tests//tt:p/@tts:backgroundColor|$tests//tt:region/@tts:backgroundColor|$tests//tt:span/@tts:backgroundColor)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:backgroundColor="&lt;hash (rgb) color&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:backgroundColor[t:isHRGBColor(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:backgroundColor[t:isHRGBColor(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:backgroundColor="&lt;hash (rgba) color&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:backgroundColor[t:isHRGBAColor(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:backgroundColor[t:isHRGBAColor(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:backgroundColor="&lt;RGB color&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:backgroundColor[t:isRGBColor(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:backgroundColor[t:isRGBColor(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:backgroundColor="&lt;RGBA color&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:backgroundColor[t:isRGBAColor(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:backgroundColor[t:isRGBAColor(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:backgroundColor="&lt;named color&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:backgroundColor[t:isNamedColor(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:backgroundColor[t:isNamedColor(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:color</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:color])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style/@tts:color|$tests//tt:span/@tts:color)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:color="&lt;hash (rgb) color&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:color[t:isHRGBColor(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:color[t:isHRGBColor(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:color="&lt;hash (rgba) color&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:color[t:isHRGBAColor(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:color[t:isHRGBAColor(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:color="&lt;RGB color&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:color[t:isRGBColor(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:color[t:isRGBColor(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:color="&lt;RGBA color&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:color[t:isRGBAColor(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:color[t:isRGBAColor(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:color="&lt;named color&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:color[t:isNamedColor(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:color[t:isNamedColor(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:direction</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.4</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:direction])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style/@tts:direction|$tests//tt:p/@tts:direction|$tests//tt:span/@tts:direction)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:direction="ltr"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.4</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:direction="ltr"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:direction[.="ltr"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:direction="rtl"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.4</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:direction="rtl"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:direction[.="rtl"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:display</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.5</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:display])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:display)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:display="auto"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.5</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:display="auto"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:display[.="auto"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:display="none"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.5</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:display="none"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:display[.="none"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:displayAlign</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.6</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:displayAlign])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style/@tts:displayAlign|$tests//tt:region/@tts:displayAlign)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:displayAlign="before"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.6</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:displayAlign="before"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:displayAlign[.="before"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:displayAlign="center"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.6</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:displayAlign="center"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:displayAlign[.="center"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:displayAlign="after"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.6</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:displayAlign="after"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:displayAlign[.="after"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:dynamicFlow</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.7</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:dynamicFlow])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style/@tts:dynamicFlow|$tests//tt:region/@tts:dynamicFlow)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:dynamicFlow="none"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.7</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:dynamicFlow="none"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:dynamicFlow[.="none"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:dynamicFlow="rollUp"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.7</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:dynamicFlow="rollUp"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:dynamicFlow[.="rollUp"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:dynamicFlow="&lt;flowFunction&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.7</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:dynamicFlow[t:isFlowFunction(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:dynamicFlow[t:isFlowFunction(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:dynamicFlow="(&lt;flowFunction&gt; &lt;flowInternalFunction&gt;+)+"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.7</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:dynamicFlow[t:isDynamicFlow(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:dynamicFlow[t:isDynamicFlow(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:extent</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.8</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:extent])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:tt/@tts:extent|$tests//tt:region/@tts:extent)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:extent="auto"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.8</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:extent="auto"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:extent[.="auto"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:extent="&lt;length&gt; &lt;length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.8</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:extent[t:isDoubleLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:extent[t:isDoubleLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontFamily</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.9</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontFamily])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontFamily)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontFamily="&lt;familyName&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.9</xsl:with-param></xsl:call-template></td>
      <!-- @@TODO I don't handle quotes -->
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontFamily[matches(., "^[-a-zA-Z0-9\s]+$")]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontFamily[matches(., "^[-a-zA-Z0-9\s]+$")])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontFamily="&lt;familyName&gt;(, &lt;familyName&gt;)+"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.9</xsl:with-param></xsl:call-template></td>
      <!-- @@TODO I don't handle quotes -->
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontFamily[matches(., "^[-a-zA-Z0-9\s]+(, [-a-zA-Z0-9\s]+)+$")]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontFamily[matches(., "^[-a-zA-Z0-9\s]+(, [-a-zA-Z0-9\s]+)+$")])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontSize</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.10</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontSize])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontSize)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontSize="&lt;length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.10</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontSize[t:isLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontSize[t:isLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontSize="&lt;% length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.10</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontSize[t:isPercentLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontSize[t:isPercentLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontSize="&lt;px length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.10</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontSize[t:isPxLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontSize[t:isPxLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontSize="&lt;em length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.10</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontSize[t:isEmLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontSize[t:isEmLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontSize="&lt;c length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.10</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontSize[t:isCLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontSize[t:isCLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontSize="&lt;length&gt; &lt;length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.10</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontSize[t:isDoubleLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontSize[t:isDoubleLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontStyle</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.11</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontStyle])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontStyle)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontStyle="normal"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.11</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontStyle="normal"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontStyle[.="normal"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontStyle="italic"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.11</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontStyle="italic"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontStyle[.="italic"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontStyle="oblique"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.11</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontStyle="oblique"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontStyle[.="oblique"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontStyle="reverseOblique"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.11</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontStyle="reverseOblique"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontStyle[.="reverseOblique"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontWeight</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.12</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontWeight])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontWeight)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontWeight="normal"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.12</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontWeight="normal"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontWeight[.="normal"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:fontWeight="bold"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.12</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontWeight="bold"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:fontWeight[.="bold"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:lineHeight</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.13</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:lineHeight])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style/@tts:lineHeight|$tests//tt:p/@tts:lineHeight)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:lineHeight="normal"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.13</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:lineHeight="normal"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:lineHeight[.="normal"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:lineHeight="&lt;length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.13</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:lineHeight[t:isLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:lineHeight[t:isLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:lineHeight="&lt;% length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.13</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:lineHeight[t:isPercentLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:lineHeight[t:isPercentLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:lineHeight="&lt;px length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.13</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:lineHeight[t:isPxLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:lineHeight[t:isPxLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:lineHeight="&lt;em length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.13</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:lineHeight[t:isEmLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:lineHeight[t:isEmLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:lineHeight="&lt;c length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.13</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:lineHeight[t:isCLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:lineHeight[t:isCLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:opacity</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.14</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:opacity])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style/@tts:opacity|$tests//tt:region/@tts:opacity)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:opacity="&lt;alpha&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.14</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:opacity[t:isFloat(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:opacity[t:isFloat(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:origin</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.15</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:origin])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style/@tts:origin|$tests//tt:region/@tts:origin)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:origin="auto"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.15</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:origin="auto"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:origin[.="auto"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:origin="&lt;length&gt; &lt;length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.15</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:origin[t:isDoubleLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:origin[t:isDoubleLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:overflow</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.16</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:overflow])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style/@tts:overflow|$tests//tt:region/@tts:overflow)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:overflow="visible"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.16</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:overflow="visible"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:overflow[.="visible"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:overflow="hidden"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.16</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:overflow="hidden"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:overflow[.="hidden"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:overflow="dynamic"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.16</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:overflow="dynamic"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:overflow[.="dynamic"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:padding</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.17</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style/@tts:padding|$tests//tt:region/@tts:padding)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:padding="&lt;length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.17</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding[t:isLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:padding[t:isLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:padding="&lt;% length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.17</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding[t:isPercentLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:padding[t:isPercentLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:padding="&lt;px length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.17</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding[t:isPxLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:padding[t:isPxLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:padding="&lt;em length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.17</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding[t:isEmLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:padding[t:isEmLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:padding="&lt;c length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.17</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding[t:isCLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:padding[t:isCLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:padding="&lt;length&gt; &lt;length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.17</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding[t:isDoubleLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:padding[t:isDoubleLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:padding="&lt;length&gt; &lt;length&gt; &lt;length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.17</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding[t:isTripleLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:padding[t:isTripleLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:padding="&lt;length&gt; &lt;length&gt; &lt;length&gt; &lt;length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.17</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding[t:isQuadrupleLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:padding[t:isQuadrupleLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:showBackground</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.18</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:showBackground])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style/@tts:showBackground|$tests//tt:region/@tts:showBackground)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:showBackground="always"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.18</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:showBackground="always"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:showBackground[.="always"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:showBackground="whenActive"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.18</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:showBackground="whenActive"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:showBackground[.="whenActive"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textAlign</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.19</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textAlign])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style/@tts:textAlign|$tests//tt:p/@tts:textAlign)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textAlign="left"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.19</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textAlign="left"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textAlign[.="left"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textAlign="center"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.19</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textAlign="center"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textAlign[.="center"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textAlign="right"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.19</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textAlign="right"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textAlign[.="right"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textAlign="start"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.19</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textAlign="start"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textAlign[.="start"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textAlign="end"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.19</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textAlign="end"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textAlign[.="end"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textDecoration</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.20</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textDecoration)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="none"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.20</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="none"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textDecoration[.="none"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="underline"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.20</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="underline"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textDecoration[.="underline"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="noUnderline"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.20</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="noUnderline"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textDecoration[.="noUnderline"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="lineThrough"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.20</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="lineThrough"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textDecoration[.="lineThrough"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="noLineThrough"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.20</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="noLineThrough"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textDecoration[.="noLineThrough"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="overline"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.20</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="overline"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textDecoration[.="overline"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="noOverline"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.20</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="noOverline"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textDecoration[.="noOverline"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="(underline|lineThrough|overline){2}"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.20</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration[matches(., "(underline|lineThrough|overline) (underline|lineThrough|overline)")]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textDecoration[matches(., "(underline|lineThrough|overline) (underline|lineThrough|overline)")])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="(underline|lineThrough|overline){3}"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.20</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration[matches(., "(underline|lineThrough|overline) (underline|lineThrough|overline) (underline|lineThrough|overline)")]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textDecoration[matches(., "(underline|lineThrough|overline) (underline|lineThrough|overline) (underline|lineThrough|overline)")])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textOutline</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.21</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textOutline])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textOutline)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textOutline="none"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.21</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textOutline="none"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textOutline[.="none"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textOutline="&lt;length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.21</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textOutline[t:isLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textOutline[t:isLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textOutline="&lt;length&gt; &lt;length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.21</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textOutline[t:isDoubleLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textOutline[t:isDoubleLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textOutline="&lt;color&gt; &lt;length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.21</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textOutline[t:isColorLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textOutline[t:isColorLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:textOutline="&lt;color&gt; &lt;length&gt; &lt;length&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.21</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textOutline[t:isColorDoubleLength(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:textOutline[t:isColorDoubleLength(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:unicodeBidi</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.22</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:unicodeBidi])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:unicodeBidi)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:unicodeBidi="normal"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.22</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:unicodeBidi="normal"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:unicodeBidi[.="normal"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:unicodeBidi="embed"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.22</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:unicodeBidi="embed"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:unicodeBidi[.="embed"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:unicodeBidi="bidiOverride"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.22</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:unicodeBidi="bidiOverride"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:unicodeBidi[.="bidiOverride"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:visibility</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.23</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:visibility])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:visibility)'/></xsl:call-template></td>
   </tr> 
   <tr>
      <th>@tts:visibility="visible"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.23</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:visibility="visible"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:visibility[.="visible"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:visibility="hidden"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.23</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:visibility="hidden"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:visibility[.="hidden"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:wrapOption</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.24</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:wrapOption])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:wrapOption)'/></xsl:call-template></td>
   </tr> 
   <tr>
      <th>@tts:wrapOption="wrap"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.24</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:wrapOption="wrap"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:wrapOption[.="wrap"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:wrapOption="noWrap"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.24</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:wrapOption="noWrap"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:wrapOption[.="noWrap"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:writingMode</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.25</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style/@tts:writingMode|$tests//tt:region/@tts:writingMode)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:writingMode="lrtb"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.25</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="lrtb"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:writingMode[.="lrtb"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:writingMode="rltb"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.25</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="rltb"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:writingMode[.="rltb"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:writingMode="tbrl"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.25</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="tbrl"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:writingMode[.="tbrl"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:writingMode="tblr"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.25</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="tblr"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:writingMode[.="tblr"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:writingMode="lr"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.25</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="lr"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:writingMode[.="lr"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:writingMode="rl"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.25</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="rl"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:writingMode[.="rl"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:writingMode="tb"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.25</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="tb"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:writingMode[.="tb"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:zIndex</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.26</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:zIndex])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:style/@tts:zIndex|$tests//tt:region/@tts:zIndex)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:zIndex="auto"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.26</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:zIndex="auto"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:zIndex[.="auto"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@tts:zIndex="&lt;integer&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>8.2.26</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:zIndex[matches(., "^(\+|-)?\d+$")]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@tts:zIndex[matches(., "^(\+|-)?\d+$")])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>tt:layout</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>9.1.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:layout])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:layout)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>tt:region</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>9.1.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:region])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:region)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@region</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>9.2.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@region])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@region)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@begin</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@begin)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@begin="&lt;clock-time&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin[t:isClockTime(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@begin[t:isClockTime(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@begin="&lt;offset-time&gt;h"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin[t:isHTime(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@begin[t:isHTime(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@begin="&lt;offset-time&gt;m"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin[t:isMTime(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@begin[t:isMTime(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@begin="&lt;offset-time&gt;s"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin[t:isSTime(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@begin[t:isSTime(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@begin="&lt;offset-time&gt;ms"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin[t:isMSTime(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@begin[t:isMSTime(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@begin="&lt;offset-time&gt;f"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin[t:isFTime(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@begin[t:isFTime(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@begin="&lt;offset-time&gt;t"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin[t:isTTime(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@begin[t:isTTime(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@end</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@end])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@end)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@end="&lt;clock-time&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@end[t:isClockTime(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@end[t:isClockTime(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@end="&lt;offset-time&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@end[t:isOffsetTime(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@end[t:isOffsetTime(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@dur</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@dur])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@dur)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@dur="&lt;clock-time&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@dur[t:isClockTime(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@dur[t:isClockTime(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@dur="&lt;offset-time&gt;"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@dur[t:isOffsetTime(.)]])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@dur[t:isOffsetTime(.)])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@timeContainer</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.4</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@timeContainer])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@timeContainer)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@timeContainer="par"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.4</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@timeContainer="par"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@timeContainer[.="par"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@timeContainer="seq"</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>10.2.4</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@timeContainer="seq"])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@timeContainer[.="seq"])'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>tt:set</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>11.1.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:set])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:set)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>tt:metadata</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>12.1.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:metadata])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//tt:metadata)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>ttm:title</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>12.1.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttm:title])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//ttm:title)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>ttm:desc</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>12.1.3</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttm:desc])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//ttm:desc)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>ttm:copyright</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>12.1.4</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttm:copyright])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//ttm:copyright)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>ttm:agent</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>12.1.5</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttm:agent])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//ttm:agent)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>ttm:name</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>12.1.6</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttm:name])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//ttm:name)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>ttm:actor</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>12.1.7</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttm:actor])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//ttm:actor)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttm:agent</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>12.2.1</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttm:agent])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttm:agent)'/></xsl:call-template></td>
   </tr>
   <tr>
      <th>@ttm:role</th>
      <td><xsl:call-template name='toc'><xsl:with-param name='section'>12.2.2</xsl:with-param></xsl:call-template></td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttm:role])'/></td>
      <td><xsl:call-template name='display'><xsl:with-param name='n' select='count($tests//@ttm:role)'/></xsl:call-template></td>
   </tr> </tbody>
</table>
      </div>
      </div>
    </body>
</html>
    </xsl:template>

    <xsl:template name='toc'>
      <xsl:param name='section'/>
      <a>
	<xsl:attribute name='href'>
	  <xsl:value-of select='resolve-uri($entries//r:entry[@section=$section]/@href, $entries/r:entries/@xml:base)' />
	</xsl:attribute>
	<xsl:value-of select='$section'/>
      </a>
    </xsl:template>

    <xsl:template name='display'>
      <xsl:param name='n'/>
      <xsl:choose>
	<xsl:when test='$n = 0'>
	  <xsl:attribute name='class'>notest</xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name='class'>gotest</xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select='$n'/>
    </xsl:template>

    <xsl:template match="@*|node()">
      <xsl:copy>
	<xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
    </xsl:template>

    <xsl:template match="@*|node()" mode='copy'>
      <xsl:copy>
	<xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
    </xsl:template>

    <xsl:function name="t:isFloat" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^(NaN|(-?(INF|\d+(\.\d+)?((E|e)\d+)?)))$")'/> 
    </xsl:function>

    <xsl:function name="t:isColor" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <!-- doesn't check the 0-255 range -->
      <xsl:value-of select='matches($s, "^((#[0-9A-Fa-f]{6}([0-9A-Fa-f]{2})?)|rgb\(\d+,\d+,\d+\)|rgba\(\d+,\d+,\d+,\d+\)|transparent|black|silver|gray|white|maroon|red|purple|fuchsia|magenta|green|lime|olive|yellow|navy|blue|teal|aqua|cyan)$")'/> 
    </xsl:function>

    <xsl:function name="t:isHRGBColor" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^#[0-9A-Fa-f]{6}$")'/> 
    </xsl:function>

    <xsl:function name="t:isHRGBAColor" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^#[0-9A-Fa-f]{8}$")'/> 
    </xsl:function>

    <xsl:function name="t:isRGBColor" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <!-- doesn't check the 0-255 range -->
      <xsl:value-of select='matches($s, "^rgb\(\d+,\d+,\d+\)$")'/> 
    </xsl:function>

    <xsl:function name="t:isRGBAColor" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <!-- doesn't check the 0-255 range -->
      <xsl:value-of select='matches($s, "^rgba\(\d+,\d+,\d+,\d+\)$")'/> 
    </xsl:function>

    <xsl:function name="t:isNamedColor" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^(transparent|black|silver|gray|white|maroon|red|purple|fuchsia|magenta|green|lime|olive|yellow|navy|blue|teal|aqua|cyan)$")'/> 
    </xsl:function>

    <xsl:function name="t:isDuration" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^\d(\.\d)?(s|ms|f|t)$")'/> 
    </xsl:function>

    <xsl:function name="t:isFlowFunction" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^((in|out)\((glyph|line|character|word)(,(jump|smooth))?\))+$")'/> 

    </xsl:function>

    <xsl:function name="t:isDynamicFlow" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^((in|out)\((glyph|line|character|word)(,(jump|smooth))?\)((fill|clear)\((auto|break|\d(\.\d)?(s|ms|f|t)?)(,\d(\.\d)?(s|ms|f|t))?\))+)+$")'/> 

    </xsl:function>

    <xsl:function name="t:isLength" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^(\+|-)?\d+(\.\d+)?(px|em|c|%)$")'/>
    </xsl:function>
    <xsl:function name="t:isPxLength" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^(\+|-)?\d+(\.\d+)?px$")'/>
    </xsl:function>
    <xsl:function name="t:isPercentLength" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^(\+|-)?\d+(\.\d+)?%$")'/>
    </xsl:function>
    <xsl:function name="t:isEmLength" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^(\+|-)?\d+(\.\d+)?em$")'/>
    </xsl:function>
    <xsl:function name="t:isCLength" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^(\+|-)?\d+(\.\d+)?c$")'/>
    </xsl:function>
    <xsl:function name="t:isDoubleLength" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^(\+|-)?\d+(\.\d+)?(px|em|c|%) (\+|-)?\d+(\.\d+)?(px|em|c|%)$")'/>
    </xsl:function>
    <xsl:function name="t:isTripleLength" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^(\+|-)?\d+(\.\d+)?(px|em|c|%) (\+|-)?\d+(\.\d+)?(px|em|c|%) (\+|-)?\d+(\.\d+)?(px|em|c|%)$")'/>
    </xsl:function>
    <xsl:function name="t:isQuadrupleLength" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^(\+|-)?\d+(\.\d+)?(px|em|c|%) (\+|-)?\d+(\.\d+)?(px|em|c|%) (\+|-)?\d+(\.\d+)?(px|em|c|%) (\+|-)?\d+(\.\d+)?(px|em|c|%)$")'/>
    </xsl:function>

    <xsl:function name="t:isColorLength" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <!-- doesn't check the 0-255 range -->
      <xsl:value-of select='matches($s, "^((#[0-9A-Fa-f]{6}([0-9A-Fa-f]{2})?)|rgb\(\d+,\d+,\d+\)|rgba\(\d+,\d+,\d+,\d+\)|transparent|black|silver|gray|white|maroon|red|purple|fuchsia|magenta|green|lime|olive|yellow|navy|blue|teal|aqua|cyan) (\+|-)?\d+(\.\d+)?(px|em|c|%)$")'/> 
    </xsl:function>
    <xsl:function name="t:isColorDoubleLength" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <!-- doesn't check the 0-255 range -->
      <xsl:value-of select='matches($s, "^((#[0-9A-Fa-f]{6}([0-9A-Fa-f]{2})?)|rgb\(\d+,\d+,\d+\)|rgba\(\d+,\d+,\d+,\d+\)|transparent|black|silver|gray|white|maroon|red|purple|fuchsia|magenta|green|lime|olive|yellow|navy|blue|teal|aqua|cyan) (\+|-)?\d+(\.\d+)?(px|em|c|%) (\+|-)?\d+(\.\d+)?(px|em|c|%)$")'/> 
    </xsl:function>

    <xsl:function name="t:isTimeExpression" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>
      <xsl:value-of select='matches($s, "^(\d+(\.\d+)?(h|m|s|ms|f|t)|\d\d\d*:\d\d:\d\d(\.\d+|:\d\d\d*(\.\d+)?)?)$")'/> 
    </xsl:function>
    <xsl:function name="t:isClockTime" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>
      <xsl:value-of select='matches($s, "^\d\d\d*:\d\d:\d\d(\.\d+|:\d\d\d*(\.\d+)?)?$")'/> 
    </xsl:function>
    <xsl:function name="t:isOffsetTime" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>
      <xsl:value-of select='matches($s, "^\d+(\.\d+)?(h|m|s|ms|f|t)$")'/> 
    </xsl:function>
    <xsl:function name="t:isHTime" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>
      <xsl:value-of select='matches($s, "^\d+(\.\d+)?h$")'/> 
    </xsl:function>
    <xsl:function name="t:isMTime" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>
      <xsl:value-of select='matches($s, "^\d+(\.\d+)?m$")'/> 
    </xsl:function>
    <xsl:function name="t:isSTime" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>
      <xsl:value-of select='matches($s, "^\d+(\.\d+)?s$")'/> 
    </xsl:function>
    <xsl:function name="t:isMSTime" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>
      <xsl:value-of select='matches($s, "^\d+(\.\d+)?ms$")'/> 
    </xsl:function>
    <xsl:function name="t:isFTime" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>
      <xsl:value-of select='matches($s, "^\d+(\.\d+)?f$")'/> 
    </xsl:function>
    <xsl:function name="t:isTTime" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>
      <xsl:value-of select='matches($s, "^\d+(\.\d+)?t$")'/> 
    </xsl:function>


</xsl:stylesheet>
