<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dat="http://oving.hvl.no/databaser"
                version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

<!--************************************************************
    *   Main Template   (HTML m/HEAD)                        *
    ************************************************************-->
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>Oppskrifter</title>
                <link rel="stylesheet" href="css/oppskrifter.css"/>
            </head>
            <body>
                <xsl:apply-templates select="//dat:oppskrifter"/>
            </body>
        </html>
    </xsl:template>

<!--************************************************************
    *   BODY TEMPLATE                                          *
    ************************************************************-->
    <xsl:template match="dat:oppskrifter">
        <div class="header">
            <h1>🍳 Oppskrifter 🍽️</h1>
        </div>

        <!-- Oversikt -->
        <div class="oppskrifter-oversikt">
            <h2>📋 Oppskrifter Oversikt</h2>
            <ul class="oppskrifter-liste">
                <xsl:for-each select="dat:oppskrift">
                    <li>
                        <a href="#oppskrift-{position()}">
                            <xsl:value-of select="dat:navn"/>
                        </a>
                    </li>
                </xsl:for-each>
            </ul>
        </div>

        <!-- Detaljbeskrivelser -->
        <xsl:for-each select="dat:oppskrift">
            <div class="oppskrift-detalj" id="oppskrift-{position()}">
                <h3><xsl:value-of select="dat:navn"/></h3>

                <div class="oppskrift-info">
                    <div class="info-item">
                        <div class="info-label">Vanskelighetsgrad</div>
                        <div class="info-value"><xsl:value-of select="dat:vanskelighetsgrad"/></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Tidsbruk</div>
                        <div class="info-value"><xsl:value-of select="dat:tid"/></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Porsjoner</div>
                        <div class="info-value"><xsl:value-of select="dat:porsjoner"/></div>
                    </div>
                </div>

                <h4>📝 Ingredienser</h4>
                <ul class="ingredienser-liste">
                    <xsl:for-each select="dat:ingredienser/dat:ingrediens">
                        <li>
                            <span class="ingrediens-mengde">
                                <xsl:value-of select="@mengde"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="@enhet"/>
                            </span>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="@navn"/>
                        </li>
                    </xsl:for-each>
                </ul>

                <h4>👨‍🍳 Fremgangsmåte</h4>
                <ol class="metode-liste">
                    <xsl:for-each select="dat:metode/dat:steg">
                        <li><xsl:value-of select="."/></li>
                    </xsl:for-each>
                </ol>

                <xsl:if test="dat:kommentar and normalize-space(dat:kommentar)">
                    <h4>💡 Kommentar</h4>
                    <div class="kommentar">
                        <xsl:value-of select="kommentar"/>
                    </div>
                </xsl:if>

                <h4>🥗 Næringsinnhold (per porsjon)</h4>
                <div class="innhold">
                    <div class="innhold-item">
                        <div class="innhold-label">Kalorier</div>
                        <div class="innhold-verdi"><xsl:value-of select="dat:innhold/@kalorier"/></div>
                    </div>
                    <div class="innhold-item">
                        <div class="innhold-label">Fett (g)</div>
                        <div class="innhold-verdi"><xsl:value-of select="dat:innhold/@fett"/></div>
                    </div>
                    <div class="innhold-item">
                        <div class="innhold-label">Karbohydrater (g)</div>
                        <div class="innhold-verdi"><xsl:value-of select="dat:innhold/@karbohydrater"/></div>
                    </div>
                    <div class="innhold-item">
                        <div class="innhold-label">Proteiner (g)</div>
                        <div class="innhold-verdi"><xsl:value-of select="dat:innhold/@proteiner"/></div>
                    </div>
                </div>

                <!-- Her benyttes Javascript 'window.scrollTo(0,0)' for å gå til toppen  -->
                <div class="tilbake-link">
                    <a href="#top" onclick="window.scrollTo(0, 0); return false;">⬆️ Tilbake til oversikt</a>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>

