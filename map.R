library(sp)
library(rgdal)
library(leaflet)
geojson <- readLines("counties.geojson", warn = FALSE)
temp <- paste(geojson, collapse = "\n")
geojson <- fromJSON(temp, simplifyVector = FALSE)
# Default styles for all features
geojson$style = list(
  weight = 1,
  color = "#555555",
  opacity = 1,
  fillOpacity = 0.8
)
map <- leaflet()


                                        # Gather GDP estimate from all countries
id <- sapply(geojson$features, function(feat) {
  feat$id
})

## Color by per-capita GDP using quantiles
pal <- rainbow(n = length(id))
# Add a properties$style list to each feature
geojson$features <- lapply(geojson$features, function(feat) {
  feat$properties$style<- list(
    fillColor = pal[4]
  )
  feat
})

# Add the now-styled GeoJSON object to the map
map <- leaflet()
map <- addGeoJSON(map, geojson)
map

library(leaflet)
## Read farm data
farms <- read.csv("day0.csv")
## Create leaflet map
map <- leaflet()
map <- addTiles(map)
map <- addPolygons(map, 

map <- addGeoJSON(map, "counties.geojson")
map
map <- addCircleMarkers(map,
                        lng   = farms$long,
                        lat   = farms$lat,
                        popup = paste("Herd id: ", farms$herd),
                        color = ifelse(farms$status == 0, "#000000", "red"),
                  fill  = TRUE)
