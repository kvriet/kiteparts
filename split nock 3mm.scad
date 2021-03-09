//CC BY-NC Katrien van Riet

//VARIABLES in mm!
diameter = 3.2;
length = 17.5;
depth = 13;
wall_thickness = 1; //at the corners (due to hexagon)
hole = 2.7;
fillet = .75;

visualisation = "no" ; //change to "yes" to preview rod placement
crossSection = "no" ; //change to "yes" to see cross-section



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
            cylinder(d=diameter+wall_thickness*2, h=length, $fn=6);
            sphere(fillet,$fn=30);
        }
        translate([0,diameter,depth+2.3])
            rotate([90,0,0])
                cylinder(d=hole,h=diameter*2);
        translate([0,0,length-(length-depth)/2+hole/2])
            cube([hole/1.5,diameter*2,length-depth],center=true);
        translate([0,0,-hole/2])
            cylinder(d=diameter,h=depth);
        if (crossSection == "yes"){
            translate([-25,0,-1])
                cube([50,10,100]);
        }
    }
}


translate([0,0,fillet])
    cap();