// https://github.com/JohK/nutsnbolts
include <../nutsnbolts/cyl_head_bolt.scad>;

// Settings
$fn=60;
Radius = 180; // Distance from the center of the hole to the edge
HoleDiameter = 6;

// The outer diameter of the ring magnet that you are going to glue
// at the bottom side (for open/closed reed switch)
RingMagnetOuterDiameter=7;
RingMagnetHeight=1;

HoleEnforcementThickness=HoleDiameter*1.5;
Thickness=10;
BaseAngle=90; // Works for 0 to ~250 degrees
MembraneThickness=1;
MembraneGap=3;
SensorCableHoleDiameter=5;
MountHeight=30;
MountHoleDiameter=4; // External diameter of the threaded insert for the mount screw

// TODO:
// - Create the mount

// Calculated values
holeCenterY = HoleEnforcementThickness + HoleDiameter/2;
holeCenterX = holeCenterY / tan(BaseAngle/2);
basicSliceRadius = Radius+holeCenterX+HoleDiameter/2;

// NOTE: Needs openscad 2016.xx+ (for the angle parameter to work)
// r -> radius of the pie
// h -> Thickness of the pie
// a -> angle of the slice
module pie_slice(r,h,a) {
  translate([0,0,h/2]) {
    rotate_extrude(convexity = 10, angle=a)
    translate([0,-h/2,0]) square(size=[r,h]);
  }
}

module mountHole() {
  translate([holeCenterX, holeCenterY, MountHeight/2])
  cylinder(d=HoleDiameter, h=MountHeight, center=true);
}

module mountRing() {
  difference() {
    translate([holeCenterX, holeCenterY,MountHeight/2])
    cylinder(d=HoleDiameter+2*HoleEnforcementThickness, h=MountHeight, center=true);

    mountHole();
  }
}

// The sensor base.
module base() {
  union() {
    difference() {
      pie_slice(r=basicSliceRadius, h=Thickness, a=BaseAngle);

      // Remove the non-needed tip of the pie slice
      translate([holeCenterX, holeCenterY,0])
      rotate([0,0,BaseAngle+90])
      pie_slice(r=Radius, h=Thickness, a=180-BaseAngle);
    }
  }
}

module ringMagnetSocket() {
  translate([holeCenterX, holeCenterY, RingMagnetHeight/2])
  cylinder(d=RingMagnetOuterDiameter, h=RingMagnetHeight, center=true);
}

difference() {
  base();

  // Sensor pocket (deep one, without the margin)
  membraneMarginY = HoleEnforcementThickness + HoleDiameter/2 + MembraneThickness * 2;
  membraneMarginX = membraneMarginY / tan(BaseAngle/2);
  translate([membraneMarginX, membraneMarginY, Thickness - MembraneThickness - MembraneGap])
  difference() {
    pie_slice(r=basicSliceRadius, h=Thickness, a=BaseAngle);
    cylinder(d=HoleDiameter+2*HoleEnforcementThickness, h=MountHeight, center=true);
  }


  // Sensor pocket (shallow one, with the margin)
  translate([holeCenterX, holeCenterY, Thickness - MembraneThickness])
  pie_slice(r=basicSliceRadius-holeCenterX, h=Thickness/2, a=BaseAngle);

  // Sensor cable hole
  sensorCableHoleCenterX = holeCenterX + HoleEnforcementThickness + SensorCableHoleDiameter + MembraneThickness*3;
  sensorCableHoleCenterY = sensorCableHoleCenterX * tan(BaseAngle/2);
  translate([sensorCableHoleCenterX, sensorCableHoleCenterY, Thickness/2])
  cylinder(d=SensorCableHoleDiameter, h=Thickness, center=true);

  mountHole();
  ringMagnetSocket();
}


mountHoleZ=3*MountHeight/4;
// The mount
difference() {
  mountRing();
  translate([holeCenterX,0,mountHoleZ])
  rotate([-90,0,0])
  cylinder(d=MountHoleDiameter, h=(HoleDiameter+2*HoleEnforcementThickness)/2);

  translate([holeCenterX, holeCenterY-HoleDiameter/2-(HoleEnforcementThickness-MountHoleDiameter)/2, mountHoleZ])
  rotate([-90,-90,0])
  nutcatch_sidecut(str("M",MountHoleDiameter), l=100, clk=0.1, clh=0.1, clsl=0.1);
  ringMagnetSocket();
}


