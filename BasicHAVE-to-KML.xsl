<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://earth.google.com/kml/2.2" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:have="urn:oasis:names:tc:emergency:edxl:have:2.0"
    xmlns:edxl-ct="urn:oasis:names:tc:emergency:edxl:ct:1.0"
    xmlns:edxl-gsf="urn:oasis:names:tc:emergency:edxl:gsf:1.0"
    xmlns:gml="http://www.opengis.net/gml/3.2"
    exclude-result-prefixes="have edxl-ct edxl-gsf gml"
    version="1.0">
    
    <!--  -->
    
    <xsl:output method="xml" />

    <xsl:template match="/">
        <kml xmlns="http://earth.google.com/kml/2.2">
            <Document>
                <name>CAUSE2-NB-Hospitals</name>
                <description><![CDATA[]]></description>
                <Style id="hospital">
                    <IconStyle>
                        <Icon>
                            <href>https://causeresilience2.s3.amazonaws.com/img/ems.operations.emergencyMedical.hospital.png</href>
                        </Icon>
                    </IconStyle>
                </Style>
                <Style id="hospital.red">
                    <IconStyle>
                        <Icon>
                            <href>https://causeresilience2.s3.amazonaws.com/img/ems.operations.emergencyMedical.hospital.red.png</href>
                        </Icon>
                    </IconStyle>
                </Style>
                <Style id="hospital.green">
                    <IconStyle>
                        <Icon>
                            <href>https://causeresilience2.s3.amazonaws.com/img/ems.operations.emergencyMedical.hospital.green.png</href>
                        </Icon>
                    </IconStyle>
                </Style>
                <Style id="hospital.yellow">
                    <IconStyle>
                        <Icon>
                            <href>https://causeresilience2.s3.amazonaws.com/img/ems.operations.emergencyMedical.hospital.yellow.png</href>
                        </Icon>
                    </IconStyle>
                </Style>
                
                
                <xsl:for-each select="have:HAVE/have:facility">
                    
                    <xsl:call-template name="FacilityBlock"/>
                    <!-- <h2><xsl:value-of select="have:facilityInformation/have:facilityName"/></h2> -->
                    
                </xsl:for-each>
                
                
            </Document>
        </kml>
    </xsl:template>

    <xsl:template name="FacilityBlock">
        <Placemark>
            <name>
                <xsl:value-of select="have:facilityInformation/have:facilityName"/>
            </name>
            <description>
                <xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>
                <!-- Facility Level Details -->
                <xsl:call-template name="ColourCodeFacility"></xsl:call-template>
                <xsl:value-of select="have:facilityInformation/have:facilityName"/>
                <br />
                <!-- ServiceList -->
                <xsl:for-each select="have:serviceList/have:serviceListItem">
                    
                        <xsl:call-template name="ServiceListItemBlock"/>
                    <br />
                </xsl:for-each>
                <xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
            </description>
            <styleUrl><xsl:call-template name="ColourCodeFacilityStyle"></xsl:call-template></styleUrl>
            <Point>
                <xsl:variable name="gmlCoordString">
                    <xsl:value-of select="have:facilityInformation/have:facilityGeoLocation/edxl-ct:EDXLGeoLocation/gml:Point/gml:pos"/>
                </xsl:variable>
                <!-- DEBUG <temp><xsl:value-of select="$gmlCoordString"/></temp> -->
                <coordinates><xsl:value-of select="substring-after($gmlCoordString, ' ')" />
                    <xsl:text>,</xsl:text><xsl:value-of select="substring-before($gmlCoordString, ' ')" /><xsl:text>,</xsl:text></coordinates>
            </Point>
        </Placemark>

    </xsl:template>

    <xsl:template name="ColourCodeFacility">
        <!-- TODO - create colour-code images and then use to generate diff filenames Take COLOUR CODE and get image name -->
        <xsl:variable name="serviceColour">
            <xsl:value-of select="have:facilityColourStatus/have:colourCode/edxl-ct:Value"/>
        </xsl:variable>
        <!-- DEBUG <xsl:value-of select="$serviceColour"/> -->
        <xsl:choose>
            <xsl:when test="$serviceColour != ''">
                <!-- ems.operations.emergencyMedical.hospital.COLOR.png COLOR is actually lowercase-->
                <img height="16" width="16" src="https://causeresilience2.s3.amazonaws.com/img/ems.operations.emergencyMedical.hospital.{$serviceColour}.png"/>
            </xsl:when>
            <xsl:otherwise>
                <img height="16" width="16" src="https://causeresilience2.s3.amazonaws.com/img/ems.operations.emergencyMedical.hospital.png"/>
            </xsl:otherwise>
        </xsl:choose>
        <!--        <img height="16" width="16" src="./img/ems.operations.emergencyMedical.hospital.png"/>
            -->

    </xsl:template>
    <xsl:template name="ColourCodeFacilityStyle">
        <!-- TODO - create colour-code images and then use to generate diff filenames Take COLOUR CODE and get image name -->
        <xsl:variable name="serviceColour">
            <xsl:value-of select="have:facilityColourStatus/have:colourCode/edxl-ct:Value"/>
        </xsl:variable>
        <!-- DEBUG <xsl:value-of select="$serviceColour"/> -->
        <xsl:choose>
            <xsl:when test="$serviceColour != ''">
                <!-- ems.operations.emergencyMedical.hospital.COLOR.png COLOR is actually lowercase-->
                <xsl:text>#hospital.</xsl:text><xsl:value-of select="$serviceColour"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>#hospital</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <!--        <img height="16" width="16" src="./img/ems.operations.emergencyMedical.hospital.png"/>
            -->
        
    </xsl:template>


    <xsl:template name="ServiceListItemBlock">

        <xsl:variable name="serviceColour">
            <xsl:value-of
                select="have:serviceStatus/have:colourStatus/have:colourCodeDefault/edxl-ct:Value"/>
        </xsl:variable>
        <!--      <xsl:value-of select="have:serviceStatus/have:colourStatus/have:colourCodeDefault/edxl-ct:Value" />
        </xsl:variable> 
        -->
        <xsl:choose>
            <xsl:when test="$serviceColour != ''">
                <!-- ems.operations.emergencyMedical.hospital.COLOR.png COLOR is actually lowercase-->
                <img height="16" width="16" src="https://causeresilience2.s3.amazonaws.com/img/{$serviceColour}.png"/>
            </xsl:when>
            <xsl:otherwise><!-- GREEN by default -->
                <img height="16" width="16" src="https://causeresilience2.s3.amazonaws.com/img/green.png"/>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:value-of select="have:serviceName" />
        <!-- <xsl:text> - [</xsl:text><xsl:value-of
            select="translate(have:serviceStatus/have:colourStatus/have:colourCodeDefault/edxl-ct:Value,
            'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
        <xsl:text>]</xsl:text>
-->



    </xsl:template>

    <xsl:template name="GeoLocationBlock">
        <br/>COORDS: <xsl:value-of
            select="have:facilityInformation/have:facilityGeoLocation/edxl-ct:EDXLGeoLocation/gml:Point/gml:pos"
        />
    </xsl:template>


   



</xsl:stylesheet>
