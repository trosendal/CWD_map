library(sp)
library(rgdal)
##
## Polygons on map
##
readpolygons <- function(infile) {
    ## Get the map of counties
    map_data <- readOGR("counties.geojson", layer = "OGRGeoJSON")
    ## Read in the result data
    results <- read.csv2(infile, stringsAsFactors = FALSE)
    ## Merge the results into the spatial object
    map_data@data$result <- results$result[match(results$NUTS_ID, map_data@data$NUTS_ID)]
    ## Write the spatial object as a geojson
    temp <- tempfile()
    writeOGR(map_data, temp, layer = "main", driver = "GeoJSON", check_exists = FALSE)
    temp <- readLines(temp, warn = FALSE)
    temp <- paste(temp, collapse = "\n")
    outfile <- tempfile()
    writeLines(c("<script type='text/javascript'>", "var CountyData = ", temp, "</script>"), outfile)
    return(outfile)
}
##
## Points on the map
##
readpoints <- function(infile){
    df <- read.csv2(infile, stringsAsFactors = FALSE, dec = ".")
    df$date <- as.Date(df$date)
    pts <- SpatialPoints(cbind(df$long, df$lat))
    proj4string(pts) <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
    pts <- SpatialPointsDataFrame(pts, df)
    temp <- tempfile()
    writeOGR(pts, temp, layer = "main", driver = "GeoJSON", check_exists = FALSE)
    temp <- readLines(temp, warn = FALSE)
    temp <- paste(temp, collapse = "\n")
    outfile <- tempfile()
    writeLines(c("<script type='text/javascript'>", "var PointsData = ", temp, "</script>"), outfile)
    return(outfile)
}
##
## Build map
##
buildmap <- function(polygons, points = NULL, outfile) {
    snp1 <- readLines("snippet1.html")
    snp2 <- readLines("snippet2.html")
    snp3 <- readLines("snippet3.html")
    snp4 <- readLines("snippet4.html")
    polygons <- readLines(polygons)
    if(!is.null(points)){
        points <- readLines(points)
        writeLines(c(snp1, polygons, points, snp2, snp3, snp4), outfile)
    }else{
        writeLines(c(snp1, polygons, snp2, snp4), outfile)
    }
}
buildmap(readpolygons("results.csv"), readpoints("points.csv"), "map.html")
##buildmap(polygons = readpolygons("results.csv"), outfile = "map.html")
