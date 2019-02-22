// Connector height in mm
ConnectorHeight=220;

// Connector length in mm
ConnectorLength=180;

// The pipe diameter in mm
PipeDiameter=22;

// The extra material around the pipe.
// Measure this on one side.
ThicknessAroundPipe = 10;

// Screw offset in mm
// This is the part near the edge where the screws go
ScrewOffset = 20;

// Screw diameter in mm
ScrewDiameter = 4;

//// Calculated
ConnectorWidth = PipeDiameter + ThicknessAroundPipe * 2;
RemovedTopHeight = ConnectorWidth * (ConnectorLength - ConnectorWidth - ScrewOffset) / (ConnectorHeight - ConnectorWidth);
TriangleLengthBeforeCuts = ConnectorLength + RemovedTopHeight;

// How much in 'y' to move to get a square cut
CutHeight = ((ConnectorWidth+ScrewOffset) * ConnectorHeight) / (2 * (ConnectorLength + RemovedTopHeight - (ConnectorWidth+ScrewOffset)));
TriangleHeightBeforeCuts = ConnectorHeight + 2*CutHeight;

FirstCutY = CutHeight;
SecondCutY = TriangleHeightBeforeCuts - FirstCutY;

module Connector() {
  difference() {
    // Basic triangle
    linear_extrude(height = ConnectorWidth, convexity = 10, twist = 0)
    polygon(points=[[0,0], [0, TriangleHeightBeforeCuts], [TriangleLengthBeforeCuts, TriangleHeightBeforeCuts/2]]);

    // Cut the edges so we get a square face (plus the screw offset)
    cube([TriangleLengthBeforeCuts, FirstCutY, ConnectorWidth]);

    translate([0, SecondCutY, 0])
    cube([TriangleLengthBeforeCuts, ConnectorHeight, ConnectorWidth]);

    // Cut also the top of the triangle (far "x" side)
    x = ConnectorLength;
    translate([x, TriangleHeightBeforeCuts/2 - ConnectorWidth / 2, 0])
    cube([TriangleLengthBeforeCuts, ConnectorWidth, ConnectorWidth]);

    // Drill holes for the pipes
    Pipe1();
    Pipe2();

    // Drill holes for the screws
    translate([(ScrewOffset+ThicknessAroundPipe)/2, FirstCutY + ConnectorHeight/4,0])
    cylinder(h=ConnectorWidth,r=ScrewDiameter);

    translate([(ScrewOffset+ThicknessAroundPipe)/2, FirstCutY + 3*ConnectorHeight/4,0])
    cylinder(h=ConnectorWidth,r=ScrewDiameter);

    translate([ScrewOffset+ThicknessAroundPipe*2+PipeDiameter, FirstCutY + ConnectorHeight/4,0])
    cylinder(h=ConnectorWidth,r=ScrewDiameter);

    translate([ScrewOffset+ThicknessAroundPipe*2+PipeDiameter, FirstCutY + 3*ConnectorHeight/4,0])
    cylinder(h=ConnectorWidth,r=ScrewDiameter);
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

//translate([0,-CutHeight,0])
Connector();
Pipe1(); // Show the pipe #1
Pipe2(); // Show the pipe #2
