<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-tpl-struct-inslib.xsl 1434 2011-05-31 18:23:56Z gabrielbodard $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:gcse="notthere"
   xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
   <!-- 
 WORK IN PROGRESS file structure for EAGLE / Epidoc Workshop 
meant to be run in a folder with other data locally referred
  -->

   <!-- Called from htm-tpl-structure.xsl -->
   
   

   <xsl:template name="TEST-structure">
      <xsl:variable name="title">
         <xsl:choose>
            <xsl:when test="//t:titleStmt/t:title/text()">
               <xsl:if test="//t:publicationStmt/t:idno[@type='filename']/text()">
                  <xsl:value-of select="substring(//t:publicationStmt/t:idno[@type='filename'],1,5)"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of
                     select="number(substring(//t:publicationStmt/t:idno[@type='filename'],6,6)) div 100"/>
                  <xsl:text> </xsl:text>
               </xsl:if>
               <xsl:value-of select="//t:titleStmt/t:title"/>
            </xsl:when>
            <xsl:when test="//t:sourceDesc//t:bibl/text()">
               <xsl:value-of select="//t:sourceDesc//t:bibl"/>
            </xsl:when>
            <xsl:when test="//t:idno[@type='filename']/text()">
               <xsl:value-of select="//t:idno[@type='filename']"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text>Epigrafi Digitali</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <html>
         <head>
            
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <title>
               <xsl:value-of select="$title"/>
            </title>
            <!-- Found in htm-tpl-cssandscripts.xsl -->
            <link rel="stylesheet" href="../graficagenerale.css" type="text/css"/>
         </head>

         <body>
            <div id="header"><h1>
               <xsl:value-of select="$title"/>
            </h1></div>

            <div id="nav">
               <a href="../index.html">Home Page</a><br/>
               <br/>
               <a href="../browseinscriptions.html">Lista dei testi</a><br/>
               <br/>
               <a href="../inscriptionsbyplace.html">Indice dei luoghi</a><br/>
               <br/>
               <a href="../browsebytypes.html">Indici</a><br/>
               
            </div>
            

<div id="section">
<div class="ids">
<b>Source: </b><xsl:value-of select="//t:authority"/>
<br/>
   <xsl:if test="//t:idno[@type='TM']/text()"><b>Trismegistos ID: </b> <a target="_blank"><xsl:attribute name="href">
   <xsl:value-of select="concat('http://www.trismegistos.org/text/', //t:idno[@type=TM])"/>
</xsl:attribute><xsl:value-of select="//t:idno[@type='TM']"/></a></xsl:if>
<br/>
   <xsl:if test="//t:publicationStmt/t:idno[not(@type='URI') and not(@type='localID') and not(@type='TM')]"><b>Other IDs: </b>
      <xsl:for-each select="//t:publicationStmt/t:idno[not(@type='URI') and not(@type='localID') and not(@type='TM')]">
<xsl:value-of select="."/>
</xsl:for-each></xsl:if>
<br/>
<b>Author: </b> <xsl:value-of select="//t:change[position()=last()]"/>
</div>
            <div class="sourceDesc">
               <h3>Description</h3>
               <xsl:if test="//t:objectType/text()"><b>Object type: </b>
               <xsl:choose>
                  <xsl:when test="//t:objectType/text()">
                     <a target="_blank">
<xsl:attribute name="href">
   <xsl:value-of select="concat(//t:objectType/@ref,'.html')"/>
