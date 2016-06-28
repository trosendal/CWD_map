# Mapping in Leaflet - Data in R

The goal is to produce a leaflet map that can display colour
intensities in polygons and a layer of points. The data to inform the
location of points and the colour of polygons needs to be injected
from R.

## Examples of maps that have the features that we need:

http://palewi.re/posts/2012/03/26/leaflet-recipe-hover-events-features-and-polygons/


http://leafletjs.com/examples/choropleth-example.html


## Design

The map in directory /map2 is implimented in javascript only reading a
JSON data file. However I need to get data into the JSON file. So far
attempts to write valid JSON from R has failed for some reason. All I
need to do is add a properties 'result' to each feature.

### TODO

Write valid JSON from R
