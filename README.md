# Mapping in Leaflet - Data in R

The goal is to produce a leaflet map that can display colour
intensities in polygons and a layer of points. The data to inform the
location of points and the colour of polygons needs to be injected
from R.

## Examples of maps that have the features that we need:

Polygon select and display information
http://leafletjs.com/examples/choropleth-example.html

Add and drop multiple layers
http://leafletjs.com/examples/layers-control.html

## Design

* Use spatial data in R add covariate information and write to .geojson
* Embed geojson in page to make "standalone"
* OK to link to websourced css and js
* All map design is done in javascript

### Status

#### Two working maps:

1. map.html

This map solves the select polygons with mouseover and display
information from the geojson on the map. It also displays some points
from another geojson. However, everything in this map is on the same layer.


2. test/map.html

This map solves multiple layers with different legends that are added
dynamically when different layers are selected. But Does not have the
feature to display information on from the geojson on mouseover.

I have not been able to figure out how to implement the mouseover
event query and display feature in the map with multiple layers.

#### TODO

* Combine the features of the two maps into one map that has multiple
  selectable layers (overlay not baselayers) with different legends and
  the the feature to display data from the geojson on mouseover.

* In a final implementation I would drop the click to zoom feature in
  map.html because it is not intuitive for the user.  

