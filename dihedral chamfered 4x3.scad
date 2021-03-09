

top_width = 10;
side_diam = 3.4; //diameter of side spar
mid_diam = 4.3; //diameter of middle spar
depth_spar = 16;
spar_offset = 2; //offset spar to centre block
hole_offset = 1; //offset side hole to sides
fillet = .5;
angle = 15; //angle of dihedral


$fn = 50;

height = side_diam+hole_offset*2;


module spar(){
    rotate([0,0,angle])
        rotate([0,-90,0])
            translate([0,0,spar_offset])
                cylinder(d=side_diam,h=depth_spar*1.1);
//    rotate([0,0,angle])
//        rotate([0,-90,0])
//            translate([0,0,spar_offset+depth_spar])
//                cylinder(d1=side_diam,d2=side_diam*1.5,h=side_diam/3);
}

//polygon points
pointBx = -(depth_spar+spar_offset)*cos(angle)-(hole_offset+side_diam/2)*sin(angle);
pointBy = -(depth_spar+spar_offset)*sin(angle)+(hole_offset+side_diam/2)*cos(angle);
pointCx = -(depth_spar+spar_offset)*cos(angle)+(hole_offset+side_diam/2)*sin(angle);
pointCy = -(depth_spar+spar_offset)*sin(angle)-(hole_offset+side_diam/2)*cos(angle);
pointDx = top_width/10;
pointDy = -top_width/2;
pointEx = top_width/2;
pointEy = -top_width/2;
pointFx = top_width/2;
pointFy = top_width/2;
pointGx = 0;
pointGy = top_width/2;

module base_quart_2d(){
polygon( points=[[pointBx,pointBy],[pointCx,pointCy],[pointDx,pointDy],[pointEx,pointEy],[pointFx,pointFy],[pointGx,pointGy]] );
}
module base_quart_3d(){
	linear_extrude(height/2)base_quart_2d();
}

module base_half_3d(){
		mirror([0,0,1])base_quart_3d();
		base_quart_3d();
}

module half_translated(){
	translate([-top_width/2,0,0])	base_half_3d();
}

module whole(){
	mirror([1,0,0])half_translated();
	half_translated();
}

module filleted(){
	minkowski(){
		whole();
		sphere(fillet);
	}
}

difference(){
	filleted();
	cylinder(d=mid_diam,h=height*1.2,center=true);
	translate([0,0,height/2])
	cylinder(d1=mid_diam,d2=mid_diam*1.5,h=mid_diam/3);
	translate([0,0,-height/2-mid_diam/3])
	cylinder(d2=mid_diam,d1=mid_diam*1.5,h=mid_diam/3);
	translate([-top_width/2,0,0])spar();
	translate([top_width/2,0,0])mirror([1,0,0])
    spar();
//    translate([hole_offset+mid_diam/2,-2,side_diam/2+hole_offset])
//    rotate([0,0,-angle])
//    linear_extrude(height=.5)
//    text("vector", size=side_diam+hole_offset);
}