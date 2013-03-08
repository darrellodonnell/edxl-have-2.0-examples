import libxml2
import libxslt
import sys




rawHAVE = libxml2.parseFile("HAVE.xml")
xslHTML = libxml2.parseFile("BasicHAVE-to-HTML.xsl")
xslKML  = libxml2.parseFile("BasicHAVE-to-KML.xsl")

styleHTML = libxslt.parseStylesheetDoc(xslHTML)
styleKML = libxslt.parseStylesheetDoc(xslKML)

resultHTML = styleHTML.applyStylesheet(rawHAVE, None)
styleHTML.saveResultToFilename("HAVE.html", resultHTML, 0)
styleHTML.freeStylesheet()
resultHTML.freeDoc()


resultKML = styleKML.applyStylesheet(rawHAVE, None)
styleKML.saveResultToFilename("HAVE.kml", resultKML, 0)
styleKML.freeStylesheet()
resultKML.freeDoc()

rawHAVE.freeDoc()












