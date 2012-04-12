<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform exclude-result-prefixes="saxon" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://icl.com/saxon">
<xsl:import href="xmlspec.xsl"></xsl:import>
<xsl:param name="show.ednotes">1</xsl:param>
<xsl:param name="show.diff.markup">1</xsl:param>
<xsl:variable name="output.mode" select="'xhtml'"/>
<xsl:param name="additional.css">
<xsl:text>
div.issue { border: 2px solid black; background-color: #ffff66; padding: 0em 1em; margin: 0em 0em }
table.ednote { border-collapse: collapse; border: 2px solid black; width: 80% }
table.ednote td { background-color: #ff9966; border: 2px solid black }
table.acronyms td.label { width: 15% }
table.acronyms td.def { width: 65% }
table.graphic { border: 0px none black; width: 100%; border-collapse: collapse }
table.graphic caption { font-weight: bold; text-align: center; padding-bottom: 0.5em }
table.graphic td { border: 0px none black; text-align: center }
.tbd { background-color: #ffff33; border: 2px solid black; width: 85% }
.strong { font-weight: bold }
.diff-add  { color: red; }
.diff-del  { color: red; text-decoration: line-through; }
.diff-chg  { background-color: #99FF99; }
.diff-off  {}
</xsl:text>
</xsl:param>
<xsl:output method="xml" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<!-- diff support -->
<xsl:template name="diff-markup">
  <xsl:param name="diff">off</xsl:param>
  <xsl:choose>
    <xsl:when test="self::ritem">
	<xsl:apply-templates select="." mode="diff"/>
    </xsl:when>
    <xsl:when test="self::ulist or self::p or self::bibl">
      <xsl:apply-templates/>
    </xsl:when>
    <xsl:when test="ancestor-or-self::phrase">
      <span xmlns="http://www.w3.org/1999/xhtml" class="diff-{$diff}">
	<xsl:apply-templates/>
      </span>
    </xsl:when>
    <xsl:when test="ancestor::p and not(self::p)">
      <span xmlns="http://www.w3.org/1999/xhtml" class="diff-{$diff}">
	<xsl:apply-templates/>
      </span>
    </xsl:when>
    <xsl:when test="ancestor-or-self::affiliation">
      <span xmlns="http://www.w3.org/1999/xhtml" class="diff-{$diff}">
	<xsl:apply-templates/>
      </span>
    </xsl:when>
    <xsl:when test="ancestor-or-self::name">
      <span xmlns="http://www.w3.org/1999/xhtml" class="diff-{$diff}">
	<xsl:apply-templates/>
      </span>
    </xsl:when>
    <xsl:otherwise>
      <div xmlns="http://www.w3.org/1999/xhtml" class="diff-{$diff}">
	<xsl:apply-templates/>
      </div>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="*[@diff='chg']">
  <xsl:choose>
    <xsl:when test="$show.diff.markup != 0">
      <xsl:call-template name="diff-markup">
	<xsl:with-param name="diff">chg</xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="*[@diff='add']">
  <xsl:choose>
    <xsl:when test="$show.diff.markup != 0">
      <xsl:call-template name="diff-markup">
	<xsl:with-param name="diff">add</xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="*[@diff='del']">
  <xsl:choose>
    <xsl:when test="$show.diff.markup != 0">
      <xsl:call-template name="diff-markup">
	<xsl:with-param name="diff">del</xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <!-- suppress deleted markup -->
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="*[@diff='off']">
  <xsl:choose>
    <xsl:when test="$show.diff.markup != 0">
      <xsl:call-template name="diff-markup">
	<xsl:with-param name="diff">off</xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
<!-- spec: the specification itself -->
<xsl:template match="spec">
  <html xmlns="http://www.w3.org/1999/xhtml">
    <xsl:if test="header/langusage/language">
      <xsl:attribute name="xml:lang">
	<xsl:value-of select="header/langusage/language/@id"/>
      </xsl:attribute>
      <xsl:attribute name="lang">
	<xsl:value-of select="header/langusage/language/@id"/>
      </xsl:attribute>
    </xsl:if>
    <head>
      <xsl:if test="$output.mode='xhtml'">
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8"/>
      </xsl:if>
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
	  <xsl:text> -- (Editors' copy)</xsl:text>
	</xsl:if>
      </title>
      <xsl:call-template name="css"/>
    </head>
    <body>
      <xsl:if test="/spec/@role='editors-copy'">
	<xsl:value-of select="//revisiondesc/p[1]"/>
	<div id="revisions"/>
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
    </body>
  </html>
</xsl:template>
<!-- status: the status of the spec -->
<xsl:template match="status">
  <div xmlns="http://www.w3.org/1999/xhtml">
    <h2>
      <xsl:call-template name="anchor">
	<xsl:with-param name="conditional" select="0"/>
	<xsl:with-param name="default.id" select="'status'"/>
      </xsl:call-template>
      <xsl:text>Status of this Document</xsl:text>
    </h2>
    <xsl:if test="/spec/@role='editors-copy'">
      <p><strong>This document is an editor's copy that has no official standing.</strong></p>
    </xsl:if>
    <xsl:apply-templates/>
  </div>
</xsl:template>
<!-- specref: reference to another part of the current specification -->
<xsl:template match="specref">
  <xsl:variable name="target" select="key('ids', @ref)[1]"/>
  <xsl:choose>
    <xsl:when test="local-name($target)='issue' or starts-with(local-name($target), 'div') or starts-with(local-name($target), 'inform-div') or local-name($target) = 'vcnote' or local-name($target) = 'prod' or local-name($target) = 'label' or local-name($target) = 'ritem' or local-name($target) = 'table'">
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
      <b xmlns="http://www.w3.org/1999/xhtml">
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
<!-- ednote: editors' note -->
<xsl:template match="ednote">
  <xsl:if test="$show.ednotes != 0">
    <table xmlns="http://www.w3.org/1999/xhtml" border="1" class="ednote">
      <xsl:attribute name="summary">
	<xsl:text>Editorial note</xsl:text>
	<xsl:if test="name">
	  <xsl:text>: </xsl:text>
	  <xsl:value-of select="name"/>
	</xsl:if>
      </xsl:attribute>
      <tr class="ednote-r1">
	<td align="left" valign="top">
	  <b>
	    <xsl:text>Editorial note</xsl:text>
	    <xsl:if test="name">
	      <xsl:text>: </xsl:text>
	      <xsl:apply-templates select="name"/>
	    </xsl:if>
	  </b>
	</td>
	<td align="right" valign="top">
	  <xsl:choose>
	    <xsl:when test="date">
	      <xsl:apply-templates select="date"/>
	    </xsl:when>
	    <xsl:otherwise> </xsl:otherwise>
	  </xsl:choose>
	</td>
      </tr>
      <tr class="ednote-r2">
	<td colspan="2" align="left" valign="top">
	  <xsl:apply-templates select="edtext"/>
	</td>
      </tr>
    </table>
  </xsl:if>
</xsl:template>
<!-- glist: glossary list -->
<xsl:template match="glist">
  <xsl:choose>
  <xsl:when test="@role = 'acronyms'">
    <table xmlns="http://www.w3.org/1999/xhtml" class="acronyms">
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
      <dl xmlns="http://www.w3.org/1999/xhtml">
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
  <td xmlns="http://www.w3.org/1999/xhtml" class="label">
    <xsl:call-template name="anchor">
      <xsl:with-param name="node" select=".."/>
    </xsl:call-template>
    <xsl:call-template name="anchor"/>
    <b><xsl:apply-templates/></b>
  </td>
</xsl:template>
<!-- def: acronym mode -->
<xsl:template mode="acronym" match="def">
  <td xmlns="http://www.w3.org/1999/xhtml" class="def">
  <xsl:apply-templates/>
  </td>
</xsl:template>
<!-- loc: a Web location -->
<xsl:template match="loc">
  <a xmlns="http://www.w3.org/1999/xhtml" href="{@href}">
    <xsl:if test="@role">
      <xsl:attribute name="rel">
	<xsl:value-of select="@role"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </a>
</xsl:template>
<!-- rlist: requirement list -->
<xsl:template match="rlist">
  <dl xmlns="http://www.w3.org/1999/xhtml">
    <xsl:apply-templates/>
  </dl>
</xsl:template>
<!-- ritem: requirement item -->
<xsl:template match="ritem">
  <xsl:variable name="this-req-id">
    <xsl:choose>
      <xsl:when test="@id">
	<xsl:value-of select="@id"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="generate-id(.)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <dt xmlns="http://www.w3.org/1999/xhtml">
    <xsl:if test="@id">
      <a name="{@id}" id="{@id}"/>
    </xsl:if>
    <xsl:value-of select="$this-req-id"/>
    <xsl:text disable-output-escaping="yes"> &#38;ndash; </xsl:text>
    <xsl:apply-templates select="head" mode="text"/>
  </dt>
  <dd xmlns="http://www.w3.org/1999/xhtml">
    <xsl:apply-templates select="req"/>
  </dd>
</xsl:template>
<!-- ritem: requirement item; mode(diff) -->
<xsl:template match="ritem" mode="diff">
  <xsl:variable name="diffval" select="ancestor-or-self::*/@diff"/>
  <xsl:variable name="this-req-id">
    <xsl:choose>
      <xsl:when test="@id">
	<xsl:value-of select="@id"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="generate-id(.)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:choose>
    <xsl:when test="$diffval='del' and $show.diff.markup = 0">
      <!-- delete item -->
    </xsl:when>
    <xsl:otherwise>
      <dt xmlns="http://www.w3.org/1999/xhtml" class="diff-{$diffval}">
	<xsl:if test="@id">
	  <a name="{@id}" id="{@id}"/>
	</xsl:if>
	<xsl:value-of select="$this-req-id"/>
	<xsl:text disable-output-escaping="yes"> &#38;ndash; </xsl:text>
	<xsl:apply-templates select="head" mode="text"/>
      </dt>
      <dd xmlns="http://www.w3.org/1999/xhtml" class="diff-{$diffval}">
	<xsl:apply-templates select="req"/>
      </dd>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
<xsl:template match="ritem" mode="specref">
  <a xmlns="http://www.w3.org/1999/xhtml">
    <xsl:attribute name="href">
      <xsl:call-template name="href.target"/>
    </xsl:attribute>
    <b>
      <xsl:apply-templates select="head" mode="text"/>
    </b>
  </a>
</xsl:template>
<!-- req: requirement body -->
<xsl:template match="req">
  <div xmlns="http://www.w3.org/1999/xhtml" class="req">
    <xsl:apply-templates/>
  </div>
</xsl:template>
<!-- uselist: use case scenario list -->
<xsl:template match="uselist">
  <dl xmlns="http://www.w3.org/1999/xhtml">
    <xsl:apply-templates/>
  </dl>
</xsl:template>
<!-- useitem: use case scenario item -->
<xsl:template match="useitem">
  <xsl:variable name="this-use-id">
    <xsl:choose>
      <xsl:when test="@id">
	<xsl:value-of select="@id"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="generate-id(.)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <dt xmlns="http://www.w3.org/1999/xhtml">
    <xsl:if test="@id">
      <a name="{@id}" id="{@id}"/>
    </xsl:if>
    <xsl:value-of select="$this-use-id"/>
    <xsl:text disable-output-escaping="yes"> &#38;ndash; </xsl:text>
    <xsl:apply-templates select="head" mode="text"/>
  </dt>
  <dd xmlns="http://www.w3.org/1999/xhtml">
    <xsl:apply-templates select="use"/>
  </dd>
</xsl:template>
<xsl:template match="useitem" mode="specref">
  <a xmlns="http://www.w3.org/1999/xhtml">
    <xsl:attribute name="href">
      <xsl:call-template name="href.target"/>
    </xsl:attribute>
    <b>
      <xsl:apply-templates select="head" mode="text"/>
    </b>
  </a>
</xsl:template>
<!-- use: use case scenario body -->
<xsl:template match="use">
  <div xmlns="http://www.w3.org/1999/xhtml" class="use">
    <xsl:apply-templates/>
  </div>
</xsl:template>
<!-- ulist w/diff -->
<xsl:template match="ulist[@diff]" priority="1">
  <xsl:variable name="diffval" select="ancestor-or-self::*/@diff"/>
  <ul xmlns="http://www.w3.org/1999/xhtml" class="diff-{$diffval}">
    <xsl:apply-templates/>
  </ul>
</xsl:template>
<!-- p w/diff -->
<xsl:template match="p[@diff]" priority="1">
  <xsl:variable name="diffval" select="ancestor-or-self::*/@diff"/>
  <p xmlns="http://www.w3.org/1999/xhtml" class="diff-{$diffval}">
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
    <xsl:apply-templates/>
  </p>
</xsl:template>
<!-- bibl w/diff -->
<xsl:template match="bibl[@diff]" priority="1">
  <xsl:variable name="diffval" select="ancestor-or-self::*/@diff"/>
  <dt xmlns="http://www.w3.org/1999/xhtml" class="label diff-{$diffval}">
    <xsl:if test="@id">
      <a name="{@id}" id="{@id}"/>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="@key">
	<xsl:value-of select="@key"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="@id"/>
      </xsl:otherwise>
    </xsl:choose>
  </dt>
  <dd xmlns="http://www.w3.org/1999/xhtml" class="diff-{$diffval}">
    <xsl:choose>
      <xsl:when test="@href">
	<a href="{@href}">
	  <xsl:apply-templates/>
	</a>
      </xsl:when>
      <xsl:otherwise>
	<xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="@href">
      <xsl:text>  (See </xsl:text>
      <xsl:value-of select="@href"/>
      <xsl:text>.)</xsl:text>
    </xsl:if>
  </dd>
</xsl:template>
<!-- table -->
<xsl:template match="table">
  <table xmlns="http://www.w3.org/1999/xhtml">
    <xsl:for-each select="@*">
      <xsl:choose>
	<xsl:when test="local-name(.) = 'diff'"/>
	<xsl:when test="local-name(.) = 'role'">
	  <xsl:attribute name="class">
	    <xsl:value-of select="."/>
	  </xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:copy>
	    <xsl:apply-templates/>
	  </xsl:copy>
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
  <a xmlns="http://www.w3.org/1999/xhtml">
    <xsl:attribute name="href">
      <xsl:call-template name="href.target"/>
    </xsl:attribute>
    <b>
      <xsl:apply-templates select="caption" mode="text"/>
    </b>
  </a>
</xsl:template>
</xsl:transform>
