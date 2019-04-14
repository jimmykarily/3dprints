$fn=60;
Diameter = 220;
HoleDiameter = 10;
Thickness=3;
HoleEnforcementThickness=HoleDiameter*2;
BaseMargin=10; // The margic of the base for the screws
BaseAngle=90;


// NOTE: Needs openscad 2016.xx+ (for the angle parameter to work)
// d -> diameter of the pie
// h -> Thickness of the pie
// a -> angle of the slice
module pie_slice(d,h,a) {
  rotate_extrude(convexity = 10, angle=a)
  translate([0,-h/2,0]) square(size=[d/2,h]);
}

difference() {
  // Main cylinder
  cylinder(d=Diameter, h=Thickness, center=true);

  union() {
    // Central hole
    cylinder(d=HoleDiameter, h=Thickness, center=true);
    difference() {
      // (+1 to cut all the way and not leave one pixel)
      pie_slice(d=Diameter+1, h=Thickness,  a=BaseAngle);
      cylinder(d=HoleDiameter+HoleEnforcementThickness, h=Thickness, center=true);
    }
  }
}

// The sensor base.
// Let the main cylinder touch the sensor base
// (that's why we don't move it all the way down)
translate([0,0,-Thickness*0.9]) {
  difference() {
    intersection() { // Cut out the margin edges
      union() {
        pie_slice(d=Diameter, h=Thickness, a=BaseAngle);
        // The margins of the base for the screws
        // One side margin
        translate([0,-BaseMargin, -Thickness/2])
        cube([Diameter/2, BaseMargin,Thickness]);

        // Second side margin
        rotate([0,0,BaseAngle])
        translate([0,0, -Thickness/2])
        cube([Diameter/2, BaseMargin,Thickness]);
      }
      cylinder(d=Diameter, h=Thickness, center=true);
    }
    cylinder(d=HoleDiameter+HoleEnforcementThickness, h=Thickness, center=true);
  }
}
