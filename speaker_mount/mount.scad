// Settings
// All values are in millimeters
$fn=100;

mountHeight=50;
mountWidth=20;
mountThickness=4;

wallScrewDiameter=5;

mountHoleExtrusion=5;
mountHoleDiameter=5;
mountHoleHeight=mountHeight*0.5;

module mountHole(holeDiameter, thickness) {
  difference() {
    union() {
      translate([mountWidth/2,(mountHeight-mountHoleHeight)/2,mountThickness+mountHoleExtrusion])
      rotate([-90])
      cylinder(h=mountHoleHeight,d=holeDiameter+thickness*2, center=false);

      translate([mountWidth/2-(holeDiameter+thickness*2)/2,(mountHeight-mountHoleHeight)/2,mountThickness])
      cube(size = [holeDiameter+thickness*2,mountHoleHeight,mountHoleExtrusion], center=false);
    }

    translate([mountWidth/2,(mountHeight-mountHoleHeight)/2,mountThickness+mountHoleExtrusion])
    rotate([-90])
    cylinder(h=mountHoleHeight,d=holeDiameter, center=false);
  }
}

union() {
  difference() {
    cube(size = [mountWidth,mountHeight,mountThickness], center=false);
    // Wall hole 1
    translate([mountWidth/2,(mountHeight-mountHoleHeight)/4,0])
    cylinder(h=mountThickness,d=wallScrewDiameter);
    // Wall hole 2
    translate([mountWidth/2,mountHeight-(mountHeight-mountHoleHeight)/4,0])
    cylinder(h=mountThickness,d=wallScrewDiameter);
  }

  mountHole(holeDiameter=mountHoleDiameter, thickness=3);
}
