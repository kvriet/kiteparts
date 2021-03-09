//CC BY-NC-SA Katrien van Riet

spar1 = 8.2; //diameter of first spar (this one goes through and through)
spar2 = 8.2; //diameter of second spar
wall_thickness = 1;
spar_offset = 3; //offset spar 2 to centre block
depth_spar = 10; //depth of spar 2
length = 13; // length of spar one tube
angle = 90; //less than 90 may cause problems

fillet = .5;

crossSection = "no"; //change to "yes" to see cross-section
spar1visible = "no"; //change to "yes" to see spar 1
spar2visible = "no"; //change to "yes" to see spar 2


//HERE BE CODE
$fn = 50;
wall = wall_thickness-fillet;
side1 = wall*2+spar1;
half_side1 = side1/2;

side2 = wall*2+spar2;
half_side2 = side2/2;

//polygon points
pointCx = -half_side1/tan(angle/2);
pointCy = half_side1;
pointFx = -pointCx;
pointFy = -pointCy;

pointAx = length;
pointAy = -half_side1;
pointBx = length;
pointBy = half_side1;

pointEx = pointFx-(depth_spar+spar_offset)*sin(angle-90);
pointEy = pointFy-(depth_spar+spar_offset)*cos(angle-90);
pointDx = pointEx-side1*cos(angle-90);
pointDy = pointEy+side1*sin(angle-90);

module base_2d(){
polygon( points=[
    [pointCx,pointCy],
    [pointBx,pointBy],
    [pointAx,pointAy],
    [pointFx,pointFy],
    [pointEx,pointEy],
    [pointDx,pointDy]
    ] );
}


module base_3d(){
    linear_extrude(height=wall*2+spar1)
    base_2d();
}

module rounded(){
    translate([-length+0.1,0,half_side1])
        rotate([0,90,0])
            cylinder(h=length*2,d=side1);
    translate([-length*2,-length*4,])
        cube([length*4,length*4,side1]);
}

module intersected(){
    intersection(){
        base_3d();
        rounded();
    }
}

module base(){
    minkowski(){
        intersected();
        sphere(fillet);
    }
}

module spar1(){
    translate([-length*2,0,half_side1])
        rotate([0,90,0])
            cylinder(h=length*4,d=spar1);
}

module spar2(){
    rotate([0,0,-angle])
        translate([spar_offset-wall+(wall+spar1/2)/tan(angle/2),0,half_side1])
            rotate([0,90,0])
                cylinder(h=depth_spar*2,d=spar2);
}

color("Aquamarine")
difference(){
    base();
    spar1();
    spar2();
    if (crossSection == "yes") {
        color("Red")
            translate([-50,-50,(spar1+wall)/2])
                cube(100);
    }
}

if (spar1visible == "yes") {
    color("Gray")
        spar1();
}

if (spar2visible == "yes") {
    color("Gray")
        spar2();
}