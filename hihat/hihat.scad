$fn=60;
Diameter = 220;
HoleDiameter = 10;
Thickness=3;
HoleEnforcementThickness=HoleDiameter*2;

// d -> diameter of the pie
// h -> Thickness of the pie
// a -> angle of the slice
module pie_slice(d,h,a) {
  intersection() {
    cylinder(d=d, h=h, center=true);
    translate([0,0,-h/2]) cube([d,d,h]);
    rotate(a-90) translate([0,0,-h/2]) cube([d,d,h]);
  }
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
