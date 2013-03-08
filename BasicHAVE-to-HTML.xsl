<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:have="urn:oasis:names:tc:emergency:edxl:have:2.0" 
    xmlns:edxl-ct="urn:oasis:names:tc:emergency:edxl:ct:1.0"
    xmlns:edxl-gsf="urn:oasis:names:tc:emergency:edxl:gsf:1.0" 
    xmlns:gml="http://www.opengis.net/gml/3.2" 
    version="1.0">
    
    <!-- creates list items for linking a list of hospitals -->
    <xsl:template name="FacilityLI">
        <xsl:variable name="FacilityID"><xsl:value-of select="have:facilityInformation/have:facilityID" /></xsl:variable>
        
        <xsl:if test="price &gt; 10">
        </xsl:if>
        
        <li><xsl:call-template name="ColourCodeFacility"/><a href="#{$FacilityID}">
            <xsl:value-of select="have:facilityInformation/have:facilityName"/></a></li>
    </xsl:template>
    
    <xsl:template name="FacilityBlock">
        <hr />
        <xsl:variable name="FacilityID"><xsl:value-of select="have:facilityInformation/have:facilityID" /></xsl:variable>
        <h2 id="{$FacilityID}"><xsl:value-of select="have:facilityInformation/have:facilityName"/></h2>
        <div>TODO: get Facility Details listed here for facility.</div>
        <div>LOCATION:</div><xsl:call-template name="GeoLocationBlock"/>
        <div>SERVICES:
            <ul>
                <xsl:for-each select="have:serviceList/have:serviceListItem">
                    <li>
                        <xsl:call-template name="ServiceListItemBlock"/>
                    </li>
                </xsl:for-each>
            </ul>
        </div>          
        
    </xsl:template>
    
    <xsl:template name="ColourCodeFacility">
        <!-- TODO - create colour-code images and then use to generate diff filenames Take COLOUR CODE and get image name -->
        <xsl:variable name="serviceColour"><xsl:value-of select="have:facilityColourStatus/have:colourCode/edxl-ct:Value" /></xsl:variable>
        <!-- DEBUG <xsl:value-of select="$serviceColour"/> -->
        <xsl:choose>
            <xsl:when test ="$serviceColour != ''">
                <img height="16" width="16" src="./img/{$serviceColour}.png"/>
            </xsl:when>
            <xsl:otherwise><img height="16" width="16" src="./img/flag_black.png"/>
            </xsl:otherwise>
        </xsl:choose>
        <!--        <img height="16" width="16" src="./img/ems.operations.emergencyMedical.hospital.png"/>
            -->
        
    </xsl:template>
    
    <xsl:template name="ColourCodeService">
        <!-- TODO - create colour-code images and then use to generate diff filenames Take COLOUR CODE and get image name -->
        <xsl:variable name="serviceColour"><xsl:value-of select="have:serviceStatus/have:colourStatus/have:colourCodeDefault/edxl-ct:Value" /></xsl:variable>
        <!-- DEBUG <xsl:value-of select="$serviceColour"/> --> 
        <xsl:choose>
            <xsl:when test ="$serviceColour != ''">
                <img height="16" width="16" src="./img/{$serviceColour}.png"/>
            </xsl:when>
            <xsl:otherwise><img height="16" width="16" src="./img/flag_black.png"/>
            </xsl:otherwise>
        </xsl:choose>
<!--        <img height="16" width="16" src="./img/ems.operations.emergencyMedical.hospital.png"/>
            -->

    </xsl:template>
    <xsl:template name="ServiceListItemBlock"> 
        
        <xsl:variable name="serviceColour"><xsl:value-of select="have:serviceStatus/have:colourStatus/have:colourCodeDefault/edxl-ct:Value" /></xsl:variable>
       <!--      <xsl:value-of select="have:serviceStatus/have:colourStatus/have:colourCodeDefault/edxl-ct:Value" />
        </xsl:variable> 
        -->
        
        <xsl:call-template name="ColourCodeService"/><xsl:value-of select="have:serviceName" /> 
        

        
    </xsl:template>
    
    <xsl:template name="GeoLocationBlock">
        <br />COORDS: <xsl:value-of select="have:facilityInformation/have:facilityGeoLocation/edxl-ct:EDXLGeoLocation/gml:Point/gml:pos"/>
    </xsl:template>
    
    
    <xsl:template match="/">
        <html>
            <head>
                <!-- TODO: add in CSS and basic JS to hop on list. -->
            </head>
            <body>
                
                <h1>Hospital Availability (EDXL-HAVE) Demonstration - Centre for Security Science</h1>
                <div>
                    <ul>
                    <xsl:for-each select="have:HAVE/have:facility">
                        <xsl:call-template name="FacilityLI"/>
                    </xsl:for-each>
                    </ul>
                    <xsl:for-each select="have:HAVE/have:facility">
                        <xsl:call-template name="FacilityBlock"/>
                        <!-- <h2><xsl:value-of select="have:facilityInformation/have:facilityName"/></h2> -->
                        
                    </xsl:for-each>
                    
                </div>
            </body>
        </html>
    </xsl:template>
                    
    
    
</xsl:stylesheet>