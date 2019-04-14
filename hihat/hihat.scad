// Settings
$fn=60;
Radius = 200; // Distance from the center of the hole to the edge
HoleDiameter = 10;
HoleEnforcementThickness=HoleDiameter;
Thickness=10;
BaseAngle=110; // Works for 0 to ~250 degrees


// Calculated values
holeCenterY = HoleEnforcementThickness + HoleDiameter/2;
holeCenterX = holeCenterY / tan(BaseAngle/2);
basicSliceRadius = Radius+holeCenterX+HoleDiameter/2;

// NOTE: Needs openscad 2016.xx+ (for the angle parameter to work)
// r -> radius of the pie
// h -> Thickness of the pie
// a -> angle of the slice
module pie_slice(r,h,a) {
  translate([0,0,h/2])
  rotate_extrude(convexity = 10, angle=a)
  translate([0,-h/2,0]) square(size=[r,h]);
}

module mountRing() {
  translate([holeCenterX, holeCenterY, Thickness/2])
  cylinder(d=HoleDiameter+2*HoleEnforcementThickness, h=Thickness, center=true);
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
    mountRing();
  }
}

difference() {
  base();
  // Base hole
  translate([holeCenterX, holeCenterY, Thickness/2])
  cylinder(d=HoleDiameter, h=Thickness, center=true);

  // Sensor pocket
  difference() {
    translate([holeCenterX, holeCenterY, Thickness/2])
    pie_slice(r=basicSliceRadius-holeCenterX, h=Thickness/2, a=BaseAngle);
    mountRing();
  }
}

