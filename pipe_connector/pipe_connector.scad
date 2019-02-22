// Connector height in mm
ConnectorHeight=100;

// Connector length in mm
ConnectorLength=110;

// Connector width in mm
ConnectorWidth=42;

//// Calculated
// How much in 'y' to move to get a square cut
CutHeight = (ConnectorWidth * ConnectorHeight/2) / ConnectorLength;
TriangleHeightBeforeCuts = ConnectorHeight + 2*CutHeight;

module Connector() {
  difference() {
    // Basic triangle
    linear_extrude(height = ConnectorWidth, convexity = 10, twist = 0)
    polygon(points=[[0,0], [0, TriangleHeightBeforeCuts], [ConnectorLength, TriangleHeightBeforeCuts/2]]);

    // Cut the edges so we get a square face
    y = (ConnectorWidth * TriangleHeightBeforeCuts/2) / ConnectorLength;
    //translate([0, -ConnectorWidth/2, 0])
    cube([ConnectorLength, y, ConnectorWidth]);

    translate([0, TriangleHeightBeforeCuts-y, 0])
    cube([ConnectorLength, ConnectorWidth, ConnectorWidth]);

    x = (ConnectorLength * (TriangleHeightBeforeCuts - ConnectorWidth) / TriangleHeightBeforeCuts);
    translate([x, TriangleHeightBeforeCuts/2 - ConnectorWidth / 2, 0])
    cube([ConnectorLength, ConnectorWidth, ConnectorWidth]);
  }
}
Connector();
