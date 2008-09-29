<!-- XMLSPEC local element declarations -->
<!-- $Id$ -->

<!--    rlist: requirements list. -->
<!ENTITY % rlist.element "INCLUDE">
<![%rlist.element;[
<!ELEMENT rlist (ritem)*>
<!ATTLIST rlist %common.att;>
]]>

<!--    ritem: requirement list item. -->
<!ENTITY % ritem.element "INCLUDE">
<![%ritem.element;[
<!ELEMENT ritem (head, req)>
<!ATTLIST ritem %common.att;
  type (dreq|freq|sreq|nreq|other) #REQUIRED
>
]]>

<!--    req: requirement description. -->
<!ENTITY % req.element "INCLUDE">
<![%req.element;[
<!ELEMENT req (%obj.mix;)*>
<!ATTLIST req %common.att;>
]]>

<!--    uselist: use case scenario list. -->
<!ENTITY % uselist.element "INCLUDE">
<![%uselist.element;[
<!ELEMENT uselist (useitem)*>
<!ATTLIST uselist %common.att;>
]]>

<!--    useitem: use case scenario item. -->
<!ENTITY % useitem.element "INCLUDE">
<![%useitem.element;[
<!ELEMENT useitem (head, use)>
<!ATTLIST useitem %common.att;
  type (simple|other) #REQUIRED
>
]]>

<!--    use: use case description. -->
<!ENTITY % use.element "INCLUDE">
<![%use.element;[
<!ELEMENT use (%obj.mix;)*>
<!ATTLIST use %common.att;>
]]>

<!--    rfc2119: conformance keyword. -->
<!ENTITY % rfc2119.element "INCLUDE">
<![%rfc2119.element;[
<!ELEMENT rfc2119 (%tech.pcd.mix;)*>
<!ATTLIST rfc2119 %common.att;>
]]>
