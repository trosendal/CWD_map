library(leaflet)
library(jsonlite)
geojson <- readLines("counties.geojson", warn = FALSE)
temp <- paste(geojson, collapse = "\n")
geojson <- fromJSON(temp, simplifyVector = FALSE)
## Grab the id field from the map data
id <- sapply(geojson$features, function(feat) {
  feat$id
})
## Get the nutsid
nutsid <- sapply(geojson$features, function(feat) {
    feat$properties$NUTS_ID
})
## The results and manual colour series(6-character hex colors)
df <- data.frame(id = id,
                 nutsid = nutsid,
                 result = c(0.1, 0.5, 2.3, 0, 0,
                            0, 0, 0, 4.5, 0,
                            1, 0, 0, 0, 2.1,
                            0, 0, 0, 0, 0,
                            0),
                 color = substr(rainbow(21), 1, 7), stringsAsFactors = FALSE)
## Add the result to the geojson (Not necessary)
geojson$features <- lapply(geojson$features, function(feat){
    feat$properties$result <- df$result[match(feat$id, df$id)]
    feat
})
## Style the map
geojson$style = list(
  weight = 1,
  color = "#FFFFFF",
  opacity = 0.1,
  fillOpacity = 0.8
)
## Add the colour to the geojson
geojson$features <- lapply(geojson$features, function(feat) {
  feat$properties$style <- list(
    fillColor = df$color[match(feat$id, df$id)]
  )
  feat
})
## Plot the map
map <- leaflet()
map <- addGeoJSON(map, geojson, weight = 0.5)
## Add some points
map <- addCircleMarkers(map,
                        opacity = 1,
                        radius = 1,
                        lat = 59.7039353,
                        lng = 17.7219536,
                        fill = TRUE)
map <- addTiles(map)
map <- fitBounds(map, 10.8, 55.2, 24.2, 69.2)
map
