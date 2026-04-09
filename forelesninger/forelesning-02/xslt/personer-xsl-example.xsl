<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Personliste</title>
                <!-- <link rel="stylesheet" type="text/css" href="css/screen.css"/> -->
                <!-- <link rel="stylesheet" href="css/print.css" media="print" /> -->
            </head>
            <body>
                <xsl:apply-templates select="//person"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="//person">

        <h3>Person - <xsl:value-of select="pnr"/></h3>
        <p>Navn: <xsl:value-of select="fornavn"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="etternavn"/> </p>
        Fødselsdato: <xsl:value-of select="fodselsdato"/><br />
    </xsl:template>

</xsl:stylesheet>