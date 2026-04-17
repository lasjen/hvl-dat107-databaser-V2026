<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dat="http://oving.hvl.no/databaser"
                version="1.0">

    <xsl:output method="html" encoding="UTF-8" />

<!-- ************************************************************
     *   Main Template      *
     ************************************************************ -->
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>Oppskrifter</title>
            </head>
            <body bgcolor="#f5f5f5">

                <!-- HEADER -->
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td bgcolor="white" cellpadding="20">
                            <h1>Oppskrifter</h1>
                        </td>
                    </tr>
                </table>

                <br/>

                <!-- OPPSKRIFTER OVERSIKT -->
                <table width="100%" border="0" cellpadding="15" cellspacing="0" bgcolor="white">
                    <tr>
                        <td>
                            <h2>Oppskrifter</h2>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="5" cellspacing="5">
                                <xsl:for-each select="//dat:oppskrift">
                                    <tr>
                                        <td bgcolor="#f0f0f0" cellpadding="10">
                                            <a href="#oppskrift-{position()}">
                                                <xsl:value-of select="dat:navn"/>
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </table>
                        </td>
                    </tr>
                </table>

                <br/>

                <!-- OPPSKRIFT DETALJER -->
                <xsl:for-each select="//dat:oppskrift">
                    <table width="100%" border="0" cellpadding="20" cellspacing="0" bgcolor="white">
                        <tr>
                            <td>
                                <h3 id="oppskrift-{position()}">
                                    <xsl:value-of select="dat:navn"/>
                                </h3>

                                <!-- INFO BOX -->
                                <table width="100%" border="0" cellpadding="10" cellspacing="0" bgcolor="#f9f9f9">
                                    <tr>
                                        <td width="33%">
                                            <b>Vanskelighetsgrad</b><br/>
                                            <xsl:value-of select="dat:vanskelighetsgrad"/>
                                        </td>
                                        <td width="33%">
                                            <b>Tid</b><br/>
                                            <xsl:value-of select="dat:tid"/>
                                        </td>
                                        <td width="33%">
                                            <b>Porsjoner</b><br/>
                                            <xsl:value-of select="dat:porsjoner"/>
                                        </td>
                                    </tr>
                                </table>

                                <br/>

                                <!-- INGREDIENSER -->
                                <h4>Ingredienser</h4>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <xsl:for-each select="dat:ingredienser/dat:ingrediens">
                                        <tr>
                                            <td cellpadding="8">
                                                <b>
                                                    <xsl:value-of select="@mengde"/><xsl:text> </xsl:text><xsl:value-of select="@enhet"/>
                                                </b>
                                                <xsl:text> </xsl:text><xsl:value-of select="@navn"/>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </table>

                                <br/>

                                <!-- FREMGANGSMATE -->
                                <h4>Fremgangsmate</h4>
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <xsl:for-each select="dat:metode/dat:steg">
                                        <tr>
                                            <td cellpadding="8">
                                                <b>
                                                    <xsl:value-of select="position"/>.
                                                </b>
                                                <xsl:text> </xsl:text><xsl:value-of select="."/>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </table>

                                <br/>

                                <!-- KOMMENTAR: normalize-space fjerner unødige blanke tegn foran og bak. Så hvis kommentar kun er blanke tegn, så blir uttrykket 'false'. -->
                                <xsl:if test="dat:kommentar and normalize-space(dat:kommentar)">
                                    <table width="100%" border="0" cellpadding="10" cellspacing="0" bgcolor="#fff9e6">
                                        <tr>
                                            <td>
                                                <i>
                                                    <xsl:value-of select="normalize-space(dat:kommentar)"/>
                                                </i>
                                            </td>
                                        </tr>
                                    </table>
                                    <br/>
                                </xsl:if>

                                <!-- NARINGSINNHOLD -->
                                <h4>Naringsinnhold (per porsjon)</h4>
                                <table width="100%" border="0" cellpadding="10" cellspacing="0">
                                    <tr>
                                        <td width="25%" bgcolor="#f9f9f9">
                                            <b>Kalorier</b><br/>
                                            <xsl:value-of select="dat:innhold/@kalorier"/>
                                        </td>
                                        <td width="25%" bgcolor="#f9f9f9">
                                            <b>Fett</b><br/>
                                            <xsl:value-of select="dat:innhold/@fett"/>
                                        </td>
                                        <td width="25%" bgcolor="#f9f9f9">
                                            <b>Karbs</b><br/>
                                            <xsl:value-of select="dat:innhold/@karbohydrater"/>
                                        </td>
                                        <td width="25%" bgcolor="#f9f9f9">
                                            <b>Protein</b><br/>
                                            <xsl:value-of select="dat:innhold/@proteiner"/>
                                        </td>
                                    </tr>
                                </table>

                                <br/>

                                <!-- TILBAKE LINK -->
                                <center>
                                    <a href="#top">Tilbake til toppen</a>
                                </center>
                            </td>
                        </tr>
                    </table>
                    <br/>
                </xsl:for-each>

            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>

