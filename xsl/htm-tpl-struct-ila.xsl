<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-tpl-struct-inslib.xsl 1434 2011-05-31 18:23:56Z gabrielbodard $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="t" version="2.0">
   <!-- 
 WORK IN PROGRESS file structure for IGCYR 
meant to be run in a folder with other data locally referred
  -->

   <!-- Called from htm-tpl-structure.xsl -->

   <xsl:template name="ILA-structure">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <xsl:variable name="title">
         <xsl:choose>
            <xsl:when test="//t:titleStmt/t:title/text()">
               <xsl:if test="//t:publicationStmt/t:idno[@type = 'filename']/text()">
                  <xsl:value-of select="substring(//t:publicationStmt/t:idno[@type = 'filename'], 1, 5)"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="number(substring(//t:publicationStmt/t:idno[@type = 'filename'], 6, 6)) div 100"/>
                  <xsl:text> </xsl:text>
               </xsl:if>
               <xsl:value-of select="//t:titleStmt/t:title"/>
            </xsl:when>
            <xsl:when test="//t:sourceDesc//t:bibl/text()">
               <xsl:value-of select="//t:sourceDesc//t:bibl"/>
            </xsl:when>
            <xsl:when test="//t:idno[@type = 'filename']/text()">
               <xsl:value-of select="//t:idno[@type = 'filename']"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text>Iscrizioni del Lazio Antico</xsl:text>
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
            <link rel="stylesheet" href="graficagenerale.css" type="text/css"/>
         </head>

         <body>
            <div id="header">
               <h1>
                  <xsl:value-of select="$title"/>
               </h1>
            </div>

            <div id="nav">
               <a href="../index.html">Pagina iniziale</a>
               <br/>
               <br/>
               <a href="../browseinscriptions.html">Lista dei testi</a>
               <br/>
               <br/>
               <a href="../inscriptionsbyplace.html">Indice dei luoghi</a>
               <br/>
               <br/>
               <a href="../browsebytypes.html">Indici</a>
               <br/>

            </div>


            <div id="section">

               <div class="ids">
                  <h3>Edizione di: </h3>
                  <xsl:value-of select="//t:authority"/>
                  <br/>
                  <xsl:if test="//t:idno[@type = 'TM']/text()">
                     <h3>Trismegistos ID: </h3>
                     <a target="_blank">
                        <xsl:attribute name="href">
                           <xsl:value-of select="concat('http://www.trismegistos.org/text/', //t:idno[@type = TM])"/>
                        </xsl:attribute>
                        <xsl:value-of select="//t:idno[@type = 'TM']"/>
                     </a>
                  </xsl:if>

                  <br/>

                  <xsl:if test="//t:idno[@type = 'CIL']/text()">
                     <h3>CIL: </h3>
                     <xsl:value-of select="//t:idno[@type = 'CIL']"/>
                  </xsl:if>
                  <br/>
                  <xsl:if test="//t:idno[@type = 'EDR']/text()">
                     <h3>EDR ID: </h3>
                     <a target="_blank">
                        <xsl:attribute name="href">
                           <xsl:value-of
                              select="concat('http://www.edr-edr.it/edr_programmi/res_complex_comune.php?do=book&amp;id_nr=', //t:idno[@type=EDR])"
                           />
                        </xsl:attribute>
                        <xsl:value-of select="//t:idno[@type = 'EDR']"/>
                     </a>
                  </xsl:if>
                  <br/>

                  <xsl:if
                     test="//t:publicationStmt/t:idno[not(@type = 'URI') and not(@type = 'localID') and not(@type = 'TM')]">
                     <h3>Altri IDs: </h3>
                     <xsl:for-each
                        select="//t:publicationStmt/t:idno[not(@type = 'URI') and not(@type = 'localID') and not(@type = 'TM')]">
                        <xsl:value-of select="."/>
                     </xsl:for-each>
                  </xsl:if>
                  <br/>
               </div>
               <div class="sourceDesc">
                  <h3>Collocazione attuale</h3>
                  <xsl:choose>
                     <xsl:when test="//t:msIdentifier">
                        <xsl:apply-templates select="//t:msIdentifier/t:settlement"/>
                        <xsl:text> </xsl:text>
                        <xsl:apply-templates select="//t:msIdentifier/t:repository"/>
                        <xsl:text> </xsl:text>
                        <xsl:apply-templates select="//t:msIdentifier/t:idno"/>
                     </xsl:when>
                     <xsl:otherwise>Sconosciuta</xsl:otherwise>
                  </xsl:choose>
                  <br/>
                  <h3>Decorazione </h3>
                  <a href="{//t:rs[@type='decoration']/@ref}">
                     <xsl:value-of select="//t:rs[@type = 'decoration']"/>
                  </a>
                  <br/>
                  <h3>Stato di conservazione </h3>
                  <a href="{//t:rs[@type='statPreserv']/@ref}">
                     <xsl:value-of select="//t:rs[@type = 'statPreserv']"/>
                  </a>
                  <h3>Dati archeologici</h3>
                  <xsl:if test="//t:supportDesc">
                     <h4>Descrizione del Supporto </h4>
                     <br/>
                     <xsl:apply-templates select="//t:supportDesc//t:p"/>
                  </xsl:if>
                  <h4>Provenienza </h4>
                  <xsl:apply-templates select="//t:provenance[@type = 'found']"/>
                  <br/>
                  <b>Ultima autopsia:</b>
                  <xsl:apply-templates select="//t:provenance[@type = 'observed']"/>

                  <xsl:if test="//t:origin/t:origDate/text()">
                     <h4>Datazione </h4>
                     <xsl:choose>
                        <xsl:when test="//t:origin/t:origDate/text()">
                           <xsl:value-of select="//t:origin/t:origDate"/>
                           <xsl:if test="//t:origin/t:origDate[@type = 'evidence']">
                              <xsl:text>(</xsl:text>
                              <xsl:for-each select="tokenize(//t:origin/t:origDate[@evidence], ' ')">
                                 <xsl:value-of select="translate(., '-', ' ')"/>
                                 <xsl:if test="position() != last()">
                                    <xsl:text>, </xsl:text>
                                 </xsl:if>
                              </xsl:for-each>
                              <xsl:text>)</xsl:text>
                           </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>Non disponibile</xsl:otherwise>
                     </xsl:choose>
                  </xsl:if>
                  <br/>
               </div>
               <div class="row" id="images">
                  <xsl:if test="//t:graphic[not(@rend = 'externalLink') and not(@rend = 'apographon')]">
                     <h3>Foto</h3>
                     <xsl:for-each select="//t:graphic[not(@rend = 'externalLink') and not(@rend = 'apographon')]">
                        <a target="_blank" href="{./@url}">
                           <xsl:attribute name="author"> Epigraphic Database Roma</xsl:attribute>
                           <img style="width:280px">
                              <xsl:attribute name="src">
                                 <xsl:value-of select="./@url"/>
                              </xsl:attribute>
                              <xsl:attribute name="alt">
                                 <xsl:value-of select="normalize-space(t:desc)"/>
                              </xsl:attribute>
                           </img>
                        </a>
                     </xsl:for-each>
                  </xsl:if>
                  <xsl:if test="//t:graphic[@rend = 'externalLink']">
                     <br/>
                     <h3>Altre foto</h3>
                     <xsl:for-each select="//t:graphic[@rend = 'externalLink']">
                        <a target="_blank" href="{//t:graphic/@url}">
                           <xsl:value-of select="//t:graphic/@url"/>
                        </a>
                     </xsl:for-each>
                  </xsl:if>
               </div>
               <div class="row" id="edition">
                  <h3>Apografo</h3>
                  <!--disegno-->

                  <xsl:for-each select="//t:graphic[@rend = 'apographon']">
                     <a target="_blank" href="{@url}">
                        <img style="width:280px">
                           <xsl:attribute name="src">
                              <xsl:value-of select="@url"/>
                           </xsl:attribute>
                           <xsl:attribute name="alt">
                              <xsl:value-of select="normalize-space(t:desc)"/>
                           </xsl:attribute>
                        </img>
                     </a>
                  </xsl:for-each>
                  <!-- <p>
                  <b>Edition:</b>
               </p>-->
                  <!-- Edited text output -->
                  <h3>Trascrizione</h3>
                  <xsl:variable name="edtxt">
                     <xsl:apply-templates select="//t:div[@type = 'edition']"/>
                  </xsl:variable>
                  <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                  <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>

                  <div id="sorgente">
                     <br/>
                     <b>File sorgente prodotto da: </b>
                     <xsl:apply-templates select="//t:creation"/>
                     <a target="_blank"
                        href="{concat('https://github.com/EAGLE-BPN/ILA/',//t:idno[@type='localID'],'.xml')}"> See this
                        file in GIT.</a>
                  </div>

               </div>
               <xsl:if test="//t:div[@type = 'apparatus']">
                  <div class="row" id="apparatus">
                     <!-- Translation text output -->
                     <xsl:variable name="apptxt">
                        <xsl:apply-templates select="//t:div[@type = 'apparatus']"/>
                     </xsl:variable>
                     <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                     <xsl:apply-templates select="$apptxt" mode="sqbrackets"/>
                  </div>
               </xsl:if>
               <div class="row" id="textDesc">
                  <h3>Tipo di Iscrizione </h3>
                  <xsl:choose>
                     <xsl:when test="//t:keywords/t:term/text()">
                        <a target="_blank">
                           <xsl:attribute name="href">
                              <xsl:value-of select="concat(//t:keywords/t:term/@ref, '.html')"/>
                           </xsl:attribute>
                           <xsl:value-of select="//t:keywords/t:term/text()"/>
                        </a>
                     </xsl:when>
                     <xsl:otherwise>Sconosciuto</xsl:otherwise>
                  </xsl:choose>
                  <br/>
                  <h3>Dati epigrafici</h3>
                  <b>Posizione iscrizione: </b>
                  <xsl:apply-templates select="//t:layoutDesc/t:layout"/>
                  <br/>
                  <b>Scriptura: </b>
                  <xsl:if test="//t:handDesc/t:handNote/text()">
                     <xsl:apply-templates select="//t:handDesc/t:handNote"/>
                  </xsl:if>
               </div>




               <xsl:if test="//t:div[@type = 'translation']//t:p">
                  <br/>
                  <div class="row" id="translation">
                     <h3 class="slimmer">Traduzione:</h3>
                     <!-- Translation text output -->
                     <xsl:variable name="transtxt">
                        <xsl:apply-templates select="//t:div[@type = 'translation']//t:p"/>
                     </xsl:variable>
                     <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                     <xsl:apply-templates select="$transtxt" mode="sqbrackets"/>
                  </div>
               </xsl:if>

               <xsl:if test="//t:div[@type = 'commentary']">
                  <br/>
                  <div class="row" id="commentary">
                     <!-- Commentary text output -->
                     <xsl:variable name="commtxt">
                        <xsl:apply-templates select="//t:div[@type = 'commentary']"/>
                     </xsl:variable>
                     <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                     <xsl:apply-templates select="$commtxt" mode="sqbrackets"/>
                  </div>
               </xsl:if>

               <br/>
               <h3>Bibliografia: </h3>
               <h4>Prima segnalazione</h4>
               <xsl:for-each select="//t:bibl[@subtype = 'primasegnalazione']"><xsl:call-template name="ilabibl"/></xsl:for-each>
               <h4>Editio princeps</h4>
               <xsl:for-each select="//t:bibl[@subtype = 'princeps']"><xsl:call-template name="ilabibl"/></xsl:for-each>
               <h4>Altra Bibliografia</h4>
               <p>
                  <xsl:for-each select="//t:bibl">
                     <xsl:call-template name="ilabibl"/>
                  </xsl:for-each>
               </p>
               <br/>

               <div class="row" id="author">
                  <h3>Autore della scheda</h3>
                  <xsl:value-of select="//t:change[position() = last()]/@who"/>
                  <xsl:text>, ultima modifica: </xsl:text>
                  <xsl:value-of select="//t:change[position() = last()]/@when"/>
               </div>
            </div>

            <div id="footer">
               <xsl:value-of select="//t:authority"/> - <a target="_blank" href="{//t:licence/@target}"><xsl:value-of
                     select="//t:licence"/></a> - ultima revisione <xsl:value-of
                  select="//t:change[position() = last()]/@when"/></div>
         </body>
      </html>

   </xsl:template>

   <xsl:template match="t:height | t:width | t:depth | t:dim[@type = 'diameter']">
      <xsl:choose>
         <xsl:when test="
               @atLeast,
               @atMost">
            <xsl:value-of select="concat(@atLeast, '-', @atMost, ' ', @unit)"/>
         </xsl:when>
         <xsl:when test="@quantity">
            <xsl:value-of select="concat(@quantity, ' ', @unit)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="."/>
            <xsl:text> cm </xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="t:placeName">
      <a target="_blank" href="{@ref}">
         <xsl:value-of select="."/>
      </a>
   </xsl:template>

   <xsl:template match="t:hi[@rend = 'bold']">
      <b>
         <xsl:value-of select="."/>
      </b>
   </xsl:template>

   <xsl:template match="t:rs | t:objectType | t:material | t:term">
      <a target="_blank" href="{@ref}">
         <xsl:value-of select="."/>
      </a>
   </xsl:template>
   <xsl:template name="ilabibl">
      <xsl:choose>
         <xsl:when test="t:ptr">
            <a href="{t:ptr/@target}">
               <xsl:variable select="document(t:ptr/@target)" name="cite"/>
               <xsl:choose>
                  <xsl:when test="$cite//t:author">
                     <xsl:value-of select="$cite//t:author[1]/t:surname"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="$cite//t:editor[1]/t:surname"/>
                  </xsl:otherwise>
               </xsl:choose>
               <xsl:text> </xsl:text>
               <xsl:value-of select="$cite//t:date"/>
            </a>
            <xsl:if test="t:citedRange">
               <xsl:text>, </xsl:text>
               <xsl:value-of select="t:citedRange"/>
            </xsl:if>
            <xsl:choose>
               <xsl:when test="position() = last()">
                  <xsl:text>. </xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>; </xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:choose>
               <xsl:when test="position() = last()">
                  <xsl:text>. </xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>; </xsl:text>
               </xsl:otherwise>
            </xsl:choose>

         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
