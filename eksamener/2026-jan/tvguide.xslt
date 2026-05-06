<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output method="html" />

   <xsl:param name="valgtDato" select="'2025-12-09'"/>

   <xsl:template match="/tvguide">
      <html>
         <head>
            <title>TV-guide</title>
         </head>
         <body>
            <h2>TV-programmer</h2>
            <h3>Dato: <xsl:value-of select="$valgtDato"/></h3>
            <table>
               <tr>
                  <th>Kanal</th>
                  <th>Tid</th>
                  <th>Tittel</th>
                  <th>Kategori</th>
               </tr>
               <xsl:for-each select="program[@dato=$valgtDato]">
                  <tr>
                     <td><xsl:value-of select="@kanal"/></td>
                     <td><xsl:value-of select="@tid"/></td>
                     <td><xsl:value-of select="tittel"/></td>
                     <td><xsl:value-of select="kategori"/></td>
                  </tr>
               </xsl:for-each>
            </table>
         </body>
      </html>
   </xsl:template>
</xsl:stylesheet>
