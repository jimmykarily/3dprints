$fn=60;
Diameter = 220;
HoleDiameter = 10;
Thickness=3;
HoleEnforcementThickness=HoleDiameter*2;


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
      pie_slice(d=Diameter, h=Thickness,  a=90);
      cylinder(d=HoleDiameter+HoleEnforcementThickness, h=Thickness, center=true);
    }
  }
}

translate([0,0,-Thickness])
union() {
  difference() {
    rotate([0,0,-5])
    pie_slice(d=Diameter, h=Thickness, a=100);
    cylinder(d=HoleDiameter+HoleEnforcementThickness, h=Thickness, center=true);
  }
}
