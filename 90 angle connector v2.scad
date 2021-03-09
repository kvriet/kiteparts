$fn = 100;

//variabelen
diameter_stok = 6.4;
breedte = 30;
diameter_kruisgat = 2.5;


//fillet = 0.5mm dus 0.5mm sphere (radius)
//dus alle maten 1 kleiner
fillet = 0.5;
ronding = breedte/5-fillet; //dit moet fillet zijn!

module base(){
    
    module sliver(){
        translate([breedte-fillet-ronding,breedte-fillet-ronding,0])
        difference(){
            cube([ronding,ronding,diameter_stok+2-fillet]);
            cylinder(r=ronding,h=diameter_stok+2-fillet);
        }
    }
    
    difference(){
        cube([breedte-fillet,breedte-fillet,diameter_stok+2-fillet]);
        cylinder(h=diameter_stok+2,r=breedte-diameter_stok-2);
        sliver();
    }
}

module basis(){
    minkowski(){
        base();
        sphere(fillet);
    }
}


module gaten(){
    translate([breedte-diameter_stok/2-1-fillet/2,-fillet,(diameter_stok+2-fillet)/2])
    rotate([-90,0,0])
    cylinder(h=breedte-diameter_stok-4,d=diameter_stok);
    
    translate([-fillet,breedte-diameter_stok/2-1-fillet/2,(diameter_stok+2-fillet)/2])
    rotate([0,90,0])
    cylinder(h=breedte-diameter_stok-4,d=diameter_stok);

    translate([breedte/2,breedte/2,(diameter_stok+2-fillet)/2])
    rotate([90,0,-45])
    cylinder(h=breedte*2,d=diameter_kruisgat,center=true);
}

module indent_stok(){
    translate([breedte-diameter_stok/2-1-fillet/2,fillet*1.3-diameter_stok,(diameter_stok+2-fillet)/2])
    sphere(diameter_stok);
    
    translate([fillet*1.3-diameter_stok,breedte-diameter_stok/2-1-fillet/2,(diameter_stok+2-fillet)/2])
    sphere(diameter_stok);
}

module indent_kruisgat(){
    translate([sqrt(pow((breedte-diameter_stok-2),2)/2)-diameter_kruisgat/1.5,sqrt(pow((breedte-diameter_stok-2),2)/2)-diameter_kruisgat/1.5,(diameter_stok+2-fillet)/2])
    sphere(diameter_kruisgat);
    
    translate([breedte-ronding/2+fillet*2,breedte-ronding/2+fillet*2,(diameter_stok+2-fillet)/2])
    sphere(diameter_kruisgat);
}

difference(){
    basis();
    gaten();
    indent_stok();
    indent_kruisgat();
}

    //indent_kruisgat();
