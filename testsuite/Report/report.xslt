<?xml version="1.0" ?>
<xsl:stylesheet
    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tt="http://www.w3.org/2006/10/ttaf1"
    xmlns:tts="http://www.w3.org/2006/10/ttaf1#style" 
    xmlns:ttm="http://www.w3.org/2006/10/ttaf1#metadata"
    xmlns:ttp="http://www.w3.org/2006/10/ttaf1#parameter"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.w3.org/1999/xhtml"
    xml:lang="en">

    <xsl:output omit-xml-declaration="no" encoding="utf-8" method="xml" indent='yes'/>

    <xsl:template match="/">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <title>DFXP test suite coverage</title>
    <link rel="stylesheet" href="http://www.w3.org/StyleSheets/TR/base.css" />
    <style type='text/css'>
caption { font-size: 120%; text-align: left; margin-top: 2em; }
table {border-collapse: collapse; }
td, th { border: 1px solid black; padding: 1px}
tbody th { text-align: left; }
thead th { background: #ccc; }
table { font-size: 90%; margin-top: 2em; }
    </style>
    </head>
    <body>
      <xsl:variable name='tests'>
	<xsl:for-each select='/files/file'>
	  <xsl:apply-templates select='document(text())' mode='copy'/>
	</xsl:for-each>
      </xsl:variable>
      <h1>DFXP test suite coverage</h1>

<table id='descriptions'>
<caption>General description of the tests</caption>
<thead>
<tr>
<th>File</th>
<th>Description</th>
</tr>
</thead>
<tbody>
  <xsl:apply-templates select='$tests/tt:tt'/>
</tbody>
</table>

<table id='features'>
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
      <th>@ttp:cellResolution</th>
      <td>6.2.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:cellResolution[matches(., "^\d+ \d+$")]])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:cellResolution[matches(., "^\d+ \d+$")])'/></td>
   </tr>
   <tr>
      <th>@ttp:clockMode</th>
      <td>6.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:clockMode])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:clockMode)'/></td>
   </tr>
   <tr>
      <th>@ttp:clockMode="local"</th>
      <td>6.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:clockMode="local"])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:clockMode[.="local"])'/></td>
   </tr>
   <tr>
      <th>@ttp:clockMode="gps"</th>
      <td>6.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:clockMode="gps"])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:clockMode[.="gps"])'/></td>
   </tr>
   <tr>
      <th>@ttp:clockMode="utc"</th>
      <td>6.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:clockMode="utc"])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:clockMode[.="utc"])'/></td>
   </tr>
   <tr>
      <th>@ttp:frameRate</th>
      <td>6.2.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:frameRate[matches(., "^\d+$")]])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:frameRate[matches(., "^\d+$")])'/></td>
   </tr>
   <tr>
      <th>@ttp:frameRateMultiplier</th>
      <td>6.2.4</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:frameRateMultiplier[matches(., "^\d+(:\d+)?$")]])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:frameRateMultiplier[matches(., "^\d+(:\d+)?$")])'/></td>
   </tr>
   <tr>
      <th>@ttp:markerMode</th>
      <td>6.2.5</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:markerMode])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:markerMode)'/></td>
   </tr>
   <tr>
      <th>@ttp:markerMode="continuous"</th>
      <td>6.2.5</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:markerMode="continuous"])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:markerMode[.="continuous"])'/></td>
   </tr>
   <tr>
      <th>@ttp:markerMode="discontinuous"</th>
      <td>6.2.5</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:markerMode="discontinuous"])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:markerMode[.="discontinuous"])'/></td>
   </tr>
   <tr>
      <th>@ttp:pixelAspectRatio</th>
      <td>6.2.6</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:pixelAspectRatio[matches(., "^\d+(:\d+)?$")]])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:pixelAspectRatio[matches(., "^\d+(:\d+)?$")])'/></td>
   </tr>
   <tr>
      <th>@ttp:profile</th>
      <td>6.2.7</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:profile[starts-with(., "http://www.w3.org/2006/10/ttaf1#profile-dfxp")]])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:profile[starts-with(., "http://www.w3.org/2006/10/ttaf1#profile-dfxp")])'/></td>
   </tr>
   <tr>
      <th>@ttp:smpteMode</th>
      <td>6.2.8</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:smpteMode])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:smpteMode)'/></td>
   </tr>
   <tr>
      <th>@ttp:smpteMode="dropNTSC"</th>
      <td>6.2.8</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:smpteMode="dropNTSC"])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:smpteMode[.="dropNTSC"])'/></td>
   </tr>
   <tr>
      <th>@ttp:smpteMode="dropPAL"</th>
      <td>6.2.8</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:smpteMode="dropPAL"])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:smpteMode[.="dropPAL"])'/></td>
   </tr>
   <tr>
      <th>@ttp:smpteMode="nonDrop"</th>
      <td>6.2.8</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:smpteMode="nonDrop"])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:smpteMode[.="nonDrop"])'/></td>
   </tr>
   <tr>
      <th>@ttp:subFrameRate</th>
      <td>6.2.9</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:subFrameRate])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:subFrameRate)'/></td>
   </tr>
   <tr>
      <th>@ttp:subFrameRate</th>
      <td>6.2.9</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:subFrameRate[matches(., "^\d+$")]])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:subFrameRate[matches(., "^\d+$")])'/></td>
   </tr>
   <tr>
      <th>@ttp:tickRate</th>
      <td>6.2.10</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:tickRate[matches(., "^\d+$")]])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:tickRate[matches(., "^\d+$")])'/></td>
   </tr>
   <tr>
      <th>@ttp:timeBase</th>
      <td>6.2.11</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:timeBase])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:timeBase)'/></td>
   </tr>
   <tr>
      <th>@ttp:timeBase="media"</th>
      <td>6.2.11</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:timeBase="media"])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:timeBase[.="media"])'/></td>
   </tr>
   <tr>
      <th>@ttp:timeBase="smpte"</th>
      <td>6.2.11</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:timeBase="smpte"])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:timeBase[.="smpte"])'/></td>
   </tr>
   <tr>
      <th>@ttp:timeBase="clock"</th>
      <td>6.2.11</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttp:timeBase="clock"])'/></td>
      <td><xsl:value-of select='count($tests//@ttp:timeBase[.="clock"])'/></td>
   </tr>
   <tr>
      <th>tt:tt</th>
      <td>7.1.1</td>
      <td><xsl:value-of select='count($tests/tt:tt)'/></td>
      <td><xsl:value-of select='count($tests//tt:tt)'/></td>
   </tr>
   <tr>
      <th>tt:head</th>
      <td>7.1.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:head])'/></td>
      <td><xsl:value-of select='count($tests//tt:head)'/></td>
   </tr>
   <tr>
      <th>tt:body</th>
      <td>7.1.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:body])'/></td>
      <td><xsl:value-of select='count($tests//tt:body)'/></td>
   </tr>
   <tr>
      <th>tt:div</th>
      <td>7.1.4</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:div])'/></td>
      <td><xsl:value-of select='count($tests//tt:div)'/></td>
   </tr>
   <tr>
      <th>tt:p</th>
      <td>7.1.5</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:p])'/></td>
      <td><xsl:value-of select='count($tests//tt:p)'/></td>
   </tr>
   <tr>
      <th>tt:span</th>
      <td>7.1.6</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:span])'/></td>
      <td><xsl:value-of select='count($tests//tt:span)'/></td>
   </tr>
   <tr>
      <th>tt:br</th>
      <td>7.1.7</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:br])'/></td>
      <td><xsl:value-of select='count($tests//tt:br)'/></td>
   </tr>
   <tr>
      <th>@xml:id</th>
      <td>7.2.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@xml:id])'/></td>
      <td><xsl:value-of select='count($tests//@xml:id)'/></td>
   </tr>
   <tr>
      <th>@xml:lang</th>
      <td>7.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@xml:lang])'/></td>
      <td><xsl:value-of select='count($tests//@xml:lang)'/></td>
   </tr>
   <tr>
      <th>@xml:space</th>
      <td>7.2.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@xml:space])'/></td>
      <td><xsl:value-of select='count($tests//@xml:space)'/></td>
   </tr>
   <tr>
      <th>@xml:space="default"</th>
      <td>7.2.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@xml:space="default"])'/></td>
      <td><xsl:value-of select='count($tests//@xml:space[.="default"])'/></td>
   </tr>
   <tr>
      <th>@xml:space="preserve"</th>
      <td>7.2.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@xml:space="preserve"])'/></td>
      <td><xsl:value-of select='count($tests//@xml:space[.="preserve"])'/></td>
   </tr>
   <tr>
      <th>tt:styling</th>
      <td>8.1.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:styling])'/></td>
      <td><xsl:value-of select='count($tests//tt:styling)'/></td>
   </tr>
   <tr>
      <th>tt:style</th>
      <td>8.1.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:style])'/></td>
      <td><xsl:value-of select='count($tests//tt:style)'/></td>
   </tr>
   <tr>
      <th>@style</th>
      <td>8.2.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@style])'/></td>
      <td><xsl:value-of select='count($tests//@style)'/></td>
   </tr>
   <tr>
      <th>@tts:backgroundColor</th>
      <td>8.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:backgroundColor])'/></td>
      <td><xsl:value-of select='count($tests//@tts:backgroundColor)'/></td>
   </tr>
   <tr>
      <th>@tts:backgroundColor="&lt;hash (rgb) color&gt;"</th>
      <td>8.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:backgroundColor[t:isHRGBColor(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:backgroundColor[t:isHRGBColor(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:backgroundColor="&lt;hash (rgba) color&gt;"</th>
      <td>8.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:backgroundColor[t:isHRGBAColor(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:backgroundColor[t:isHRGBAColor(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:backgroundColor="&lt;RGB color&gt;"</th>
      <td>8.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:backgroundColor[t:isRGBColor(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:backgroundColor[t:isRGBColor(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:backgroundColor="&lt;RGBA color&gt;"</th>
      <td>8.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:backgroundColor[t:isRGBAColor(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:backgroundColor[t:isRGBAColor(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:backgroundColor="&lt;named color&gt;"</th>
      <td>8.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:backgroundColor[t:isNamedColor(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:backgroundColor[t:isNamedColor(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:backgroundColor="inherit"</th>
      <td>8.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:backgroundColor="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:backgroundColor[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:color</th>
      <td>8.2.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:color])'/></td>
      <td><xsl:value-of select='count($tests//@tts:color)'/></td>
   </tr>
   <tr>
      <th>@tts:color="&lt;hash (rgb) color&gt;"</th>
      <td>8.2.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:color[t:isHRGBColor(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:color[t:isHRGBColor(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:color="&lt;hash (rgba) color&gt;"</th>
      <td>8.2.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:color[t:isHRGBAColor(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:color[t:isHRGBAColor(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:color="&lt;RGB color&gt;"</th>
      <td>8.2.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:color[t:isRGBColor(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:color[t:isRGBColor(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:color="&lt;RGBA color&gt;"</th>
      <td>8.2.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:color[t:isRGBAColor(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:color[t:isRGBAColor(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:color="&lt;named color&gt;"</th>
      <td>8.2.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:color[t:isNamedColor(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:color[t:isNamedColor(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:color="inherit"</th>
      <td>8.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:color="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:color[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:direction</th>
      <td>8.2.4</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:direction])'/></td>
      <td><xsl:value-of select='count($tests//@tts:direction)'/></td>
   </tr>
   <tr>
      <th>@tts:direction="ltr"</th>
      <td>8.2.4</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:direction="ltr"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:direction[.="ltr"])'/></td>
   </tr>
   <tr>
      <th>@tts:direction="rtl"</th>
      <td>8.2.4</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:direction="rtl"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:direction[.="rtl"])'/></td>
   </tr>
   <tr>
      <th>@tts:direction="inherit"</th>
      <td>8.2.4</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:direction="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:direction[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:display</th>
      <td>8.2.5</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:display])'/></td>
      <td><xsl:value-of select='count($tests//@tts:display)'/></td>
   </tr>
   <tr>
      <th>@tts:display="auto"</th>
      <td>8.2.5</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:display="auto"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:display[.="auto"])'/></td>
   </tr>
   <tr>
      <th>@tts:display="none"</th>
      <td>8.2.5</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:display="none"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:display[.="none"])'/></td>
   </tr>
   <tr>
      <th>@tts:display="inherit"</th>
      <td>8.2.5</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:display="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:display[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:displayAlign</th>
      <td>8.2.6</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:displayAlign])'/></td>
      <td><xsl:value-of select='count($tests//@tts:displayAlign)'/></td>
   </tr>
   <tr>
      <th>@tts:displayAlign="before"</th>
      <td>8.2.6</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:displayAlign="before"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:displayAlign[.="before"])'/></td>
   </tr>
   <tr>
      <th>@tts:displayAlign="center"</th>
      <td>8.2.6</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:displayAlign="center"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:displayAlign[.="center"])'/></td>
   </tr>
   <tr>
      <th>@tts:displayAlign="after"</th>
      <td>8.2.6</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:displayAlign="after"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:displayAlign[.="after"])'/></td>
   </tr>
   <tr>
      <th>@tts:displayAlign="inherit"</th>
      <td>8.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:displayAlign="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:displayAlign[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:dynamicFlow</th>
      <td>8.2.7</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:dynamicFlow])'/></td>
      <td><xsl:value-of select='count($tests//@tts:dynamicFlow)'/></td>
   </tr>
   <tr>
      <th>@tts:dynamicFlow="none"</th>
      <td>8.2.7</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:dynamicFlow="none"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:dynamicFlow[.="none"])'/></td>
   </tr>
   <tr>
      <th>@tts:dynamicFlow="&lt;flowFunction&gt;"</th>
      <td>8.2.7</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:dynamicFlow[t:isFlowFunction(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:dynamicFlow[t:isFlowFunction(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:dynamicFlow="&lt;flowFunction&gt;+ &lt;flowInternalFunction&gt;+"</th>
      <td>8.2.7</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:dynamicFlow[t:isDynamicFlow(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:dynamicFlow[t:isDynamicFlow(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:extent</th>
      <td>8.2.8</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:extent])'/></td>
      <td><xsl:value-of select='count($tests//@tts:extent)'/></td>
   </tr>
   <tr>
      <th>@tts:extent="auto"</th>
      <td>8.2.8</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:extent="auto"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:extent[.="auto"])'/></td>
   </tr>
   <tr>
      <th>@tts:extent="&lt;length&gt; &lt;length&gt;"</th>
      <td>8.2.8</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:extent[t:isDoubleLength(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:extent[t:isDoubleLength(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:extent="inherit"</th>
      <td>8.2.8</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:extent="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:extent[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:fontFamily</th>
      <td>8.2.9</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontFamily])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontFamily)'/></td>
   </tr>
   <tr>
      <th>@tts:fontFamily="&lt;familyName&gt;"</th>
      <td>8.2.9</td>
      <!-- @@TODO I don't handle quotes -->
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontFamily[matches(., "^[-a-zA-Z0-9\s]+$")]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontFamily[matches(., "^[-a-zA-Z0-9\s]+$")])'/></td>
   </tr>
   <tr>
      <th>@tts:fontFamily="&lt;familyName&gt;(, &lt;familyName&gt;)+"</th>
      <td>8.2.9</td>
      <!-- @@TODO I don't handle quotes -->
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontFamily[matches(., "^[-a-zA-Z0-9\s]+(, [-a-zA-Z0-9\s]+)+$")]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontFamily[matches(., "^[-a-zA-Z0-9\s]+(, [-a-zA-Z0-9\s]+)+$")])'/></td>
   </tr>
   <tr>
      <th>@tts:fontSize</th>
      <td>8.2.10</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontSize])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontSize)'/></td>
   </tr>
   <tr>
      <th>@tts:fontSize="&lt;length&gt;"</th>
      <td>8.2.10</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontSize[t:isLength(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontSize[t:isLength(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:fontSize="&lt;length&gt; &lt;length&gt;"</th>
      <td>8.2.10</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontSize[t:isDoubleLength(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontSize[t:isDoubleLength(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:fontSize="inherit"</th>
      <td>8.2.10</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontSize="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontSize[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:fontStyle</th>
      <td>8.2.11</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontStyle])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontStyle)'/></td>
   </tr>
   <tr>
      <th>@tts:fontStyle="normal"</th>
      <td>8.2.11</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontStyle="normal"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontStyle[.="normal"])'/></td>
   </tr>
   <tr>
      <th>@tts:fontStyle="italic"</th>
      <td>8.2.11</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontStyle="italic"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontStyle[.="italic"])'/></td>
   </tr>
   <tr>
      <th>@tts:fontStyle="oblique"</th>
      <td>8.2.11</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontStyle="oblique"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontStyle[.="oblique"])'/></td>
   </tr>
   <tr>
      <th>@tts:fontStyle="reverseOblique"</th>
      <td>8.2.11</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontStyle="reverseOblique"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontStyle[.="reverseOblique"])'/></td>
   </tr>
   <tr>
      <th>@tts:fontStyle="inherit"</th>
      <td>8.2.11</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontStyle="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontStyle[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:fontWeight</th>
      <td>8.2.12</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontWeight])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontWeight)'/></td>
   </tr>
   <tr>
      <th>@tts:fontWeight="normal"</th>
      <td>8.2.12</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontWeight="normal"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontWeight[.="normal"])'/></td>
   </tr>
   <tr>
      <th>@tts:fontWeight="bold"</th>
      <td>8.2.12</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontWeight="bold"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontWeight[.="bold"])'/></td>
   </tr>
   <tr>
      <th>@tts:fontWeight="inherit"</th>
      <td>8.2.12</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:fontWeight="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:fontWeight[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:lineHeight</th>
      <td>8.2.13</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:lineHeight])'/></td>
      <td><xsl:value-of select='count($tests//@tts:lineHeight)'/></td>
   </tr>
   <tr>
      <th>@tts:lineHeight="normal"</th>
      <td>8.2.13</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:lineHeight="normal"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:lineHeight[.="normal"])'/></td>
   </tr>
   <tr>
      <th>@tts:lineHeight="&lt;length&gt;"</th>
      <td>8.2.13</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:lineHeight[t:isLength(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:lineHeight[t:isLength(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:lineHeight="inherit"</th>
      <td>8.2.13</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:lineHeight="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:lineHeight[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:opacity</th>
      <td>8.2.14</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:opacity])'/></td>
      <td><xsl:value-of select='count($tests//@tts:opacity)'/></td>
   </tr>
   <tr>
      <th>@tts:opacity="&lt;alpha&gt;"</th>
      <td>8.2.14</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:opacity[t:isFloat(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:opacity[t:isFloat(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:opacity="inherit"</th>
      <td>8.2.14</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:opacity="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:opacity[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:origin</th>
      <td>8.2.15</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:origin])'/></td>
      <td><xsl:value-of select='count($tests//@tts:origin)'/></td>
   </tr>
   <tr>
      <th>@tts:origin="auto"</th>
      <td>8.2.15</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:origin="auto"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:origin[.="auto"])'/></td>
   </tr>
   <tr>
      <th>@tts:origin="&lt;length&gt; &lt;length&gt;"</th>
      <td>8.2.15</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:origin[t:isDoubleLength(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:origin[t:isDoubleLength(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:origin="inherit"</th>
      <td>8.2.15</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:origin="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:origin[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:overflow</th>
      <td>8.2.16</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:overflow])'/></td>
      <td><xsl:value-of select='count($tests//@tts:overflow)'/></td>
   </tr>
   <tr>
      <th>@tts:overflow="visible"</th>
      <td>8.2.16</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:overflow="visible"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:overflow[.="visible"])'/></td>
   </tr>
   <tr>
      <th>@tts:overflow="hidden"</th>
      <td>8.2.16</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:overflow="hidden"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:overflow[.="hidden"])'/></td>
   </tr>
   <tr>
      <th>@tts:overflow="scroll"</th>
      <td>8.2.16</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:overflow="scroll"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:overflow[.="scroll"])'/></td>
   </tr>
   <tr>
      <th>@tts:overflow="inherit"</th>
      <td>8.2.16</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:overflow="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:overflow[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:padding</th>
      <td>8.2.17</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding])'/></td>
      <td><xsl:value-of select='count($tests//@tts:padding)'/></td>
   </tr>
   <tr>
      <th>@tts:padding="&lt;length&gt;"</th>
      <td>8.2.17</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding[t:isLength(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:padding[t:isLength(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:padding="&lt;length&gt; &lt;length&gt;"</th>
      <td>8.2.17</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding[t:isDoubleLength(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:padding[t:isDoubleLength(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:padding="&lt;length&gt; &lt;length&gt; &lt;length&gt;"</th>
      <td>8.2.17</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding[t:isTripleLength(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:padding[t:isTripleLength(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:padding="&lt;length&gt; &lt;length&gt; &lt;length&gt; &lt;length&gt;"</th>
      <td>8.2.17</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding[t:isQuadrupleLength(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:padding[t:isQuadrupleLength(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:padding="inherit"</th>
      <td>8.2.17</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:padding="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:padding[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:showBackground</th>
      <td>8.2.18</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:showBackground])'/></td>
      <td><xsl:value-of select='count($tests//@tts:showBackground)'/></td>
   </tr>
   <tr>
      <th>@tts:showBackground="always"</th>
      <td>8.2.18</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:showBackground="always"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:showBackground[.="always"])'/></td>
   </tr>
   <tr>
      <th>@tts:showBackground="whenActive"</th>
      <td>8.2.18</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:showBackground="whenActive"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:showBackground[.="whenActive"])'/></td>
   </tr>
   <tr>
      <th>@tts:showBackground="inherit"</th>
      <td>8.2.18</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:showBackground="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:showBackground[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:textAlign</th>
      <td>8.2.19</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textAlign])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textAlign)'/></td>
   </tr>
   <tr>
      <th>@tts:textAlign="left"</th>
      <td>8.2.19</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textAlign="left"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textAlign[.="left"])'/></td>
   </tr>
   <tr>
      <th>@tts:textAlign="center"</th>
      <td>8.2.19</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textAlign="center"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textAlign[.="center"])'/></td>
   </tr>
   <tr>
      <th>@tts:textAlign="right"</th>
      <td>8.2.19</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textAlign="right"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textAlign[.="right"])'/></td>
   </tr>
   <tr>
      <th>@tts:textAlign="start"</th>
      <td>8.2.19</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textAlign="start"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textAlign[.="start"])'/></td>
   </tr>
   <tr>
      <th>@tts:textAlign="end"</th>
      <td>8.2.19</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textAlign="end"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textAlign[.="end"])'/></td>
   </tr>
   <tr>
      <th>@tts:textAlign="inherit"</th>
      <td>8.2.19</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textAlign="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textAlign[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:textDecoration</th>
      <td>8.2.20</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textDecoration)'/></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="none"</th>
      <td>8.2.20</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="none"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textDecoration[.="none"])'/></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="underline"</th>
      <td>8.2.20</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="underline"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textDecoration[.="underline"])'/></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="noUnderline"</th>
      <td>8.2.20</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="noUnderline"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textDecoration[.="noUnderline"])'/></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="throughline"</th>
      <td>8.2.20</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="throughline"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textDecoration[.="throughline"])'/></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="noThroughline"</th>
      <td>8.2.20</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="noThroughline"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textDecoration[.="noThroughline"])'/></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="overline"</th>
      <td>8.2.20</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="overline"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textDecoration[.="overline"])'/></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="noOverline"</th>
      <td>8.2.20</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="noOverline"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textDecoration[.="noOverline"])'/></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="(underline|throughline|overline){2}"</th>
      <td>8.2.20</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration[matches(., "(underline|throughline|overline) (underline|throughline|overline)")]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textDecoration[matches(., "(underline|throughline|overline) (underline|throughline|overline)")])'/></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="(underline|throughline|overline){3}"</th>
      <td>8.2.20</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration[matches(., "(underline|throughline|overline) (underline|throughline|overline) (underline|throughline|overline)")]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textDecoration[matches(., "(underline|throughline|overline) (underline|throughline|overline) (underline|throughline|overline)")])'/></td>
   </tr>
   <tr>
      <th>@tts:textDecoration="inherit"</th>
      <td>8.2.20</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textDecoration="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textDecoration[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:textOutline</th>
      <td>8.2.21</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textOutline])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textOutline)'/></td>
   </tr>
   <tr>
      <th>@tts:textOutline="none"</th>
      <td>8.2.21</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textOutline="none"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textOutline[.="none"])'/></td>
   </tr>
   <tr>
      <th>@tts:textOutline="&lt;length&gt;"</th>
      <td>8.2.21</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textOutline[t:isLength(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textOutline[t:isLength(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:textOutline="&lt;length&gt; &lt;length&gt;"</th>
      <td>8.2.21</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textOutline[t:isDoubleLength(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textOutline[t:isDoubleLength(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:textOutline="&lt;color&gt; &lt;length&gt;"</th>
      <td>8.2.21</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textOutline[t:isColorLength(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textOutline[t:isColorLength(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:textOutline="&lt;color&gt; &lt;length&gt; &lt;length&gt;"</th>
      <td>8.2.21</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textOutline[t:isColorDoubleLength(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textOutline[t:isColorDoubleLength(.)])'/></td>
   </tr>
   <tr>
      <th>@tts:textOutline="inherit"</th>
      <td>8.2.21</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:textOutline="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:textOutline[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:unicodeBidi</th>
      <td>8.2.22</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:unicodeBidi])'/></td>
      <td><xsl:value-of select='count($tests//@tts:unicodeBidi)'/></td>
   </tr>
   <tr>
      <th>@tts:unicodeBidi="normal"</th>
      <td>8.2.22</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:unicodeBidi="normal"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:unicodeBidi[.="normal"])'/></td>
   </tr>
   <tr>
      <th>@tts:unicodeBidi="embed"</th>
      <td>8.2.22</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:unicodeBidi="embed"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:unicodeBidi[.="embed"])'/></td>
   </tr>
   <tr>
      <th>@tts:unicodeBidi="bidiOverride"</th>
      <td>8.2.22</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:unicodeBidi="bidiOverride"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:unicodeBidi[.="bidiOverride"])'/></td>
   </tr>
   <tr>
      <th>@tts:unicodeBidi="inherit"</th>
      <td>8.2.22</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:unicodeBidi="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:unicodeBidi[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:visibility</th>
      <td>8.2.23</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:visibility])'/></td>
      <td><xsl:value-of select='count($tests//@tts:visibility)'/></td>
   </tr> 
   <tr>
      <th>@tts:visibility="visible"</th>
      <td>8.2.23</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:visibility="visible"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:visibility[.="visible"])'/></td>
   </tr>
   <tr>
      <th>@tts:visibility="hidden"</th>
      <td>8.2.23</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:visibility="hidden"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:visibility[.="hidden"])'/></td>
   </tr>
   <tr>
      <th>@tts:visibility="inherit"</th>
      <td>8.2.23</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:visibility="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:visibility[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:wrapOption</th>
      <td>8.2.24</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:wrapOption])'/></td>
      <td><xsl:value-of select='count($tests//@tts:wrapOption)'/></td>
   </tr> 
   <tr>
      <th>@tts:wrapOption="wrap"</th>
      <td>8.2.24</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:wrapOption="wrap"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:wrapOption[.="wrap"])'/></td>
   </tr>
   <tr>
      <th>@tts:wrapOption="noWrap"</th>
      <td>8.2.24</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:wrapOption="noWrap"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:wrapOption[.="noWrap"])'/></td>
   </tr>
   <tr>
      <th>@tts:wrapOption="inherit"</th>
      <td>8.2.24</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:wrapOption="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:wrapOption[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:writingMode</th>
      <td>8.2.25</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode])'/></td>
      <td><xsl:value-of select='count($tests//@tts:writingMode)'/></td>
   </tr>
   <tr>
      <th>@tts:writingMode="lrtb"</th>
      <td>8.2.25</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="lrtb"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:writingMode[.="lrtb"])'/></td>
   </tr>
   <tr>
      <th>@tts:writingMode="rltb"</th>
      <td>8.2.25</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="rltb"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:writingMode[.="rltb"])'/></td>
   </tr>
   <tr>
      <th>@tts:writingMode="tbrl"</th>
      <td>8.2.25</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="tbrl"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:writingMode[.="tbrl"])'/></td>
   </tr>
   <tr>
      <th>@tts:writingMode="tblr"</th>
      <td>8.2.25</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="tblr"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:writingMode[.="tblr"])'/></td>
   </tr>
   <tr>
      <th>@tts:writingMode="lr"</th>
      <td>8.2.25</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="lr"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:writingMode[.="lr"])'/></td>
   </tr>
   <tr>
      <th>@tts:writingMode="rl"</th>
      <td>8.2.25</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="rl"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:writingMode[.="rl"])'/></td>
   </tr>
   <tr>
      <th>@tts:writingMode="tb"</th>
      <td>8.2.25</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="tb"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:writingMode[.="tb"])'/></td>
   </tr>
   <tr>
      <th>@tts:writingMode="inherit"</th>
      <td>8.2.25</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:writingMode="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:writingMode[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>@tts:zIndex</th>
      <td>8.2.26</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:zIndex])'/></td>
      <td><xsl:value-of select='count($tests//@tts:zIndex)'/></td>
   </tr>
   <tr>
      <th>@tts:zIndex="auto"</th>
      <td>8.2.26</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:zIndex="auto"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:zIndex[.="auto"])'/></td>
   </tr>
   <tr>
      <th>@tts:zIndex="&lt;integer&gt;"</th>
      <td>8.2.26</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:zIndex[matches(., "^(\+|-)?\d+$")]])'/></td>
      <td><xsl:value-of select='count($tests//@tts:zIndex[matches(., "^(\+|-)?\d+$")])'/></td>
   </tr>
   <tr>
      <th>@tts:zIndex="inherit"</th>
      <td>8.2.26</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:zIndex="inherit"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:zIndex[.="inherit"])'/></td>
   </tr>
   <tr>
      <th>tt:layout</th>
      <td>9.1.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:layout])'/></td>
      <td><xsl:value-of select='count($tests//tt:layout)'/></td>
   </tr>
   <tr>
      <th>tt:region</th>
      <td>9.1.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:region])'/></td>
      <td><xsl:value-of select='count($tests//tt:region)'/></td>
   </tr>
   <tr>
      <th>@region</th>
      <td>9.2.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@region])'/></td>
      <td><xsl:value-of select='count($tests//@region)'/></td>
   </tr>
   <tr>
      <th>@begin</th>
      <td>10.2.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin])'/></td>
      <td><xsl:value-of select='count($tests//@begin)'/></td>
   </tr>
   <tr>
      <th>@begin="&lt;clock-time&gt;"</th>
      <td>10.2.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin[t:isClockTime(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@begin[t:isClockTime(.)])'/></td>
   </tr>
   <tr>
      <th>@begin="&lt;offset-time&gt;h"</th>
      <td>10.2.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin[t:isHTime(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@begin[t:isHTime(.)])'/></td>
   </tr>
   <tr>
      <th>@begin="&lt;offset-time&gt;m"</th>
      <td>10.2.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin[t:isMTime(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@begin[t:isMTime(.)])'/></td>
   </tr>
   <tr>
      <th>@begin="&lt;offset-time&gt;s"</th>
      <td>10.2.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin[t:isSTime(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@begin[t:isSTime(.)])'/></td>
   </tr>
   <tr>
      <th>@begin="&lt;offset-time&gt;ms"</th>
      <td>10.2.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin[t:isMSTime(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@begin[t:isMSTime(.)])'/></td>
   </tr>
   <tr>
      <th>@begin="&lt;offset-time&gt;f"</th>
      <td>10.2.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin[t:isFTime(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@begin[t:isFTime(.)])'/></td>
   </tr>
   <tr>
      <th>@begin="&lt;offset-time&gt;t"</th>
      <td>10.2.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@begin[t:isTTime(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@begin[t:isTTime(.)])'/></td>
   </tr>
   <tr>
      <th>@end</th>
      <td>10.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@end])'/></td>
      <td><xsl:value-of select='count($tests//@end)'/></td>
   </tr>
   <tr>
      <th>@end="&lt;clock-time&gt;"</th>
      <td>10.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@end[t:isClockTime(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@end[t:isClockTime(.)])'/></td>
   </tr>
   <tr>
      <th>@end="&lt;offset-time&gt;"</th>
      <td>10.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@end[t:isOffsetTime(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@end[t:isOffsetTime(.)])'/></td>
   </tr>
   <tr>
      <th>@dur</th>
      <td>10.2.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@dur])'/></td>
      <td><xsl:value-of select='count($tests//@dur)'/></td>
   </tr>
   <tr>
      <th>@dur="&lt;clock-time&gt;"</th>
      <td>10.2.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@dur[t:isClockTime(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@dur[t:isClockTime(.)])'/></td>
   </tr>
   <tr>
      <th>@dur="&lt;offset-time&gt;"</th>
      <td>10.2.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@dur[t:isOffsetTime(.)]])'/></td>
      <td><xsl:value-of select='count($tests//@dur[t:isOffsetTime(.)])'/></td>
   </tr>
   <tr>
      <th>@timeContainer</th>
      <td>10.2.4</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@timeContainer])'/></td>
      <td><xsl:value-of select='count($tests//@timeContainer)'/></td>
   </tr>
   <tr>
      <th>@tts:timeContainer="par"</th>
      <td>10.2.4</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:timeContainer="par"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:timeContainer[.="par"])'/></td>
   </tr>
   <tr>
      <th>@tts:timeContainer="seq"</th>
      <td>10.2.4</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@tts:timeContainer="seq"])'/></td>
      <td><xsl:value-of select='count($tests//@tts:timeContainer[.="seq"])'/></td>
   </tr>
   <tr>
      <th>tt:set</th>
      <td>11.1.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:set])'/></td>
      <td><xsl:value-of select='count($tests//tt:set)'/></td>
   </tr>
   <tr>
      <th>tt:metadata</th>
      <td>12.1.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//tt:metadata])'/></td>
      <td><xsl:value-of select='count($tests//tt:metadata)'/></td>
   </tr>
   <tr>
      <th>ttm:title</th>
      <td>12.1.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttm:title])'/></td>
      <td><xsl:value-of select='count($tests//ttm:title)'/></td>
   </tr>
   <tr>
      <th>ttm:desc</th>
      <td>12.1.3</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttm:desc])'/></td>
      <td><xsl:value-of select='count($tests//ttm:desc)'/></td>
   </tr>
   <tr>
      <th>ttm:copyright</th>
      <td>12.1.4</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttm:copyright])'/></td>
      <td><xsl:value-of select='count($tests//ttm:copyright)'/></td>
   </tr>
   <tr>
      <th>ttm:agent</th>
      <td>12.1.5</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttm:agent])'/></td>
      <td><xsl:value-of select='count($tests//ttm:agent)'/></td>
   </tr>
   <tr>
      <th>ttm:name</th>
      <td>12.1.6</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttm:name])'/></td>
      <td><xsl:value-of select='count($tests//ttm:name)'/></td>
   </tr>
   <tr>
      <th>ttm:actor</th>
      <td>12.1.7</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//ttm:actor])'/></td>
      <td><xsl:value-of select='count($tests//ttm:actor)'/></td>
   </tr>
   <tr>
      <th>@ttm:agent</th>
      <td>12.2.1</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttm:agent])'/></td>
      <td><xsl:value-of select='count($tests//@ttm:agent)'/></td>
   </tr>
   <tr>
      <th>@ttm:role</th>
      <td>12.2.2</td>
      <td><xsl:value-of select='count($tests/tt:tt[.//@ttm:role])'/></td>
      <td><xsl:value-of select='count($tests//@ttm:role)'/></td>
   </tr> </tbody>
</table>
    </body>
</html>
    </xsl:template>

    <xsl:template match="tt:tt">
      <tr>
	<th><xsl:value-of select='tt:head/tt:metadata/ttm:title'/></th>
	<td><xsl:value-of select='tt:head/tt:metadata/ttm:descr'/></td>	
      </tr>
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

      <xsl:value-of select='matches($s, "^(in|within|out)\((pixel|glyph|inline|line|block|character|word)(,(jump|smooth|fade)(,barWipe(,(leftToRight|topToBottom))?)?)?\)$")'/> 

    </xsl:function>

    <xsl:function name="t:isDynamicFlow" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^((in|within|out)\((pixel|glyph|inline|line|block|character|word)(,(jump|smooth|fade)(,barWipe(,(leftToRight|topToBottom))?)?)?\))+( (intra|inter)\((auto|\d(\.\d)?(s|ms|f|t)?)\))+$")'/> 

    </xsl:function>

    <xsl:function name="t:isLength" as="xs:boolean">
      <xsl:param name='s' as="xs:string"/>

      <xsl:value-of select='matches($s, "^(\+|-)?\d+(\.\d+)?(px|em|c|%)$")'/>
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
