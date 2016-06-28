library(sp)
library(rgdal)
## Get the map of counties
map_data <- readOGR("counties.geojson", layer = "OGRGeoJSON")
## Read in the result data
results <- read.csv2("results.csv", stringsAsFactors = FALSE)
## Merge the results into the spatial object
map_data@data$result <- results$result[match(results$NUTS_ID, map_data@data$NUTS_ID)]
## Write the spatial object as a geojson
temp <- tempfile()
writeOGR(map_data, temp, layer = "main", driver = "GeoJSON", check_exists = FALSE)
temp <- readLines(temp, warn = FALSE)
temp <- paste(temp, collapse = "\n")
writeLines(c("var CountyData = ", temp), "data.js")
##
## Points on the map
##
df <- read.csv2("points.csv", stringsAsFactors = FALSE, dec = ".")
df$date <- as.Date(df$date)
pts <- SpatialPoints(cbind(df$long, df$lat))
proj4string(pts) <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
pts <- SpatialPointsDataFrame(pts, df)
temp <- tempfile()
writeOGR(pts, temp, layer = "main", driver = "GeoJSON", check_exists = FALSE)
temp <- readLines(temp, warn = FALSE)
temp <- paste(temp, collapse = "\n")
writeLines(c("var PointsData = ", temp), "points.js")
