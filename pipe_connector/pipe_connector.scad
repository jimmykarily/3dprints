// Connector height in mm
ConnectorHeight=140;

// Connector length in mm
ConnectorLength=140;

// The pipe diameter in mm
PipeDiameter=22;

// The extra material around the pipe.
// Measure this on one side.
ThicknessAroundPipe = 10;

// Screw offset in mm
// This is the part near the edge where the screws go
ScrewOffset = 20;

//// Calculated
// How much in 'y' to move to get a square cut
ConnectorWidth = PipeDiameter + ThicknessAroundPipe * 2;
CutHeight = (ConnectorWidth * ConnectorHeight/2) / ConnectorLength;
TriangleHeightBeforeCuts = ConnectorHeight + 2*CutHeight;
TriangleLengthBeforeCuts = ConnectorLength + CutHeight;

module Connector() {
  difference() {
    // Basic triangle
    linear_extrude(height = ConnectorWidth, convexity = 10, twist = 0)
    polygon(points=[[0,0], [0, TriangleHeightBeforeCuts], [TriangleLengthBeforeCuts, TriangleHeightBeforeCuts/2]]);

    // Cut the edges so we get a square face (plus the screw offset)
    y = ((ConnectorWidth+ScrewOffset) * TriangleHeightBeforeCuts/2) / TriangleLengthBeforeCuts;
    cube([TriangleLengthBeforeCuts, y, ConnectorWidth]);

    translate([0, TriangleHeightBeforeCuts-y, 0])
    cube([TriangleLengthBeforeCuts, ConnectorWidth, ConnectorWidth]);

    // Cut also the top of the triangle (far "x" side)
    x = (TriangleLengthBeforeCuts * (TriangleHeightBeforeCuts - ConnectorWidth) / TriangleHeightBeforeCuts);
    translate([x, TriangleHeightBeforeCuts/2 - ConnectorWidth / 2, 0])
    cube([TriangleLengthBeforeCuts, ConnectorWidth, ConnectorWidth]);

    // Drill a hole for the first pipe
    Pipe1();
    Pipe2();
  }
}

module Pipe1() {
  translate([PipeDiameter/2 + ScrewOffset + ThicknessAroundPipe,0,PipeDiameter/2 + ThicknessAroundPipe]) {
    rotate([-90,0,0])
    cylinder(h=TriangleHeightBeforeCuts, r=PipeDiameter/2);
  }
}

module Pipe2() {
  translate([PipeDiameter/2 + ScrewOffset + ThicknessAroundPipe, TriangleHeightBeforeCuts/2,PipeDiameter/2 + ThicknessAroundPipe]) {
    rotate([0,90,0])
    cylinder(h=TriangleHeightBeforeCuts, r=PipeDiameter/2);
  }
}

Connector();
//Pipe1(); // Show the pipe #1
//Pipe2(); // Show the pipe #2
