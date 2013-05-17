
module createMeniscus(h,radius) // This module creates the shape that needs to be substracted from a cube to make its corners rounded.
difference(){        //This shape is basicly the difference between a quarter of cylinder and a cube
   translate([radius/2+0.1,radius/2+0.1,0]){
      cube([radius+0.2,radius+0.1,h+0.2],center=true);         // All that 0.x numbers are to avoid "ghost boundaries" when substracting
   } 
   cylinder(h=h+0.2,r=radius,$fn = 25,center=true);
}
 
 
module roundCornersCube(x,y,z,r)  // Now we just substract the shape we have created in the four corners
difference(){
   cube([x,y,z], center=true);
 
   translate([x/2-r,y/2-r]){  // We move to the first corner (x,y)
      rotate(0){  
         createMeniscus(z,r); // And substract the meniscus
      }
   }
   translate([-x/2+r,y/2-r]){ // To the second corner (-x,y)
      rotate(90){
         createMeniscus(z,r); // But this time we have to rotate the meniscus 90 deg
      }
   }
      translate([-x/2+r,-y/2+r]){ // ... 
      rotate(180){
         createMeniscus(z,r);
      }
   }
   translate([x/2-r,-y/2+r]){
      rotate(270){
         createMeniscus(z,r);
      }
   }
}


module projectbox_container(size, radius, thickness) {
	x = size[0] - (radius/2);
	y = size[1] - (radius/2);
	z = size[2];

	// Create the box with rounded corners and extrude inside	
	difference() {
		roundCornersCube(x, y, z, radius);
		translate([0,0,thickness]) roundCornersCube(x-thickness, y-thickness, z+thickness, radius);
	}
	
	cr = 3;

	// Create screw colums

	difference() {
		translate([-(x/2)+(thickness)+(cr/2), -(y/2)+(thickness)+(cr/2), -(z/2)]) cylinder(z, r=cr);
		translate([-(x/2)+(thickness)+(cr/2), -(y/2)+(thickness)+(cr/2), -(z/3)]) cylinder((z), r=1);
	}
	difference() {
		translate([(x/2)-(thickness)-(cr/2), -(y/2)+(thickness)+(cr/2), -(z/2)]) cylinder(z, r=cr);
		translate([(x/2)-(thickness)-(cr/2), -(y/2)+(thickness)+(cr/2), -(z/3)]) cylinder((z), r=1);
	}
	difference() {
		translate([(x/2)-(thickness)-(cr/2), (y/2)-(thickness)-(cr/2), -(z/2)]) cylinder(z, r=cr);
		translate([(x/2)-(thickness)-(cr/2), (y/2)-(thickness)-(cr/2), -(z/3)]) cylinder((z), r=1);
	}
	difference() {
		translate([-(x/2)+(thickness)+(cr/2), (y/2)-(thickness)-(cr/2), -(z/2)]) cylinder(z, r=cr);
		translate([-(x/2)+(thickness)+(cr/2), (y/2)-(thickness)-(cr/2), -(z/3)]) cylinder((z), r=1);

	}
}


module projectbox_lid(size, radius, thickness) {
	x = size[0] - (radius/2);
	y = size[1] - (radius/2);
	z = size[2];

	cr = 3;
	difference() {
		translate([-(x/2)+(thickness)+(cr/2), -(y/2)+(thickness)+(cr/2), -(z/3)]) cylinder(z, r=cr);
		translate([-(x/2)+(thickness)+(cr/2), -(y/2)+(thickness)+(cr/2), -(z)]) cylinder((z), r=0.2);
	}
	difference() {
		translate([(x/2)-(thickness)-(cr/2), -(y/2)+(thickness)+(cr/2), -(z/3)]) cylinder(z, r=cr);
		translate([(x/2)-(thickness)-(cr/2), -(y/2)+(thickness)+(cr/2), -(z)]) cylinder((z), r=0.2);
	}
	difference() {
		translate([(x/2)-(thickness)-(cr/2), (y/2)-(thickness)-(cr/2), -(z/3)]) cylinder(z, r=cr);
		translate([(x/2)-(thickness)-(cr/2), (y/2)-(thickness)-(cr/2), -(z)]) cylinder((z), r=0.2);
	}
	difference() {
		translate([-(x/2)+(thickness)+(cr/2), (y/2)-(thickness)-(cr/2), -(z/3)]) cylinder(z, r=cr);
		translate([-(x/2)+(thickness)+(cr/2), (y/2)-(thickness)-(cr/2), -(z)]) cylinder((z), r=0.2);
	}

	difference() {
		roundCornersCube(x, y, z, radius);
	   translate([0,0,(thickness/2)]) roundCornersCube(x-thickness, y-thickness, (z/2)+thickness, radius);
	}
}

// Tests:
//translate([-100, 0, 0]) projectbox_lid(size=[88,31,1], radius=2, thickness=1);
//projectbox_container(size=[88,31,8], radius=2, thickness=1);
