// https://github.com/JohK/nutsnbolts
include <../nutsnbolts/cyl_head_bolt.scad>;

// Settings
$fn=100;
threadPitch=1;
screwDiameter=2; // M5
screwLength=20; // in mm

mountHeight=20; // in mm
mountWidth=10; // in  mm
mountThickness=3; // in  mm

wallScrewDiameter=3; // in mm

mountHoleExtrusion=4; // in mm
mountHoleDiameter=mountThickness;

// Calculated values

module mountScrew() {
  screw(str("M",screwDiameter,"x",screwLength), thread="modeled");
}

module mountHole(holeDiameter, thickness) {
  holeMargin=wallScrewDiameter * 0.1;

  union() {
    translate([mountWidth/2,mountHeight/4+wallScrewDiameter/2+holeMargin,mountThickness+mountHoleExtrusion])
    rotate([-90])
    cylinder(h=mountHeight/2-wallScrewDiameter-holeMargin*2,d=holeDiameter+thickness*2, center=false);

    translate([mountWidth/2-(holeDiameter+thickness*2)/2,mountHeight/4+wallScrewDiameter/2+holeMargin,mountThickness])
    cube(size = [holeDiameter+thickness*2,mountHeight/2-wallScrewDiameter-holeMargin*2,mountHoleExtrusion], center=false);
  }
}

union() {
  difference() {
    cube(size = [mountWidth,mountHeight,mountThickness], center=false);
    translate([mountWidth/2,mountHeight/4,0])
    cylinder(h=mountThickness,d=wallScrewDiameter);
    translate([mountWidth/2,3*mountHeight/4,0])
    cylinder(h=mountThickness,d=wallScrewDiameter);
    //# translate([mountWidth / 2, mountHeight/2, screwDiameter]) rotate([0,0,270]) nutcatch_sidecut(str("M",screwDiameter), l=mountHeight/2, clk=0.1, clh=0.1, clsl=0.1);
  }

  mountHole(holeDiameter=mountThickness, thickness=2);
}
