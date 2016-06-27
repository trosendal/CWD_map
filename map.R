library(leaflet)
library(jsonlite)
library(htmlwidgets)
geojson <- readLines("counties.geojson", warn = FALSE)
temp <- paste(geojson, collapse = "\n")
geojson <- fromJSON(temp, simplifyVector = FALSE)
NUTS <- data.frame(NUTS3 = c("SE110", "SE121", "SE122", "SE123",
                             "SE124", "SE125", "SE211", "SE212",
                             "SE213", "SE214", "SE221", "SE224",
                             "SE231", "SE232", "SE311", "SE312",
                             "SE313", "SE321", "SE322", "SE331",
                             "SE332"),
                   Swedish_name = c("Stockholms län", "Uppsala län",
                                    "Södermanlands län",
                                    "Östergötlands län", "Örebro län",
                                    "Västmanlands län",
                                    "Jönköpings län",
                                    "Kronobergs län", "Kalmar län",
                                    "Gotlands län", "Blekinge län",
                                    "Skåne län", "Hallands län",
                                    "Västra Götalands län",
                                    "Värmlands län", "Dalarnas län",
                                    "Gävleborgs län",
                                    "Västernorrlands län",
                                    "Jämtlands län",
                                    "Västerbottens län",
                                    "Norrbottens län"),
                   English_name = c("Stockholm County",
                                    "Uppsala County",
                                    "Södermanland County",
                                    "Östergötland County",
                                    "Örebro County",
                                    "Västmanland County",
                                    "Jönköping County",
                                    "Kronoberg County",
                                    "Kalmar County", "Gotland County",
                                    "Blekinge County", "Skåne County",
                                    "Hallands County",
                                    "Västra Götaland County",
                                    "Värmland County",
                                    "Dalarna County",
                                    "Gävleborg County",
                                    "Västernorrland County",
                                    "Jämtland County",
                                    "Västerbotten County",
                                    "Norrbotten County"),
                   stringsAsFactors = FALSE)
##Add data and colours to this dataframe
NUTS$result <- c(1, 2, 4, 1, 0,
                 4, 4, 3, 4, 0,
                 1, 4, 2, 0, 3,
                 4, 4, 2, 0, 0,
                 1)
##And potentially some points where cases are found
lat <- c(59.7039353,60, 59.5, 59.2)
lng <- c(17.7219536,18, 19, 18.5)
##Add the colour for each result value (Done manually to allow complete flexibility)
cols2016 <- rev(c("#D22630", "#DD5431", "#E98132", "#F4AF32", "#FFDC33"))
NUTS$colour <- NA
NUTS$colour[NUTS$result == 0] <- "#FFFFFF" ##cols2016[1]
NUTS$colour[NUTS$result == 1] <- cols2016[2]
NUTS$colour[NUTS$result == 2] <- cols2016[3]
NUTS$colour[NUTS$result == 3] <- cols2016[4]
NUTS$colour[NUTS$result == 4] <- cols2016[5]
## Add the result to the geojson (Not necessary)
geojson$features <- lapply(geojson$features, function(feat){
    feat$properties$result <- NUTS$result[match(feat$properties$NUTS_ID, NUTS$NUTS3)]
    feat
})
## Keep all counties for an outline
geojson_outline <- geojson
## Style the map
geojson_outline$style = list(
    weight = 2,
    color = "#FFFFFF",
    opacity = 0.8,
    fillOpacity = 0)
## Drop the counties without data
geojson$features <- lapply(geojson$features, function(feat){
    if(feat$properties$NUTS_ID %in% NUTS$NUTS3[NUTS$result==0]) {
        return(NULL)
    } else {
        return(feat)
    }
})
## Style the map
geojson$style = list(
    weight = 2,
    color = "#FFFFFF",
    opacity = 0.8,
    fillOpacity = 0.6
)
## Add the colour to the geojson
geojson$features <- lapply(geojson$features, function(feat) {
  feat$properties$style <- list(
    fillColor = NUTS$colour[match(feat$properties$NUTS_ID, NUTS$NUTS3)]
  )
  feat
})
## Plot the map
map <- leaflet(width = "500px", height = "800px")
map <- addGeoJSON(map, geojson)
map <- addGeoJSON(map, geojson_outline)
##Add some points
map <- addCircleMarkers(map,
                        opacity = 1,
                        radius = 1.5,
                        lat = lat,
                        lng = lng,
                        fill = TRUE,
                        popup = c("foo", "bar", "sds", "sds"))
map <- addTiles(map)
map <- fitBounds(map, 10.8, 55.2, 24.2, 69.2)
map <- addLegend(map,
                 "bottomright",
                 colors = cols2016,
                 labels = c(0,1,2,3,4),
                 title = "Number of Cases<br>of XXXX per County",
                 opacity = 1)
saveWidget(map, "map.html")
