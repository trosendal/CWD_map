library(sp)
library(svar)
library(rgdal)
data(NUTS_20M) 
map_data <- NUTS_20M[NUTS_20M@data$STAT_LEVL_ == 3,]
map_data <- spTransform(map_data, "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
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
NUTS$result <- c(0, 1, 0, 0, 0,
                 0, 0, 2, 0, 2,
                 0, 3, 0, 1, 0,
                 0, 0, 4, 0, 4,
                 0)
map_data@data$Swedish_name <- NUTS$Swedish_name[match(NUTS$NUTS3, map_data$NUTS_ID)]
map_data@data$English_name <- NUTS$English_name[match(NUTS$NUTS3, map_data$NUTS_ID)]
map_data@data$result <- NUTS$result[match(NUTS$NUTS3, map_data$NUTS_ID)]
unlink("data.geojson")
writeOGR(map_data, "data.geojson", layer = "main", driver = "GeoJSON", check_exists = FALSE)
test <- readLines("data.geojson", warn = FALSE)
test <- paste(test, collapse = "\n")
writeLines(c("var CountyData = ", test), "data.js")
