include <configuration.scad>;
include <Pulley.scad>;

radius = 9;
width = 16;
top = 5;
smoothness = 60;

module spool() {
  difference() {
    union() {
      cylinder(r=radius, h=width, center=true, $fn=smoothness);
      translate([0, 0, width/2])
	cylinder(r1=radius, r2=radius+2, h=2, center=true, $fn=smoothness);
      translate([0, 0, -width/2])
	cylinder(r2=radius, r1=radius+2, h=2, center=true, $fn=smoothness);
      translate([0, 0, width/2+top/2+1])
	cylinder(r=radius+2, h=top, center=true, $fn=smoothness);
    }
    // Motor shaft.
    //cylinder(r=motor_shaft_radius, h=50, center=true, $fn=24);
    // Filament tunnels.
    rotate([0,0,180]) translate([0, radius, width/2-1.5]) rotate([-30, 0, 0])
      #cube([1, 2*radius, 1.5], center=true);
    rotate([0,0,180]) translate([0, radius, -width/2+1.5]) rotate([30, 0, 0])
      #cube([1, 2*radius, 1.5], center=true);
    rotate([0,0,180]) translate([0, radius*0.7, 0])
      #cylinder(r=1, h=40, center=true, $fn=6);
    // M3 screws and nuts on three sides.
    for (a = [0:120:359]) {
      rotate([0, 0, a]) translate([0, 4.5, width/2+3]) rotate([90, 0, 0]) {
	cylinder(r=m3_wide_radius, h=radius+5, center=true, $fn=12);
	//3x ears translate([0, 0, 1-radius]) cylinder(r=10, h=6, center=true);
	for (z = [0:10]) {
	  translate([0, z, 0]) rotate([0, 0, 30])
	    cylinder(r=m3_nut_radius, h=7, center=true, $fn=6);
	}
      }
    }
  }
}

difference(){
translate([0, 0, width/2+1]) spool();
//pulley hole
translate([0,0,24]) rotate([180,0,0]) pulley ( "GT2 2mm" , GT2_2mm_pulley_dia , 0.764 , 1.494 );
}

