library(sp)
library(rgdal)
map_data <- readOGR("counties.geojson", layer = "OGRGeoJSON")
## Change the data
map_data@data$result <- c(0, 1, 0, 0, 0,
                          0, 0, 2, 0, 2,
                          0, 3, 0, 1, 0,
                          0, 0, 4, 0, 4,
                          0)
temp <- tempfile()
writeOGR(map_data, temp, layer = "main", driver = "GeoJSON", check_exists = FALSE)
temp <- readLines(temp, warn = FALSE)
temp <- paste(temp, collapse = "\n")
writeLines(c("var CountyData = ", temp), "data.js")
