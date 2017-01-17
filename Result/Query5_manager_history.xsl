<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">  
       <xsl:template match="/">
            <html>
                <body>
                    <h2>Temporal Join - Manager History of Each Employee.</h2>
                    <table border="1">
                        <tr bgcolor="#9acd32">
                            <th style="text-align:center">Employee No</th>
                            <th style="text-align:center">First Name</th>
                            <th style="text-align:center">Last Name</th>
                            <th style="text-align:center">Manager No</th>
                            <th style="text-align:center">Start Date</th>
                            <th style="text-align:center">End Date</th>
                        </tr>
                        <xsl:for-each select="temporalJoin/employee/managers/mgrno">
                            <tr>
                                <td><xsl:value-of select="../../empno"/></td>
                                <td><xsl:value-of select="../../firstname"/></td>
                                <td><xsl:value-of select="../../lastname"/></td>
                                <td><xsl:value-of select="text()"/></td>
                                <td><xsl:value-of select="@tstart"/></td>
                                <td><xsl:value-of select="@tend"/></td>
                                
                            </tr>
                        </xsl:for-each>
                    </table>
                </body>
            </html>
        </xsl:template>
    </xsl:stylesheet>