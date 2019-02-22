// Connector height in mm
ConnectorHeight=50;

// Connector length in mm
ConnectorLength=40;

// Connector width in mm
ConnectorWidth=10;

module Connector() {
  difference() {
    // Basic triangle
    linear_extrude(height = ConnectorWidth, convexity = 10, twist = 0)
    polygon(points=[[0,0], [0, ConnectorHeight], [ConnectorLength, ConnectorHeight/2]]);

    // Cut the edges so we get a square face
    y = (ConnectorWidth * ConnectorHeight/2) / ConnectorLength;
    //translate([0, -ConnectorWidth/2, 0])
    cube([ConnectorLength, y, ConnectorWidth]);
    translate([0, ConnectorHeight-ConnectorWidth/2, 0])
    cube([ConnectorLength, ConnectorWidth, ConnectorWidth]);
  }
}
Connector();
//cube(ConnectorWidth);
