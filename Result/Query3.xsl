<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">  
       <xsl:template match="/">
            <html>
                <body>
                    <h2>Temporal Slicing - Department History During From 1994-05-01 To 1996-05-06.</h2>
                    <table border="1">
                        <tr bgcolor="#9acd32">
                            <th style="text-align:center">Dept No</th>
                            <th style="text-align:center">Dept Name</th>
                            <th style="text-align:center">Manager No</th>
                            <th style="text-align:center">Start Date</th>
                            <th style="text-align:center">End Date</th>
                        </tr>
                        <xsl:for-each select="slicing/department/mgrno">
                            <tr>
                                <td><xsl:value-of select="../deptno"/></td>
                                <td><xsl:value-of select="../deptname"/></td>
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