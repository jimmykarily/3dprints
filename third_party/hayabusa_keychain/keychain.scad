DIAMETER=45;
RING_THICKNESS=4;
HEIGHT=6;

CLIP_DIAMETER=8;
CLIP_THICKNESS=2;
CLIP_HEIGHT_PERCENTAGE=0.8; // The percentage compared to the height of the main cylinder

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



// The original logo size is made to fit in a 50 DIAMETER;
scale_factor=DIAMETER/50;

scale(scale_factor) {
  translate([0, 0, HEIGHT/2 - 2.3]) {
    translate([-11,-3,8]) { // center the logo
      rotate(a=[180,0,270]){
        import("Keychain_Hayasuna_logo.stl");
      }
    }
  }
}



// Base cylinder
union() {
  rounded_ring(r=DIAMETER/2, t=RING_THICKNESS, h=HEIGHT,n=RING_THICKNESS/5,$fn=60);
  cylinder(r=DIAMETER/2,h=HEIGHT/2,n=2,$fn=60);
}

translate([-(DIAMETER/2 + CLIP_THICKNESS/2),0,HEIGHT * (1 - CLIP_HEIGHT_PERCENTAGE)/2]) {
  rounded_ring(r=CLIP_DIAMETER/2, t=CLIP_THICKNESS, h=HEIGHT * CLIP_HEIGHT_PERCENTAGE,n=CLIP_THICKNESS/3,$fn=60);
}


/*
//linear_extrude(height = 40)
scale([1,1,0.1])
surface(file="logo_text.png", invert=true, center=true, convexity=5);
*/
