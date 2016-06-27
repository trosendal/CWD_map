# Mapping in Leaflet - Data in R

The goal is to produce a leaflet map that can display colour
intensities in polygons and a layer of points. The data to inform the
location of points and the colour of polygons needs to be injected
from R.

## Examples of maps that have the features that we need:

http://palewi.re/posts/2012/03/26/leaflet-recipe-hover-events-features-and-polygons/


http://leafletjs.com/examples/choropleth-example.html


## TODO

* A popup over each polygon that displays a number that is stored in the
.geojson

## Design

It would be nice to have the entire mapping part built in javascript
and just the data is added in some lines of geojson that is written
from R.

Using the leaflet library in R limits the possibility of using the
features that are included in that library where most examples on the
web of leaflet maps are describing how to produce maps by working
directly in javascript. 
