<?xml version = "1.0" encoding = "UTF-8"?>
<xsl:stylesheet version = "1.0"
                xmlns:xsl = "http://www.w3.org/1999/XSL/Transform">
   <xsl:output method="html" />
   <xsl:template match = "/hvl/studenter">
      <html>
         <body>
            <h2>Studenter</h2>
            <table border = "0" width="600">
               <tr bgcolor = "lightblue">
                  <th>StudentNr</th>
                  <th>Navn</th>
                  <th>Antall fag</th>
                  <th>Snitt</th>
                  <th>Karakter</th>
               </tr>

               <xsl:for-each select = "student">
                  <!-- <xsl:sort select="sum(emner/emne/poeng) div count(emner/emne)" order="descending" /> -->

                  <xsl:variable name="altColor">
                     <xsl:choose>
                        <xsl:when test="sum(emner/emne/poeng) div count(emner/emne) > 90">lightgreen</xsl:when>
                        <xsl:when test="sum(emner/emne/poeng) div count(emner/emne) &lt;= 55">orange</xsl:when>
                        <xsl:otherwise>white</xsl:otherwise>
                     </xsl:choose>
                  </xsl:variable>

                  <tr bgcolor="{$altColor}">
                     <td align="center"><xsl:value-of select = "@studentnr"/></td>
                     <td>
                        <xsl:value-of select = "fornavn"/><xsl:text> </xsl:text>
                        <xsl:value-of select = "etternavn"/>
                     </td>
                     <td align="center">
                        <xsl:value-of select="count(emner/emne)" />
                     </td>
                     <td align="center"><xsl:value-of select="round(sum(emner/emne/poeng) div count(emner/emne))" /></td>
                     <td align="center">
                        <xsl:choose>
                           <xsl:when test = "sum(emner/emne/poeng) div count(emner/emne) > 90">A</xsl:when>
                           <xsl:when test = "sum(emner/emne/poeng) div count(emner/emne) > 85">B</xsl:when>
                           <xsl:when test = "sum(emner/emne/poeng) div count(emner/emne) > 80">C</xsl:when>
                           <xsl:when test = "sum(emner/emne/poeng) div count(emner/emne) > 70">D</xsl:when>
                           <xsl:when test = "sum(emner/emne/poeng) div count(emner/emne) > 55">E</xsl:when>
                           <xsl:otherwise>F</xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
               </xsl:for-each>
            </table>
         </body>
      </html>
   </xsl:template>
</xsl:stylesheet>