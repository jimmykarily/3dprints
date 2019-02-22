include <threads.scad>;

// Sizes in mm

// The total diameter of the whole mount
outerDiameter=30;

// The height of the bottom part
BottomMountHeight=20;

// How much should the hihat slide?
slideHeight=40;

// The diameter of the hole of the top part.
// Measure your hihat axis width.
MountHoleDiameter=4;

// When "drilling" a hole, make sure we are all the way out;
ThroughtAndThroughHoleAdjustement=4;


topMountHoleDiameter=10;


module BottomPart() {
  difference() {
    union() {
      // Bottom part main cylinder
      cylinder(BottomMountHeight, outerDiameter, outerDiameter, center=true);

      // Bottom part small cylinder (the slide)
      translate([0,0,BottomMountHeight/2])
      union() {
        cylinder(slideHeight, topMountHoleDiameter, topMountHoleDiameter);
        translate([topMountHoleDiameter,-topMountHoleDiameter/4,0]) {
          union() {
            // Main slide "tooth"
            cube([topMountHoleDiameter/2, topMountHoleDiameter/2, slideHeight]);

            // Fill in the gap between cylinder and "tooth"
            translate([-topMountHoleDiameter/8,0,0]) {
              cube([topMountHoleDiameter/2, topMountHoleDiameter/2, slideHeight]);
            }
          }
        }
      }
    }
    // Bottom part hole
    translate([0,0, -(BottomMountHeight/2 + ThroughtAndThroughHoleAdjustement/2)])
    cylinder(slideHeight + BottomMountHeight + ThroughtAndThroughHoleAdjustement, MountHoleDiameter, MountHoleDiameter);
  }


  //metric_thread (10, 1, 10);
}

BottomPart();
