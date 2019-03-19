use <logo.scad>

DIAMETER=45;
RING_THICKNESS=4;
HEIGHT=6;

CLIP_DIAMETER=8;
CLIP_THICKNESS=2;
CLIP_HEIGHT_PERCENTAGE=1; // The percentage compared to the height of the main cylinder


module logo_centered(size) {
  scale(v=[0.13, 0.13, 1])
  rotate([0,0,90])
  logo(size);
}

// r[adius], h[eight], [rou]n[d]
module rounded_cylinder(r,h,n) {
  rotate_extrude(convexity=1) {
    offset(r=n) offset(delta=-n) square([r,h]);
    square([n,h]);
  }
}

// r[adius], t[hickness], h[eight], [rou]n[d]
module rounded_ring(r,t,h,n) {
  rotate_extrude(convexity=1) {
    translate([r-t,0,0]) {
      offset(r=n) offset(delta=-n) square([t,h]);
    }
  }
}



module base() {
  // Base cylinder
  union() {
    rounded_ring(r=DIAMETER/2, t=RING_THICKNESS, h=HEIGHT,n=RING_THICKNESS/5,$fn=60);
    cylinder(r=DIAMETER/2,h=2*HEIGHT/3,n=2,$fn=60);
  }

  translate([-(DIAMETER/2 + CLIP_THICKNESS/2),0,HEIGHT * (1 - CLIP_HEIGHT_PERCENTAGE)/2]) {
    rounded_ring(r=CLIP_DIAMETER/2, t=CLIP_THICKNESS, h=HEIGHT * CLIP_HEIGHT_PERCENTAGE,n=CLIP_THICKNESS/3,$fn=60);
  }
}

union() {
  logo_centered(6);
  base();
}
