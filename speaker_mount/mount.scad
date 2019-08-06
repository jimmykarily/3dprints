// Settings
// All values are in millimeters
$fn=100;

mountHeight=50;
mountWidth=20;
mountThickness=4;

wallScrewDiameter=5;

mountHoleExtrusion=6;
mountHoleDiameter=5;
mountHoleHeight=mountHeight*0.5;

wallThickness=3;

module wallMountHole(holeDiameter, thickness) {
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

module wallMountBase() {
  difference() {
    cube(size = [mountWidth,mountHeight,mountThickness], center=false);
    // Wall hole 1
    translate([mountWidth/2,(mountHeight-mountHoleHeight)/4,0])
    cylinder(h=mountThickness,d=wallScrewDiameter);
    // Wall hole 2
    translate([mountWidth/2,mountHeight-(mountHeight-mountHoleHeight)/4,0])
    cylinder(h=mountThickness,d=wallScrewDiameter);
  }
}

module wallMount() {
  union() {
    wallMountBase();
    wallMountHole(holeDiameter=mountHoleDiameter, thickness=wallThickness);
  }
}

module speakerMount(holeDiameterRatio) {
  union() {
    translate([(mountWidth-mountHoleDiameter-wallThickness*2)/2,(mountHeight-mountHoleHeight)/2-mountThickness,(mountHoleDiameter+wallThickness*2)/2+mountThickness])
    cube(size = [mountHoleDiameter+wallThickness*2,mountThickness,(mountHoleDiameter+wallThickness*2)/2+mountThickness], center=false);

    translate([mountWidth/2,(mountHeight-mountHoleHeight)/2-mountThickness,mountThickness+mountHoleExtrusion])
    rotate([-90])
    cylinder(h=mountThickness,d=mountHoleDiameter+wallThickness*2, center=false);


    translate([mountWidth/2,(mountHeight-mountHoleHeight)/2,mountThickness+mountHoleExtrusion])
    rotate([-90])
    cylinder(h=mountHoleHeight,d=mountHoleDiameter*holeDiameterRatio, center=false);
  }
}

wallMount();
speakerMount(holeDiameterRatio=0.9);
