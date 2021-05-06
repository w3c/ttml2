<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:import href="xmlspec.xsl"/>
<xsl:import href="changelog.xsl"/>
<xsl:param name="toc.level" select="5"/>
<xsl:param name="show.ednotes">1</xsl:param>
<!-- [GA] remove 2013-05-09
<xsl:param name="show.diff.markup">1</xsl:param>
-->
<xsl:variable name="output.mode" select="'html'"/>
<xsl:param name="additional.css">
<xsl:text>
</xsl:text>
</xsl:param>
<xsl:output method="html" encoding="utf-8" indent="no"/>

<!-- spec: the specification itself -->
<xsl:template match="spec">
  <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
  <html>
    <xsl:if test="header/langusage/language">
      <xsl:attribute name="lang">
	<xsl:value-of select="header/langusage/language/@id"/>
      </xsl:attribute>
    </xsl:if>
    <head>
      <xsl:if test="$output.mode='html'">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      </xsl:if>
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
      <title>
	<xsl:apply-templates select="header/title"/>
	<xsl:if test="header/version">
	  <xsl:text> </xsl:text>
	  <xsl:apply-templates select="header/version"/>
	</xsl:if>
	<xsl:if test="$additional.title != ''">
	  <xsl:text> -- </xsl:text>
	  <xsl:value-of select="$additional.title"/>
	</xsl:if>
	<xsl:if test="/spec/@role='editors-copy'">
	  <xsl:text> -- (Editor's copy)</xsl:text>
	</xsl:if>
      </title>
      <xsl:call-template name="css"/>
      <xsl:call-template name="additional-head"/>
    </head>
    <body>
      <xsl:if test="/spec/@role='editors-copy'">
	<xsl:value-of select="//revisiondesc/p[1]"/>
	<div id="revisions"></div>
      </xsl:if>
      <xsl:apply-templates/>
      <xsl:if test="//footnote[not(ancestor::table)]">
	<hr/>
	<div class="endnotes">
	  <xsl:text></xsl:text>
	  <h3>
	    <xsl:call-template name="anchor">
	      <xsl:with-param name="conditional" select="0"/>
	      <xsl:with-param name="default.id" select="'endnotes'"/>
	    </xsl:call-template>
	    <xsl:text>End Notes</xsl:text>
	  </h3>
	  <dl>
	    <xsl:apply-templates select="//footnote[not(ancestor::table)]" mode="notes"/>
	  </dl>
	</div>
      </xsl:if>
      <p role="navigation" id="back-to-top"><a href="#title"><abbr title="Back to top">↑</abbr></a></p>
      <script src="https://www.w3.org/scripts/TR/2016/fixup.js"></script>
    </body>
  </html>
</xsl:template>

<!-- css: styling of spec -->
<xsl:template name="css">
  <style>
    <xsl:text>
code
{
font-family: monospace;
}

div.constraint, div.issue, div.note, div.notice
{
margin-left: 2em;
}

div.exampleInner pre
{
margin-left: 1em;
margin-top: 0em;
margin-bottom: 0em;
}

div.exampleOuter
{
border: 4px double gray;
margin: 0em;
padding: 0em;
}

div.exampleInner
{
background-color: #d5dee3;
border-top-width: 4px;
border-top-style: double;
border-top-color: #d3d3d3;
border-bottom-width: 4px;
border-bottom-style: double;
border-bottom-color: #d3d3d3;
padding: 4px;
margin: 0em;
}

div.exampleWrapper
{
margin: 4px;
}

div.exampleHeader
{
font-weight: bold;
margin: 4px;
}

div.issue
{
background-color: #ffff66;
border: 2px solid black;
padding: 0em 1em;
margin: 0em;
}

li p
{
margin-bottom: 0.3em;
margin-top: 0.3em;
}

ol.enumar
{
list-style-type: decimal;
}

ol.enumla
{
list-style-type: lower-alpha;
}

ol.enumlr
{
list-style-type: lower-roman;
}

ol.enumua
{
list-style-type: upper-alpha;
}

ol.enumur
{
list-style-type: upper-roman;
}

table.acronyms td.label
{
width: 15%;
}

table.acronyms td.def
{
width: 65%;
}

table.common
{
border: 2px solid black;
border-collapse: collapse;
width: 100%;
}

table.common caption
{
font-weight: bold;
padding-bottom: 0.5em;
text-align: left;
}

table.common th
{
border: 2px solid black;
padding: 0em 0.5em;
text-align: left;
}

table.common td
{
border: 2px solid black;
padding: 0em 0.5em;
}

table.ednote
{
border-collapse: collapse;
border: 2px solid black;
width: 100%;
}

table.ednote td
{
background-color: #ddaa66;
border: 2px solid black;
}

table.example
{
border: 0px solid black;
border-collapse: collapse;
width: 100%;
}

table.example caption
{
font-weight: bold;
padding-bottom: 0.5em;
text-align: left;
}

table.example div
{
background-color: #c8ffff;
}

table.example td
{
border: 0px solid black; 
}

table.example th
{
border: 0px solid black;
text-align: left;
}

table.example-images
{
border-collapse: collapse;
border: 0px solid black;
text-align: center;
width: 100%;
}

table.example-images caption
{
font-weight: bold;
padding-bottom: 0.5em;
text-align: center;
}

table.example-images td
{
border: 0px solid black;
text-align: center;
}

table.example-images-bordered
{
border: 2px solid black;
border-collapse: collapse;
text-align: center;
width: 100%;
}

table.example-images-bordered caption
{
font-weight: bold;
padding-bottom: 0.5em;
text-align: center;
}

table.example-images-bordered td
{
border: 2px solid black;
}

table.graphic
{
border: 0px none black;
border-collapse: collapse;
width: 100%;
}

table.graphic caption
{
font-weight: bold;
padding-bottom: 0.5em;
text-align: center;
}

table.graphic td
{
border: 0px none black;
text-align: center;
}

table.semantics
{
border: 0px solid black;
border-collapse: collapse;
width: 100%;
}

table.semantics caption
{
font-weight: bold;
padding-bottom: 0.5em;
text-align: left;
}

table.semantics code.formulae {
background-color: #fdfdfd;
border: 1px dashed #005a9c;
line-height: 1.1em;
padding: 1em;
}

table.semantics td {
background-color: #ccffcc;
border-bottom: 4px double #d3d3d3;
border-left: 0px solid black;
border-right: 0px solid black;
border-top: 4px double #d3d3d3;
}

table.semantics th
{
border: 0px solid black;
text-align: left;
}

table.syntax
{
border-collapse: collapse;
border: 0px solid black;
width: 100%;
}

table.syntax caption
{
font-weight: bold;
padding-bottom: 0.5em;
text-align: left;
}

table.syntax div
{
background-color: #ffffc8;
}

table.syntax td
{
border: 0px solid black;
}

table.syntax th
{
border: 0px solid black;
text-align: left;
}

.center
{
text-align: center;
}

.deprecated
{
background-color: #fbaf5c;
}

.left
{
text-align: left;
}

.obsoleted
{
background-color: #f26d7d;
}

.optattr
{
font-style: italic;
}

.reqattr
{
font-weight: bold;
}

.right
{
text-align: right;
}

.strong
{
font-weight: bold;
}

.tbd
{
background-color: #ffff33;
border: 2px solid black;
width: 100%;
}
    </xsl:text>
  </style>
  <link rel="stylesheet" type="text/css">
    <xsl:attribute name="href">
      <xsl:text>https://www.w3.org/StyleSheets/TR/2016/</xsl:text>
      <xsl:choose>
        <xsl:when test="/spec/@role='editors-copy'">W3C-ED</xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <!-- Editor's review drafts are a special case. -->
            <xsl:when test="/spec/@w3c-doctype='review' or contains(/spec/header/w3c-doctype, 'Editor')">W3C-ED</xsl:when>
            <xsl:when test="/spec/@w3c-doctype='wd'">W3C-WD</xsl:when>
            <xsl:when test="/spec/@w3c-doctype='rec'">W3C-REC</xsl:when>
            <xsl:when test="/spec/@w3c-doctype='pr'">W3C-PR</xsl:when>
            <xsl:when test="/spec/@w3c-doctype='per'">W3C-PER</xsl:when>
            <xsl:when test="/spec/@w3c-doctype='cr'">W3C-CR</xsl:when>
            <xsl:when test="/spec/@w3c-doctype='note'">W3C-NOTE</xsl:when>
            <xsl:when test="/spec/@w3c-doctype='wgnote'">W3C-WG-NOTE</xsl:when>
            <xsl:when test="/spec/@w3c-doctype='memsub'">W3C-Member-SUBM</xsl:when>
            <xsl:when test="/spec/@w3c-doctype='teamsub'">W3C-Team-SUBM</xsl:when>
            <xsl:otherwise>base</xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </link>
</xsl:template>

<!-- additional header content -->
<xsl:template name="additional-head">
  <link rel="canonical">
    <xsl:attribute name="href">
      <xsl:value-of select="/spec/@canonical-url"/>
    </xsl:attribute>
  </link>
</xsl:template>

<!-- header: metadata about the spec -->
<!-- pull out information into standard W3C layout -->
<xsl:template match="header">
  <div class="head">
    <xsl:if test="not(/spec/@role='editors-copy')">
      <p>
        <a href="https://www.w3.org/"><img height="48" width="72" alt="W3C" src="https://www.w3.org/StyleSheets/TR/2016/logos/W3C"/></a>
        <xsl:choose>
          <xsl:when test="/spec/@w3c-doctype='memsub'">
            <a href='http://www.w3.org/Submission/'>
              <img alt='Member Submission'
                   src='http://www.w3.org/Icons/member_subm'/>
            </a>
          </xsl:when>
          <xsl:when test="/spec/@w3c-doctype='teamsub'">
            <a href='http://www.w3.org/2003/06/TeamSubmission'>
              <img alt='Team Submission'
                   src='http://www.w3.org/Icons/team_subm'/>
            </a>
          </xsl:when>
        </xsl:choose>
      </p>
    </xsl:if>
    <xsl:text>&#10;</xsl:text>
    <h1 id="title">
      <xsl:apply-templates select="title"/>
      <xsl:if test="version">
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="version"/>
      </xsl:if>
    </h1>
    <xsl:if test="subtitle">
      <xsl:text>&#10;</xsl:text>
      <h2>
        <xsl:call-template name="anchor">
          <xsl:with-param name="node" select="subtitle[1]"/>
          <xsl:with-param name="conditional" select="0"/>
          <xsl:with-param name="default.id" select="'subtitle'"/>
        </xsl:call-template>
        <xsl:apply-templates select="subtitle"/>
      </h2>
    </xsl:if>
    <xsl:text>&#10;</xsl:text>
    <h2>
      <xsl:call-template name="anchor">
        <xsl:with-param name="node" select="w3c-doctype[1]"/>
        <xsl:with-param name="conditional" select="0"/>
        <xsl:with-param name="default.id" select="'w3c-doctype'"/>
      </xsl:call-template>

      <xsl:choose>
        <xsl:when test="/spec/@w3c-doctype = 'review'">
          <xsl:text>Editor's Draft</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="w3c-doctype[1]"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text> </xsl:text>
      <xsl:if test="pubdate/day">
        <xsl:apply-templates select="pubdate/day"/>
        <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:apply-templates select="pubdate/month"/>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="pubdate/year"/>
    </h2>
    <dl>
      <xsl:apply-templates select="publoc"/>
      <xsl:apply-templates select="latestedloc"/>
      <xsl:apply-templates select="latestloc"/>
      <xsl:apply-templates select="latestrec"/>
      <xsl:apply-templates select="prevlocs"/>
      <xsl:apply-templates select="implreploc"/>
      <xsl:apply-templates select="authlist"/>
      <xsl:apply-templates select="ghrepoloc"/>
    </dl>

    <!-- output the errataloc and altlocs -->
    <xsl:apply-templates select="errataloc"/>
    <xsl:apply-templates select="preverrataloc"/>
    <xsl:apply-templates select="translationloc"/>
    <xsl:apply-templates select="altlocs"/>

    <xsl:choose>
      <xsl:when test="copyright">
        <xsl:apply-templates select="copyright"/>
      </xsl:when>
      <xsl:otherwise>
        <p class="copyright">
          <a href="https://www.w3.org/Consortium/Legal/ipr-notice#Copyright">
            <xsl:text>Copyright</xsl:text>
          </a>
          <xsl:text>&#xa0;&#xa9;&#xa0;</xsl:text>
          <xsl:apply-templates select="pubdate/year"/>
          <xsl:text>&#xa0;</xsl:text>
          <a href="https://www.w3.org/">
            <abbr title="World Wide Web Consortium">W3C</abbr>
          </a>
          <sup>&#xae;</sup>
          <xsl:text> (</xsl:text>
          <a href="https://www.csail.mit.edu/">
            <abbr title="Massachusetts Institute of Technology">MIT</abbr>
          </a>
          <xsl:text>, </xsl:text>
          <a href="https://www.ercim.eu/">
            <abbr title="European Research Consortium for Informatics and Mathematics">ERCIM</abbr>
          </a>
          <xsl:text>, </xsl:text>
          <a href="https://www.keio.ac.jp/">Keio</a>
          <xsl:text>, </xsl:text>
          <a href="https://ev.buaa.edu.cn/">Beihang</a>
          <xsl:text>). W3C </xsl:text>
          <a href="https://www.w3.org/Consortium/Legal/ipr-notice#Legal_Disclaimer">liability</a>
          <xsl:text>, </xsl:text>
          <a href="https://www.w3.org/Consortium/Legal/ipr-notice#W3C_Trademarks">trademark</a>
          <xsl:text> and </xsl:text>
          <a href="https://www.w3.org/Consortium/Legal/copyright-documents">document use</a>
          <xsl:text> rules apply.</xsl:text>
        </p>
      </xsl:otherwise>
    </xsl:choose>
    <hr/>
  </div>
  <xsl:apply-templates select="notice"/>
  <xsl:apply-templates select="abstract"/>
  <xsl:apply-templates select="status"/>
  <xsl:apply-templates select="revisiondesc"/>
</xsl:template>

<!-- latestedloc: latest location for this spec -->
<!-- called in a <dl> context from header -->
<xsl:template match="latestedloc">
  <xsl:choose>
    <xsl:when test="count(loc) &gt; 1">
      <xsl:for-each select="loc">
        <dt>
          <xsl:apply-templates select="node()"/>
        </dt>
        <dd>
          <a href="{@href}">
            <xsl:value-of select="@href"/>
          </a>
        </dd>
      </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
      <dt>Latest editor's draft:</dt>
      <dd>
        <xsl:apply-templates/>
      </dd>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- implreploc: implementation report for this spec -->
<!-- called in a <dl> context from header -->
<xsl:template match="implreploc">
  <xsl:choose>
    <xsl:when test="count(loc) &gt; 1">
      <xsl:for-each select="loc">
        <dt>
          <xsl:apply-templates select="node()"/>
        </dt>
        <dd>
          <a href="{@href}">
            <xsl:value-of select="@href"/>
          </a>
        </dd>
      </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
      <dt>Implementation report:</dt>
      <dd>
        <xsl:apply-templates/>
      </dd>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ghrepoloc: participate section -->
<!-- called in a <dl> content from header -->
<xsl:template match="ghrepoloc">
  <xsl:apply-templates/>
</xsl:template>
<xsl:template match="ghloc">
  <dt>Participate:</dt>
  <dd><a href="https://github.com/{@repo}/">GitHub <xsl:value-of select="@repo"/></a></dd>
  <dd><a href="https://github.com/{@repo}/issues/new">File a bug</a>
     (<a href="https://github.com/{@repo}/issues/">open bugs</a>)</dd>
  <dd><a href="https://github.com/{@repo}/commits/{@branch}">Commit history</a></dd>
  <dd><a href="https://github.com/{@repo}/pulls/">Pull requests</a></dd>
</xsl:template>

<!-- latestrec: latest location for this spec -->
<!-- called in a <dl> context from header -->
<xsl:template match="latestrec">
  <xsl:choose>
    <xsl:when test="count(loc) &gt; 1">
      <xsl:for-each select="loc">
        <dt>
          <xsl:apply-templates select="node()"/>
        </dt>
        <dd>
          <a href="{@href}">
            <xsl:value-of select="@href"/>
          </a>
        </dd>
      </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
      <dt>Latest recommendation:</dt>
      <dd>
        <xsl:apply-templates/>
      </dd>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- specref: reference to another part of the current specification -->
<xsl:template match="specref">
  <xsl:param name="target" select="key('ids', @ref)[1]"/>

  <xsl:choose>
    <xsl:when test="not($target)">
      <xsl:message>
        <xsl:text>specref to non-existent ID: </xsl:text>
        <xsl:value-of select="@ref"/>
      </xsl:message>
    </xsl:when>
    <xsl:when test="local-name($target)='issue'
                    or starts-with(local-name($target), 'div')
                    or starts-with(local-name($target), 'inform-div')
                    or local-name($target) = 'vcnote'
                    or local-name($target) = 'prod'
                    or local-name($target) = 'example'
                    or local-name($target) = 'label'
                    or local-name($target) = 'table'
                    or $target/self::item[parent::olist]">
      <xsl:apply-templates select="$target" mode="specref"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>
        <xsl:text>Unsupported specref to </xsl:text>
        <xsl:value-of select="local-name($target)"/>
        <xsl:text> [</xsl:text>
        <xsl:value-of select="@ref"/>
        <xsl:text>] </xsl:text>
        <xsl:text> (Contact stylesheet maintainer).</xsl:text>
      </xsl:message>
      <b>
        <a>
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="target" select="key('ids', @ref)"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:text>???</xsl:text>
        </a>
      </b>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- status: the status of the spec -->
<xsl:template match="status">
  <div>
    <xsl:text>&#10;</xsl:text>
    <h2>
      <xsl:call-template name="anchor">
        <xsl:with-param name="conditional" select="0"/>
        <xsl:with-param name="default.id" select="'status'"/>
      </xsl:call-template>
      <xsl:text>Status of This Document</xsl:text>
    </h2>
    <xsl:if test="/spec/@role='editors-copy'">
      <p><strong>This document is an editor's copy that has
      no official standing.</strong></p>
    </xsl:if>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<!-- body: the meat of the spec -->
<xsl:template match="body">
  <xsl:if test="$toc.level &gt; 0">
    <nav id="toc">
      <h2 class="introductory" id="table-of-contents">
        <xsl:text>Table of Contents</xsl:text>
      </h2>
      <ol class="toc" role="directory">
        <xsl:apply-templates select="div1" mode="toc"/>
      </ol>
      <xsl:if test="../back">
        <xsl:text>&#10;</xsl:text>
        <h2 class="introductory" id="table-of-contents-appendices">
          <xsl:text>Appendi</xsl:text>
          <xsl:choose>
            <xsl:when test="count(../back/div1 | ../back/inform-div1) > 1">
              <xsl:text>ces</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>x</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </h2>
        <ul class="toc" role="directory">
          <xsl:apply-templates mode="toc" select="../back/div1 | ../back/inform-div1"/>
          <xsl:call-template name="autogenerated-appendices-toc"/>
        </ul>
      </xsl:if>
    </nav>
  </xsl:if>
  <div class="body">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<!-- mode: toc -->
<xsl:template mode="toc" match="div1">
  <li class="tocline">
    <a class="tocxref">
      <xsl:attribute name="href">
        <xsl:call-template name="href.target">
          <xsl:with-param name="target" select="."/>
        </xsl:call-template>
      </xsl:attribute>
      <span class="secno"><xsl:apply-templates select="." mode="divnum"/></span>
      <xsl:apply-templates select="head" mode="text"/>
    </a>
    <xsl:if test="count(div2) > 0">
      <xsl:if test="$toc.level &gt; 1">
        <ul class="toc">
          <xsl:apply-templates select="div2" mode="toc"/>
        </ul>
      </xsl:if>
    </xsl:if>
  </li>
</xsl:template>

<xsl:template mode="toc" match="div2">
  <li class="tocline">
    <a class="tocxref">
      <xsl:attribute name="href">
        <xsl:call-template name="href.target">
          <xsl:with-param name="target" select="."/>
        </xsl:call-template>
      </xsl:attribute>
      <span class="secno"><xsl:apply-templates select="." mode="divnum"/></span>
      <xsl:apply-templates select="head" mode="text"/>
    </a>
    <xsl:if test="count(div3) > 0">
      <xsl:if test="$toc.level &gt; 2">
        <ul class="toc">
          <xsl:apply-templates select="div3" mode="toc"/>
        </ul>
      </xsl:if>
    </xsl:if>
  </li>
</xsl:template>

<xsl:template mode="toc" match="div3">
  <li class="tocline">
    <a class="tocxref">
      <xsl:attribute name="href">
        <xsl:call-template name="href.target">
          <xsl:with-param name="target" select="."/>
        </xsl:call-template>
      </xsl:attribute>
      <span class="secno"><xsl:apply-templates select="." mode="divnum"/></span>
      <xsl:apply-templates select="head" mode="text"/>
    </a>
    <xsl:if test="count(div4) > 0">
      <xsl:if test="$toc.level &gt; 3">
        <ul class="toc">
          <xsl:apply-templates select="div4" mode="toc"/>
        </ul>
      </xsl:if>
    </xsl:if>
  </li>
</xsl:template>

<xsl:template mode="toc" match="div4">
  <li class="tocline">
    <a class="tocxref">
      <xsl:attribute name="href">
        <xsl:call-template name="href.target">
          <xsl:with-param name="target" select="."/>
        </xsl:call-template>
      </xsl:attribute>
      <span class="secno"><xsl:apply-templates select="." mode="divnum"/></span>
      <xsl:apply-templates select="head" mode="text"/>
    </a>
    <xsl:if test="count(div5) > 0">
      <xsl:if test="$toc.level &gt; 4">
        <ul class="toc">
          <xsl:apply-templates select="div5" mode="toc"/>
        </ul>
      </xsl:if>
    </xsl:if>
  </li>
</xsl:template>

<xsl:template mode="toc" match="div5">
  <li class="tocline">
    <a class="tocxref">
      <xsl:attribute name="href">
        <xsl:call-template name="href.target">
          <xsl:with-param name="target" select="."/>
        </xsl:call-template>
      </xsl:attribute>
      <span class="secno"><xsl:apply-templates select="." mode="divnum"/></span>
      <xsl:apply-templates select="head" mode="text"/>
    </a>
  </li>
</xsl:template>

<xsl:template mode="toc" match="inform-div1">
  <li class="tocline">
    <a class="tocxref">
      <xsl:attribute name="href">
        <xsl:call-template name="href.target">
          <xsl:with-param name="target" select="."/>
        </xsl:call-template>
      </xsl:attribute>
      <span class="secno"><xsl:apply-templates select="." mode="divnum"/></span>
      <xsl:apply-templates select="head" mode="text"/>
      <xsl:text> (Non-Normative)</xsl:text>
    </a>
    <xsl:if test="count(div2) > 0">
      <xsl:if test="$toc.level &gt; 2">
        <ul class="toc">
          <xsl:apply-templates select="div2" mode="toc"/>
        </ul>
      </xsl:if>
    </xsl:if>
  </li>
</xsl:template>

<!-- mode: divnum -->
<xsl:template mode="divnum" match="div1">
  <xsl:number format="1 "/>
</xsl:template>

<xsl:template mode="divnum" match="back/div1 | inform-div1">
  <xsl:number count="div1 | inform-div1" format="A "/>
</xsl:template>

<xsl:template mode="divnum"
  match="front/div1 | front//div2 | front//div3 | front//div4 | front//div5"/>

<xsl:template mode="divnum" match="div2">
  <xsl:number level="multiple" count="div1 | div2" format="1.1 "/>
</xsl:template>

<xsl:template mode="divnum" match="back//div2">
  <xsl:number level="multiple" count="div1 | div2 | inform-div1"
    format="A.1 "/>
</xsl:template>

<xsl:template mode="divnum" match="div3">
  <xsl:number level="multiple" count="div1 | div2 | div3"
    format="1.1.1 "/>
</xsl:template>

<xsl:template mode="divnum" match="back//div3">
  <xsl:number level="multiple"
    count="div1 | div2 | div3 | inform-div1" format="A.1.1 "/>
</xsl:template>

<xsl:template mode="divnum" match="div4">
  <xsl:number level="multiple" count="div1 | div2 | div3 | div4"
    format="1.1.1.1 "/>
</xsl:template>

<xsl:template mode="divnum" match="back//div4">
  <xsl:number level="multiple"
    count="div1 | div2 | div3 | div4 | inform-div1"
    format="A.1.1.1 "/>
</xsl:template>

<xsl:template mode="divnum" match="div5">
  <xsl:number level="multiple"
    count="div1 | div2 | div3 | div4 | div5" format="1.1.1.1.1 "/>
</xsl:template>

<xsl:template mode="divnum" match="back//div5">
  <xsl:number level="multiple"
    count="div1 | div2 | div3 | div4 | div5 | inform-div1"
    format="A.1.1.1.1 "/>
</xsl:template>

<!-- ednote: editors' note -->
<xsl:template match="ednote">
  <xsl:if test="$show.ednotes != 0">
    <table style="border: 1px solid black" class="ednote">
      <tr class="ednote-r1">
	<td style="text-align: left; vertical-align: top;">
	  <b>
	    <xsl:text>Editorial note</xsl:text>
	    <xsl:if test="name">
	      <xsl:text>: </xsl:text>
	      <xsl:apply-templates select="name"/>
	    </xsl:if>
	  </b>
	</td>
	<td style="text-align: right; vertical-align: top;">
	  <xsl:choose>
	    <xsl:when test="date">
	      <xsl:apply-templates select="date"/>
	    </xsl:when>
	    <xsl:otherwise>&#160;</xsl:otherwise>
	  </xsl:choose>
	</td>
      </tr>
      <tr class="ednote-r2">
	<td colspan="2" style="text-align: left; vertical-align: top;">
	  <xsl:apply-templates select="edtext"/>
	</td>
      </tr>
    </table>
  </xsl:if>
</xsl:template>

<!-- author: an editor of a spec -->
<xsl:template match="author">
  <dd>
    <xsl:if test="@w3c-uid">
      <xsl:attribute name="data-editor-id">
        <xsl:value-of select="@w3c-uid"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </dd>
</xsl:template>

<!-- glist: glossary list -->
<xsl:template match="glist">
  <xsl:choose>
  <xsl:when test="@role = 'acronyms'">
    <table class="acronyms">
      <xsl:for-each select="gitem">
        <tr>
          <xsl:apply-templates select="label" mode="acronym"/>
          <xsl:apply-templates select="def" mode="acronym"/>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:when>
    <xsl:otherwise>
      <xsl:if test="$validity.hacks = 1 and local-name(..) = 'p'">
	<xsl:text disable-output-escaping="yes">&lt;/p&gt;</xsl:text>
      </xsl:if>
      <dl>
	<xsl:if test="@role">
	  <xsl:attribute name="class">
	    <xsl:value-of select="@role"/>
	  </xsl:attribute>
	</xsl:if>
	<xsl:apply-templates/>
      </dl>
      <xsl:if test="$validity.hacks = 1 and local-name(..) = 'p'">
	<xsl:text disable-output-escaping="yes">&lt;p&gt;</xsl:text>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- label: acronym mode -->
<xsl:template mode="acronym" match="label">
  <td class="label">
    <xsl:call-template name="anchor">
      <xsl:with-param name="node" select=".."/>
    </xsl:call-template>
    <xsl:call-template name="anchor"/>
    <b><xsl:apply-templates/></b>
  </td>
</xsl:template>

<!-- code: generic computer code (override to map @role) -->
<xsl:template match="code">
  <code>
    <xsl:if test="@role">
      <xsl:attribute name="class">
        <xsl:value-of select="@role"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </code>
</xsl:template>

<!-- def: acronym mode -->
<xsl:template mode="acronym" match="def">
  <td class="def">
  <xsl:apply-templates/>
  </td>
</xsl:template>

<!-- loc: a Web location -->
<xsl:template match="loc">
  <a href="{@href}">
    <xsl:if test="@id">
      <xsl:attribute name="id">
	<xsl:value-of select="@id"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@role">
      <xsl:attribute name="rel">
	<xsl:value-of select="@role"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </a>
</xsl:template>

<!-- note: a note about the spec (override to map @id) -->
<xsl:template match="note">
  <div class="note">
    <xsl:if test="@id">
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
    </xsl:if>
    <p class="prefix">
      <b>Note:</b>
    </p>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<!-- table specref -->
<xsl:template match="table">
  <xsl:call-template name="anchor"/>
  <table>
    <xsl:for-each select="@*">
      <!-- Wait: some of these aren't HTML attributes after all... -->
      <xsl:choose>
        <xsl:when test="local-name(.) = 'role'">
          <xsl:attribute name="class">
            <xsl:value-of select="."/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="local-name(.) = 'diff' or local-name(.) = 'id'">
          <!-- nop -->
        </xsl:when>
        <xsl:when test="local-name(.) = 'css'">
          <xsl:attribute name="style">
            <xsl:value-of select="."/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:apply-templates/>
    <xsl:if test=".//footnote">
      <tbody>
        <tr>
          <td>
            <xsl:apply-templates select=".//footnote" mode="table.notes"/>
          </td>
        </tr>
      </tbody>
    </xsl:if>
  </table>
</xsl:template>

<!-- table specref -->
<xsl:template match="table" mode="specref">
  <a>
    <xsl:attribute name="href">
      <xsl:call-template name="href.target"/>
    </xsl:attribute>
    <b>
      <xsl:apply-templates select="caption" mode="text"/>
    </b>
  </a>
</xsl:template>

<!-- col|tr -->
<xsl:template match="col|tr">
  <xsl:element name="{local-name(.)}">
    <xsl:for-each select="@*">
      <!-- Wait: some of these aren't HTML attributes after all... -->
      <xsl:choose>
        <xsl:when test="local-name(.) = 'role'">
          <xsl:attribute name="class">
            <xsl:value-of select="."/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="local-name(.) = 'diff'">
          <!-- nop -->
        </xsl:when>
        <xsl:when test="local-name(.) = 'css'">
          <xsl:attribute name="style">
            <xsl:value-of select="."/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<!-- th|td -->
<xsl:template match="td|th">
  <xsl:element name="{local-name(.)}">
    <xsl:for-each select="@*">
      <!-- Wait: some of these aren't HTML attributes after all... -->
      <xsl:choose>
        <xsl:when test="local-name(.) = 'role'">
          <xsl:attribute name="class">
            <xsl:value-of select="."/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="local-name(.) = 'diff'"/>
        <xsl:when test="local-name(.) = 'colspan' and . = 1"/>
        <xsl:when test="local-name(.) = 'rowspan' and . = 1"/>
        <xsl:when test="local-name(.) = 'css'">
          <xsl:attribute name="style">
            <xsl:value-of select="."/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<!-- authlist -->
<xsl:template match="authlist">
  <dt>
    <xsl:choose>
      <xsl:when test="@role='editor'">
	<xsl:text>Editor</xsl:text>
      </xsl:when>
      <xsl:when test="@role='contributor'">
	<xsl:text>Contributing Author</xsl:text>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>Author</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="count(author) &gt; 1">
      <xsl:text>s</xsl:text>
    </xsl:if>
    <xsl:text>:</xsl:text>
  </dt>
  <xsl:apply-templates/>
</xsl:template>

<!-- div[n]: structural divisions -->
<!-- make an HTML div -->
<!-- see also div[n]/head -->
<xsl:template match="div1">
  <div class="div1">
    <xsl:if test="@css">
      <xsl:attribute name="style">
        <xsl:value-of select="@css"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="div2">
  <div class="div2">
    <xsl:if test="@css">
      <xsl:attribute name="style">
        <xsl:value-of select="@css"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="div3">
  <div class="div3">
    <xsl:if test="@css">
      <xsl:attribute name="style">
        <xsl:value-of select="@css"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="div4">
  <div class="div4">
    <xsl:if test="@css">
      <xsl:attribute name="style">
        <xsl:value-of select="@css"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="div5">
  <div class="div5">
    <xsl:if test="@css">
      <xsl:attribute name="style">
        <xsl:value-of select="@css"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="div1/head">
  <xsl:text>&#10;</xsl:text>
  <h2>
    <xsl:if test="@css">
      <xsl:attribute name="style">
        <xsl:value-of select="@css"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:call-template name="anchor">
    <xsl:with-param name="conditional" select="0"/>
    <xsl:with-param name="node" select=".."/>
    </xsl:call-template>
    <xsl:apply-templates select=".." mode="divnum"/>
    <xsl:apply-templates/>
  </h2>
</xsl:template>

<xsl:template match="div2/head">
  <xsl:text>&#10;</xsl:text>
  <h3>
    <xsl:if test="@css">
      <xsl:attribute name="style">
        <xsl:value-of select="@css"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:call-template name="anchor">
    <xsl:with-param name="conditional" select="0"/>
    <xsl:with-param name="node" select=".."/>
    </xsl:call-template>
    <xsl:apply-templates select=".." mode="divnum"/>
    <xsl:apply-templates/>
  </h3>
</xsl:template>

<xsl:template match="div3/head">
  <xsl:text>&#10;</xsl:text>
  <h4>
    <xsl:if test="@css">
      <xsl:attribute name="style">
        <xsl:value-of select="@css"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:call-template name="anchor">
    <xsl:with-param name="conditional" select="0"/>
    <xsl:with-param name="node" select=".."/>
    </xsl:call-template>
    <xsl:apply-templates select=".." mode="divnum"/>
    <xsl:apply-templates/>
  </h4>
</xsl:template>

<xsl:template match="div4/head">
  <xsl:text>&#10;</xsl:text>
  <h5>
    <xsl:if test="@css">
      <xsl:attribute name="style">
        <xsl:value-of select="@css"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:call-template name="anchor">
    <xsl:with-param name="conditional" select="0"/>
    <xsl:with-param name="node" select=".."/>
    </xsl:call-template>
    <xsl:apply-templates select=".." mode="divnum"/>
    <xsl:apply-templates/>
  </h5>
</xsl:template>

<xsl:template match="div5/head">
  <xsl:text>&#10;</xsl:text>
  <h6>
    <xsl:if test="@css">
      <xsl:attribute name="style">
        <xsl:value-of select="@css"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:call-template name="anchor">
    <xsl:with-param name="conditional" select="0"/>
    <xsl:with-param name="node" select=".."/>
    </xsl:call-template>
    <xsl:apply-templates select=".." mode="divnum"/>
    <xsl:apply-templates/>
  </h6>
</xsl:template>

<xsl:template match="inform-div1/head">
  <xsl:text>&#10;</xsl:text>
  <h2>
    <xsl:if test="@css">
      <xsl:attribute name="style">
        <xsl:value-of select="@css"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:call-template name="anchor">
    <xsl:with-param name="conditional" select="0"/>
    <xsl:with-param name="node" select=".."/>
    </xsl:call-template>
    <xsl:apply-templates select=".." mode="divnum"/>
    <xsl:apply-templates/>
    <xsl:text> (Non-Normative)</xsl:text>
  </h2>
</xsl:template>

<!-- graphic -->
<xsl:template match="graphic">
  <img src="{@source}">
    <xsl:if test="@alt">
      <xsl:attribute name="alt">
        <xsl:value-of select="@alt"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@css">
      <xsl:attribute name="style">
        <xsl:value-of select="@css"/>
      </xsl:attribute>
    </xsl:if>
  </img>
</xsl:template>

<!-- miscellaneous html -->
<xsl:template match="a|div|em|h1|h2|h3|h4|h5|h6|li|ol|pre|ul">
  <xsl:element name="{local-name(.)}">
    <xsl:for-each select="@*">
      <!-- Wait: some of these aren't HTML attributes after all... -->
      <xsl:choose>
        <xsl:when test="local-name(.) = 'role'">
          <xsl:attribute name="class">
            <xsl:value-of select="."/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="local-name(.) = 'css'">
          <xsl:attribute name="style">
            <xsl:value-of select="."/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<!-- p: a standard paragraph -->
<xsl:template match="p">
<p>
  <xsl:if test="@id">
    <xsl:attribute name="id">
      <xsl:value-of select="@id"/>
    </xsl:attribute>
  </xsl:if>
  <xsl:if test="@role">
    <xsl:attribute name="class">
      <xsl:value-of select="@role"/>
    </xsl:attribute>
  </xsl:if>
  <xsl:if test="@css">
    <xsl:attribute name="style">
      <xsl:value-of select="@css"/>
    </xsl:attribute>
  </xsl:if>
  <xsl:apply-templates/>
</p>
</xsl:template>

<!-- term: the actual mention of a term within a termdef -->
<xsl:template match="term">
  <em><xsl:apply-templates/></em>
</xsl:template>

<!-- termdef: sentence or phrase defining a term -->
<xsl:template match="termdef">
  <a id="{@id}" title="{@term}">
    <xsl:apply-templates/>
  </a>
</xsl:template>

</xsl:stylesheet>