</xsl:attribute>
                        <xsl:value-of select="//t:objectType/text()"/></a>
                  </xsl:when>
                  <xsl:otherwise>Unknown</xsl:otherwise>
               </xsl:choose></xsl:if>
               <xsl:if test="//t:material/text()">               <br/>
               <b>Material: </b>
               <xsl:choose>
                  <xsl:when test="//t:material/text()">
                     <a target="_blank">
                        <xsl:attribute name="href">
                           <xsl:value-of select="concat(//t:material/@ref,'.html')"/>
                        </xsl:attribute>
                        <xsl:value-of select="//t:material/text()"/></a>
                  </xsl:when>
                  <xsl:otherwise>Unknown</xsl:otherwise>
               </xsl:choose></xsl:if>
               <xsl:if test="//t:keywords/t:term/text()"><br/>               
               <b>Type of Inscription: </b>
               <xsl:choose>
                  <xsl:when test="//t:keywords/t:term/text()">
                     <a target="_blank">
                        <xsl:attribute name="href">
                           <xsl:value-of select="concat(//t:keywords/t:term/@ref,'.html')"/>
                        </xsl:attribute>
                        <xsl:value-of select="//t:keywords/t:term/text()"/></a>
                  </xsl:when>
                  <xsl:otherwise>Unknown</xsl:otherwise>
               </xsl:choose></xsl:if>
               <xsl:if test="//t:layoutDesc/t:layout//t:rs[@type='execution']/text()"><br/>
<b>Execution Technique: </b>
               <xsl:choose>
                  <xsl:when test="//t:layoutDesc/t:layout">
                     <a target="_blank">
<xsl:attribute name="href">
   <xsl:value-of select="//t:layoutDesc/t:layout//t:rs[@type='execution']/@ref"/>
</xsl:attribute>
                        <xsl:value-of select="//t:layoutDesc/t:layout//t:rs[@type='execution']"/></a>
                  </xsl:when>
                  <xsl:otherwise>Unknown</xsl:otherwise>
               </xsl:choose></xsl:if>
               <br/>
               <b>Letters: </b>
               <xsl:if test="//t:handDesc/t:handNote/text()">
                  <xsl:value-of select="//t:handDesc/t:handNote"/>
               </xsl:if>
               <br/>
               <b>Provenance: </b>
               <xsl:choose>
                  <xsl:when
                     test="//t:origPlace">
                     <a target="_blank">
<xsl:attribute name="href">
   <xsl:value-of select="//t:origPlace//t:placeName[not(@type)]/@ref"/>
</xsl:attribute>
                        <xsl:value-of select="//t:origPlace//t:placeName[not(@type)]"/></a>
                     <xsl:if test="//t:origPlace//t:placeName[@type='provinceItalicRegion']"><xsl:text>, </xsl:text>
                        <a target="_blank">
                        <xsl:attribute name="href">
                           <xsl:value-of select="//t:origPlace//t:placeName[@type='provinceItalicRegion']/@ref"/>
                        </xsl:attribute>
                        <xsl:value-of select="//t:origPlace//t:placeName[@type='provinceItalicRegion']"/></a>
                     </xsl:if>
                  </xsl:when>
                  <xsl:otherwise>Unknown</xsl:otherwise>
               </xsl:choose>
               <br/>
               <b>Findspot: </b>
               <xsl:choose>
                  <xsl:when
                     test="//t:provenance[@type='found']">
                     <xsl:if test="//t:provenance[@type='found']//t:placeName[not(@type)]">
                        <xsl:value-of select="//t:provenance[@type='found']//t:placeName[not(@type)]"/></xsl:if>
                     <xsl:if test="//t:provenance[@type='found']//t:placeName[@type='modern_region']"><xsl:text>, </xsl:text>
                        <xsl:value-of select="//t:provenance[@type='found']//t:placeName[@type='modern_region']"/></xsl:if><xsl:if test="//t:provenance[@type='found']//t:placeName[@type='modernCountry']"><xsl:text>, </xsl:text>
                     <xsl:value-of select="//t:provenance[@type='found']//t:placeName[@type='modernCountry']"/></xsl:if>
                  </xsl:when>
                  <xsl:otherwise>Unknown</xsl:otherwise>
               </xsl:choose>
               <xsl:if test="//t:origin/t:origDate/text()"><br/>
                  <b>Date: </b>
                  <xsl:choose>
                     <xsl:when test="//t:origin/t:origDate/text()">
                        <xsl:value-of select="//t:origin/t:origDate"/>
                        <xsl:if test="//t:origin/t:origDate[@type='evidence']">
                           <xsl:text>(</xsl:text>
                           <xsl:for-each select="tokenize(//t:origin/t:origDate[@evidence],' ')">
                              <xsl:value-of select="translate(.,'-',' ')"/>
                              <xsl:if test="position()!=last()">
                                 <xsl:text>, </xsl:text>
                              </xsl:if>
                           </xsl:for-each>
                           <xsl:text>)</xsl:text>
                        </xsl:if>
                     </xsl:when>
                     <xsl:otherwise>Non disponibili</xsl:otherwise>
                  </xsl:choose>
               </xsl:if>
               <br/>
               
            <br/>
               <h3>Bibliography: </h3>
     <ul>
