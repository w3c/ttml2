<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:import href="xmlspec.xsl"/>
    <xsl:import href="changelog.xsl"/>

    <xsl:output method="xml" encoding="utf-8"
        doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="no"/> 

    <xsl:template match="inform-div1[head='Change Log']/p">
        <xsl:apply-templates select="document('changelog.xml')">
        </xsl:apply-templates>
    </xsl:template>
    <!-- bibref: reference to a bibliographic entry -->
    <!-- make a link to the bibl -->
    <!-- if the bibl has a key, put it in square brackets; otherwise use
       the bibl's ID -->
    <xsl:template match="bibref">
<!--        <xsl:text>[</xsl:text> -->
        <cite xmlns="http://www.w3.org/1999/xhtml">
            <a xmlns="http://www.w3.org/1999/xhtml">
                <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                        <xsl:with-param name="target" select="id(@ref)"/>
                    </xsl:call-template>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="id(@ref)/@key">
                        <xsl:value-of select="id(@ref)/@key"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@ref"/>
                    </xsl:otherwise>
                </xsl:choose>
            </a>
        </cite>
<!--        <xsl:text>]</xsl:text> -->
    </xsl:template>
    <xsl:template match="bibl">
        <dt xmlns="http://www.w3.org/1999/xhtml" class="label">
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="@diff and $show.diff.markup != 0">
                        <xsl:text>diff-</xsl:text>
                        <xsl:value-of select="@diff"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>label</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:if test="@id">
                <a xmlns="http://www.w3.org/1999/xhtml" name="{@id}"/>
            </xsl:if>
            <xsl:text>[</xsl:text>
            <xsl:choose>
                <xsl:when test="@key">
                    <xsl:value-of select="@key"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@id"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>] </xsl:text>
        </dt>
        <dd xmlns="http://www.w3.org/1999/xhtml">
            <xsl:if test="@diff and $show.diff.markup != 0">
                <xsl:attribute name="class">
                    <xsl:text>diff-</xsl:text>
                    <xsl:value-of select="@diff"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
            <xsl:if test="not(titleref) and @href">
                <xsl:text> (See </xsl:text>
                <cite xmlns="http://www.w3.org/1999/xhtml">
                    <a xmlns="http://www.w3.org/1999/xhtml" href="{@href}">
                        <xsl:value-of select="@href"/>
                    </a>
                </cite>
                <xsl:text>.)</xsl:text>
            </xsl:if>
        </dd>
    </xsl:template>
    <xsl:template match="titleref">
        <xsl:choose>
            <xsl:when test="../@href">
                <cite xmlns="http://www.w3.org/1999/xhtml">
                    <a xmlns="http://www.w3.org/1999/xhtml" href="{../@href}">
                        <xsl:apply-templates/>
                    </a>
                </cite>
            </xsl:when>
            <xsl:otherwise>
                <cite xmlns="http://www.w3.org/1999/xhtml">
                    <xsl:apply-templates/>
                </cite>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--
    <xsl:template match="b">
        <b xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates/>
        </b>
    </xsl:template>
    <xsl:template match="u">
        <u xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates/>
        </u>
    </xsl:template>
    <xsl:template match="i">
        <i xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates/>
        </i>
    </xsl:template>
-->
    <xsl:template match="emph[@role='infoset-property']">
        <strong xmlns="http://www.w3.org/1999/xhtml">
            <xsl:text>[</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]</xsl:text>
        </strong>
    </xsl:template>

    <!-- Filtering term definitions in the terminology section. These are taken from the WS-Policy-Framework document and are handled separately in extract-glist.xsl .-->
    <xsl:template match="ulist[@role='termreference']"/>

    <!-- Adding numbers to examples automatically. Template taken from xmlspec.xsl and modified. -->
    <xsl:template match="eg[@role='needs-numbering']">
        <xsl:variable name="content">
            <pre xmlns="http://www.w3.org/1999/xhtml">
        <xsl:if test="@diff and $show.diff.markup='1'">
          <xsl:attribute name="class">
            <xsl:text>diff-</xsl:text>
            <xsl:value-of select="@diff"/>
          </xsl:attribute>
        </xsl:if>
     <xsl:call-template name="addLineNumbers"/>
      </pre>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$tabular.examples = 0">
                <div xmlns="http://www.w3.org/1999/xhtml" class="exampleInner">
                    <xsl:copy-of select="$content"/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <table xmlns="http://www.w3.org/1999/xhtml" class="eg" cellpadding="5" border="1" bgcolor="#99ffff" width="100%"
                    summary="Example">
                    <tr xmlns="http://www.w3.org/1999/xhtml">
                        <td xmlns="http://www.w3.org/1999/xhtml">
                            <xsl:copy-of select="$content"/>
                        </td>
                    </tr>
                </table>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="addLineNumbers">
        <xsl:variable name="egWithLb" as="item()*">
            <egWithLb>
                <lb/>
                <xsl:for-each select="text()|node()">
                    <xsl:choose>
                        <xsl:when test="self::text()">
                            <xsl:analyze-string select="." regex="&#xA;">
                                <xsl:matching-substring>
                                    <xsl:text>&#xA;</xsl:text>
                                    <lb/>
                                </xsl:matching-substring>
                                <xsl:non-matching-substring>
                                    <xsl:value-of select="."/>
                                </xsl:non-matching-substring>
                            </xsl:analyze-string>
                        </xsl:when>
                        <xsl:when test="self::emph">
                            <b xmlns="http://www.w3.org/1999/xhtml">
                                <xsl:copy-of select="*|text()"/>
                            </b>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="."/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </egWithLb>
        </xsl:variable>
        <xsl:apply-templates select="$egWithLb/node()" mode="addLineNumbers"/>
    </xsl:template>
    <xsl:template match="lb" mode="addLineNumbers">
        <xsl:choose>
            <xsl:when test="not(contains(self::lb/following-sibling::text()[1],'xmlns'))">
                <xsl:text>(</xsl:text>
                <xsl:number format="01"
                    count="lb[not(contains(self::lb/following-sibling::text()[1],'xmlns'))]"/>
                <xsl:text>) </xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="node()" mode="addLineNumbers">
        <xsl:copy-of select="."/>
    </xsl:template>

    <!-- Used for wsdl11elementidentifiers.xml to allow italics within 
code -->
    <xsl:template match="code[@role='code-emph']">
        <code xmlns="http://www.w3.org/1999/xhtml" style="font-style: italic;">
            <xsl:value-of select="."/>
        </code>
    </xsl:template>
<!-- Template for Best practices output, used only for guidelines document.-->
    <xsl:template match="p[@role='practice']">
        <xsl:variable name="practicenumber">
            <xsl:number count="p[@role='practice']" level="any"/>
        </xsl:variable>
        <div xmlns="http://www.w3.org/1999/xhtml" class="boxedtext">
            <p xmlns="http://www.w3.org/1999/xhtml">
                <a xmlns="http://www.w3.org/1999/xhtml" name="{@id}" id="{@id}"/>
                <span xmlns="http://www.w3.org/1999/xhtml" class="practicelab">
                    <xsl:text>Best
Practice </xsl:text>
                    <xsl:value-of select="$practicenumber"/>
                    <xsl:text>: </xsl:text>
                    <xsl:value-of select="quote[1]"/>
                </span>
            </p>
            <p xmlns="http://www.w3.org/1999/xhtml" class="practice">
                <xsl:value-of select="quote[2]"/>
            </p>
        </div>
    </xsl:template>
    <xsl:template name="css">
     <style xmlns="http://www.w3.org/1999/xhtml" type="text/css">
/*<![CDATA[*/
code           { font-family: monospace; }

div.constraint,
div.issue,
div.note,
div.notice     { margin-left: 2em; }

ol.enumar      { list-style-type: decimal; }
ol.enumla      { list-style-type: lower-alpha; }
ol.enumlr      { list-style-type: lower-roman; }
ol.enumua      { list-style-type: upper-alpha; }
ol.enumur      { list-style-type: upper-roman; }

dt.label       { display: run-in; }

li, p           { margin-top: 0.3em;
                 margin-bottom: 0.3em; }

.diff-chg       { background-color: yellow; }
.diff-del       { background-color: red; text-decoration: line-through;}
.diff-add       { background-color: lime; }

table          { empty-cells: show; }

table caption {
        font-weight: normal;
        font-style: italic;
        text-align: left;
        margin-bottom: .5em;
}

div.issue {
  color: red;
}
.rfc2119 {
  font-variant: small-caps;
}

div.exampleInner pre { margin-left: 1em;
                       margin-top: 0em; margin-bottom: 0em}
div.exampleOuter {border: 4px double gray;
                  margin: 0em; padding: 0em}
div.exampleInner { background-color: #d5dee3;
                   border-top-width: 4px;
                   border-top-style: double;
                   border-top-color: #d3d3d3;
                   border-bottom-width: 4px;
                   border-bottom-style: double;
                   border-bottom-color: #d3d3d3;
                   padding: 4px; margin: 0em }
div.exampleWrapper { margin: 4px }
div.exampleHeader { font-weight: bold;
                    margin: 4px}

div.boxedtext {
   border: solid #bebebe 1px;
   margin: 2em 1em 1em 2em;
 }

span.practicelab {
   margin: 1.5em 0.5em 1em 1em;
   font-weight: bold;
   font-style: italic;
 }

span.practicelab   { background: #dfffff; }

 span.practicelab {
   position: relative;
   padding: 0 0.5em;
   top: -1.5em;
 }
p.practice
{
   margin: 1.5em 0.5em 1em 1em;
 }

@media screen {
 p.practice {
   position: relative;
   top: -2em;
   padding: 0;
   margin: 1.5em 0.5em -1em 1em;
}
}
/*]]>*/
      <xsl:value-of select="$additional.css"/>
    </style>
    <link xmlns="http://www.w3.org/1999/xhtml" rel="stylesheet" type="text/css">
      <xsl:attribute name="href">
        <xsl:text>http://www.w3.org/StyleSheets/TR/</xsl:text>
        <xsl:choose>
          <xsl:when test="/spec/@role='editors-copy'">base</xsl:when>
          <xsl:otherwise>
            <xsl:choose>
	      <!-- Editor's review drafts are a special case. -->
              <xsl:when test="/spec/@w3c-doctype='review'
			      or contains(/spec/header/w3c-doctype, 'Editor')"
			>base</xsl:when>
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
        <xsl:text>.css</xsl:text>
      </xsl:attribute>
    </link>    
  </xsl:template> 
    
    <!-- Necessary for guidelines document: BP numbering -->
      <xsl:template mode="number" match="p[@role='practice']">
    <xsl:number count="p[@role='practice']" level="any" format="1. "/>
  </xsl:template>
  <xsl:template match="specref">
    <xsl:param name="target" select="key('ids', @ref)[1]"/>

    <xsl:choose>
      <xsl:when test="not($target)">
	<xsl:message>
	  <xsl:text>specref to non-existent ID: </xsl:text>
	  <xsl:value-of select="@ref"/>
	</xsl:message>
      </xsl:when>
        <xsl:when test="$target[local-name()='p' and @role='practice']">
            <a xmlns="http://www.w3.org/1999/xhtml">
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="target" select="id(@ref)"/>
            </xsl:call-template>
          </xsl:attribute>
          <b xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="id(@ref)" mode="number"/>
            <xsl:apply-templates select="id(@ref)/quote[1]" mode="text"/>
          </b>
        </a>
        </xsl:when>
      <xsl:when test="local-name($target)='issue'">
        <xsl:text>[</xsl:text>
        <a xmlns="http://www.w3.org/1999/xhtml">
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="target" select="id(@ref)"/>
            </xsl:call-template>
          </xsl:attribute>
          <b xmlns="http://www.w3.org/1999/xhtml">
            <xsl:text>Issue </xsl:text>
            <xsl:apply-templates select="id(@ref)" mode="number"/>
            <xsl:text>: </xsl:text>
            <xsl:for-each select="id(@ref)/head">
              <xsl:apply-templates/>
            </xsl:for-each>
          </b>
        </a>
        <xsl:text>]</xsl:text>
      </xsl:when>
      <xsl:when test="starts-with(local-name($target), 'div')">
        <a xmlns="http://www.w3.org/1999/xhtml">
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="target" select="id(@ref)"/>
            </xsl:call-template>
          </xsl:attribute>
          <b xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="id(@ref)" mode="divnum"/>
            <xsl:apply-templates select="id(@ref)/head" mode="text"/>
          </b>
        </a>
      </xsl:when>
      <xsl:when test="starts-with(local-name($target), 'inform-div')">
        <a xmlns="http://www.w3.org/1999/xhtml">
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="target" select="id(@ref)"/>
            </xsl:call-template>
          </xsl:attribute>
	  <b xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="id(@ref)" mode="divnum"/>
            <xsl:apply-templates select="id(@ref)/head" mode="text"/>
          </b>
        </a>
      </xsl:when>
      <xsl:when test="local-name($target) = 'vcnote'">
        <b xmlns="http://www.w3.org/1999/xhtml">
          <xsl:text>[VC: </xsl:text>
          <a xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="href">
              <xsl:call-template name="href.target">
                <xsl:with-param name="target" select="id(@ref)"/>
              </xsl:call-template>
            </xsl:attribute>
            <xsl:apply-templates select="id(@ref)/head" mode="text"/>
          </a>
          <xsl:text>]</xsl:text>
        </b>
      </xsl:when>
      <xsl:when test="local-name($target) = 'prod'">
        <b xmlns="http://www.w3.org/1999/xhtml">
          <xsl:text>[PROD: </xsl:text>
          <a xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="href">
              <xsl:call-template name="href.target">
                <xsl:with-param name="target" select="id(@ref)"/>
              </xsl:call-template>
            </xsl:attribute>
            <xsl:apply-templates select="$target" mode="number-simple"/>
          </a>
          <xsl:text>]</xsl:text>
        </b>
      </xsl:when>
      <xsl:when test="local-name($target) = 'label'">
        <b xmlns="http://www.w3.org/1999/xhtml">
          <xsl:text>[</xsl:text>
          <a xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="href">
              <xsl:call-template name="href.target">
                <xsl:with-param name="target" select="id(@ref)"/>
              </xsl:call-template>
            </xsl:attribute>
            <xsl:value-of select="$target"/>
          </a>
          <xsl:text>]</xsl:text>
        </b>
      </xsl:when>
      <!-- MJH added table spec refs -->
      <xsl:when test="local-name($target) = 'table'">
        <a xmlns="http://www.w3.org/1999/xhtml">
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="target" select="id(@ref)"/>
            </xsl:call-template>
          </xsl:attribute>
	  <xsl:text>Table </xsl:text>
	  <xsl:apply-templates select="id(@ref)/caption" mode="divnum"/>
	  <!-- uncomment the following two line to add table captions to references -->
	  <!--<xsl:text>, "</xsl:text>
	  <xsl:apply-templates select="id(@ref)/caption" mode="text"/>
	  <xsl:text>"</xsl:text>
	  -->
        </a>
      </xsl:when>
      <xsl:when test="local-name($target) = 'example'">
        <a xmlns="http://www.w3.org/1999/xhtml">
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="target" select="id(@ref)"/>
            </xsl:call-template>
          </xsl:attribute>
	  <xsl:text>Example </xsl:text>
	  <xsl:apply-templates select="id(@ref)/head" mode="divnum"/>
        </a>
      </xsl:when>
      <xsl:when test="local-name($target) = 'graphic'">
        <a xmlns="http://www.w3.org/1999/xhtml">
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="target" select="id(@ref)"/>
            </xsl:call-template>
          </xsl:attribute>
	  <xsl:text>Figure </xsl:text>
	  <xsl:apply-templates select="id(@ref)" mode="divnum"/>
        </a>
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
          <a xmlns="http://www.w3.org/1999/xhtml">
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
</xsl:stylesheet>
