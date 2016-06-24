library(sp)
library(leaflet)
library(jsonlite)
geojson <- readLines("counties.geojson", warn = FALSE)
temp <- paste(geojson, collapse = "\n")
geojson <- fromJSON(temp, simplifyVector = FALSE)
id <- sapply(geojson$features, function(feat) {
  feat$id
})
geojson$style = list(
  weight = 1,
  color = "#555555",
  opacity = 0.1,
  fillOpacity = 0.8
)
geojson$features[[2]]$properties

pal <- rainbow(n = length(id))
## for(i in seq_len(length(geojson$features))){
##   geojson$features[[i]]$properties$style <- list(
##     fillColor = pal[i]
##   )
## }
for(i in seq_len(length(geojson$features))){
  geojson$features[[i]]$properties$style$fillColor <- pal[i]
}



map <- leaflet()
map <- addTiles(map)
map <- addGeoJSON(map, geojson, weight = 0.5, fillOpacity = 0.05)
map <- fitBounds(map, 10.8, 55.2, 24.2, 69.2)
map


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