<xsl:for-each select="//t:bibl">
        <li><xsl:value-of select="."/></li>
</xsl:for-each>
        </ul>
<br/>
               
            </div>            
<div id="edition">
              <!-- <p>
                  <b>Edition:</b>
               </p>-->
               <!-- Edited text output -->
               <xsl:variable name="edtxt">
                  <xsl:apply-templates select="//t:div[@type='edition']"/>
               </xsl:variable>
               <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
               <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
            </div>
            
<div id="sorgente">
<br/>
<p><b>File sorgente prodotto da: </b>
   <xsl:apply-templates select="//t:creation"/></p>
   <p><a target="_blank" href="{concat('https://github.com/EAGLE-BPN/Inscriptions-from-Dacia/blob/master/xml/text/',//t:idno[@type='localID'],'.xml')}">See this file in GIT.</a></p> 

   <br/>
</div> 
   
   <xsl:if test="//t:div[@type='translation']//t:p">
      <br/>
      <div class="row" id="translation">
         <h3 class="slimmer">Translation:</h3>
         <!-- Translation text output -->
         <xsl:variable name="transtxt">
            <xsl:apply-templates select="//t:div[@type='translation']//t:p"/>
         </xsl:variable>
         <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
         <xsl:apply-templates select="$transtxt" mode="sqbrackets"/>
      </div></xsl:if>
   
   <xsl:if test="//t:div[@type='commentary']//t:p">
      <br/>
      <div class="row" id="commentary">
         <h3 class="slimmer">Commentary:</h3>
         <!-- Commentary text output -->
         <xsl:variable name="commtxt">
            <xsl:apply-templates select="//t:div[@type='commentary']//t:p"/>
         </xsl:variable>
         <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
         <xsl:apply-templates select="$commtxt" mode="sqbrackets"/>
      </div></xsl:if>

<div id="images">
   <xsl:if test="//t:graphic[not(@rend='externalLink')]"> 
<h3>Photos</h3>
   <xsl:for-each select="//t:graphic[not(@rend='externalLink')]">
      <a target="_blank" href="{./@sameAs}">
         <xsl:attribute name="author">
            <xsl:text>By </xsl:text><xsl:value-of select="//t:change"/><xsl:text> [</xsl:text><xsl:value-of select="//t:licence"/><xsl:text>], via Wikimedia Commons</xsl:text>
         </xsl:attribute>
         <img style="width:280px">
<xsl:attribute name="src">
<xsl:value-of select="./@url"/>
</xsl:attribute>
      <xsl:attribute name="alt">
         <xsl:value-of select="normalize-space(t:desc)"/>
      </xsl:attribute>
   </img></a> 
   </xsl:for-each></xsl:if>
   <xsl:if test="//t:graphic[@rend='externalLink']"><br/>
<h3>Other Photos</h3>
   <xsl:for-each select="//t:graphic[@rend='externalLink']">
      <a target="_blank" href="{//t:graphic/@url}"><xsl:value-of select="//t:graphic/@url"/></a>
</xsl:for-each></xsl:if>
</div>
</div>

            <div id="footer"><xsl:value-of select="//t:authority"/> - <a target="_blank" href="{//t:licence/@target}"><xsl:value-of select="//t:licence"/></a> - <xsl:value-of select="//t:change[position()=last()]"/></div>
         </body>
      </html>
   </xsl:template>

   
</xsl:stylesheet>
