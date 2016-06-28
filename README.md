# Mapping in Leaflet - Data in R

The goal is to produce a leaflet map that can display colour
intensities in polygons and a layer of points. The data to inform the
location of points and the colour of polygons needs to be injected
from R.

## Examples of maps that have the features that we need:

http://palewi.re/posts/2012/03/26/leaflet-recipe-hover-events-features-and-polygons/

http://leafletjs.com/examples/choropleth-example.html


## Design

* Use spatial data in R add covariate information and write to .geojson
* Read geojson in html
* All map design is done in javascript


### TODO

Add points to map
