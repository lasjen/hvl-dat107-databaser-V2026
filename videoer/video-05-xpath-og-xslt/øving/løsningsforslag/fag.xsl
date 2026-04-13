<?xml version = "1.0" encoding = "UTF-8"?>
<xsl:stylesheet version = "1.0"
                xmlns:xsl = "http://www.w3.org/1999/XSL/Transform">
   <xsl:output method="html" />

   <xsl:template match = "/hvl/emner">
      <html>
         <body>
            <h1>HVL Fagoversikt: Informasjonsteknologi</h1>
            <h2>1. og 2.studieår</h2>
            <p>Følgende oversikt viser emner for år 1. og 2.studieår ved Informasjonsteknologi studiet ved HVL.</p>
            <table border = "1" width="600">
               <tr bgcolor = "#9acd32">
                  <th>Kode</th>
                  <th>Emne</th>
                  <th>Studiepoeng</th>
               </tr>
               <tr>
                  <td colspan="4" align="center"><b>Semester 1</b></td>
               </tr>
               <xsl:for-each select = "emne[semester=1]">
                  <tr>
                     <td><xsl:value-of select = "kode"/></td>
                     <td><xsl:value-of select = "navn"/></td>
                     <td align="center"><xsl:value-of select = "poeng" /></td>
                  </tr>
               </xsl:for-each>

               <tr>
                  <td colspan="4" align="center"><b>Semester 2</b></td>
               </tr>

               <xsl:for-each select = "emne[semester=2]">

                  <tr>
                     <td><xsl:value-of select = "kode"/></td>
                     <td><xsl:value-of select = "navn"/></td>
                     <td align="center"><xsl:value-of select = "poeng" /></td>
                  </tr>
               </xsl:for-each>

               <tr>
                  <td colspan="4" align="center"><b>Semester 3</b></td>
               </tr>

               <xsl:for-each select = "emne[semester=3]">

                  <tr>
                     <td><xsl:value-of select = "kode"/></td>
                     <td><xsl:value-of select = "navn"/></td>
                     <td align="center"><xsl:value-of select = "poeng" /></td>
                  </tr>
               </xsl:for-each>

               <tr>
                  <td colspan="4" align="center"><b>Semester 4</b></td>
               </tr>

               <xsl:for-each select = "emne[semester=4]">

                  <tr>
                     <td><xsl:value-of select = "kode"/></td>
                     <td><xsl:value-of select = "navn"/></td>
                     <td align="center"><xsl:value-of select = "poeng" /></td>
                  </tr>
               </xsl:for-each>
            </table>

            <h2>3.studieår</h2>
            <p>Følgende oversikt viser emner for 3.studieår ved Informasjonsteknologi studiet ved HVL.</p>
            <p>Hvilke fagkombinasjoner avhenger av spesialisering og valgte valgfag.</p>

            <table border = "1"  width="600">
               <tr bgcolor = "#9acd32">
                  <th>Kode</th>
                  <th>Emne</th>
                  <th>Studiepoeng</th>
                  <th>semester</th>
               </tr>
               <xsl:for-each select = "emne[semester>4]">
                  <xsl:sort data-type="number" select="semester"/>
                  <tr>
                     <td><xsl:value-of select = "kode"/></td>
                     <td><xsl:value-of select = "navn"/></td>
                     <td align="center"><xsl:value-of select = "poeng" /></td>
                     <td align="center"><xsl:value-of select = "semester" /></td>
                  </tr>
               </xsl:for-each>
            </table>
         </body>
      </html>
   </xsl:template>
</xsl:stylesheet>
