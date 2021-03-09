//CC BY-NC Katrien van Riet

//VARIABLES in mm!
spar_diam = 5.2; //spar diameter
wall = 1; //wall thickness
depth = 15; //depth of spar into connector
fillet = 0.5; //fillet

//BEST NOT TO CHANGE THESE
$fn = 150;
wall_thickness = wall-fillet;
total_height = depth+wall_thickness*2+spar_diam;
spar_height = wall_thickness*2+spar_diam;


//HERE BE CODE
//create base unit, which is then copied twice
module unit(){
    difference(){
        cube([total_height,spar_height,total_height]);
        translate([total_height,spar_height+0.05,total_height])
        rotate([90,0,0])
        cylinder(h=spar_height*1.1,r=depth);
    }
}

//base unit copied twice
module three_way(){
    unit();
    translate([spar_height,0,0])
        rotate([0,0,90])
            unit();    
    translate([0,0,spar_height])
        rotate([-90,0,0])
            unit();    

}

//add spar holes to three-way unit
difference(){
    render(){
        minkowski($fn=50){
            three_way();
            sphere(d=fillet,$fn=20);
        }
    }
    translate([spar_height/2,spar_height/2,spar_height+0.1])
        cylinder(h=depth+fillet+0.1,d=spar_diam);
    translate([0,0,spar_height])
        rotate([-90,0,0])
            translate([spar_height/2,spar_height/2,spar_height+0.1])
                cylinder(h=depth+fillet+0.1,d=spar_diam);
    translate([0,0,spar_height])
        rotate([0,90,0])
            translate([spar_height/2,spar_height/2,spar_height+0.1])
                cylinder(h=depth+fillet+0.1,d=spar_diam);
}

