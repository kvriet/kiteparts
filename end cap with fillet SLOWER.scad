//CC BY-NC Katrien van Riet

//VARIABLES in mm!
diameter = 1.7;
length = 13;
depth = 9;
wall_thickness = 1; //at the corners
hole = 1.5;
fillet = .25;

visualisation = "no" ; //change to "yes" to preview rod placement



//BETTER NOT TO CHANGE THIS
radius = diameter/2+wall_thickness;
$fn=50;

//HERE BE CODE
mirror([1,0,0])
    rotate([90,0,90])
        if (visualisation == "yes") {
            color("Gray")
                translate([0,0,-hole/2-10])
                    cylinder(d=diameter+.01,h=depth+10);
        }
    
module cap(){
    color("LightBlue",.7)
    difference(){
        minkowski($fn=20){
            difference(){
                cylinder(d=diameter+wall_thickness*2, h=length, $fn=6);
                translate([0,diameter,depth+1])
                    rotate([90,0,0])
                        cylinder(d=hole,h=diameter*2);
                translate([0,0,length-(length-depth)/2+hole/2])
                   cube([hole/1.5,diameter*2,length-depth],center=true);
            }
                sphere(fillet,$fn=30);
        }
        translate([0,0,-hole/2])
            cylinder(d=diameter,h=depth);
    }
}

mirror([1,0,0])
    rotate([90,0,90])
        cap();

