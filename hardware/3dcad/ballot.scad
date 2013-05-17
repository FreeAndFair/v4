include <projectbox.scad>

compute_box_width = 105;
compute_box_height = 57;
button_box_width = 105;
button_box_height = 120;


module computebox() {
	// Compute box	
		projectbox_container([compute_box_width,compute_box_height,10], radius=2, thickness=2);
}

module dummybox() {
	// Dummy corner box
		projectbox_container([compute_box_width,compute_box_height,10], radius=2, thickness=2);
}

module buttonbox() {
	offset_h = 10;
	offset_w = -(5*(button_box_width/6));

	snp_offset_h = 15;
	snp_offset_w = 3;

	difference() {
		// Button boxes
		projectbox_container([button_box_width,button_box_height,10], radius=2, thickness=2);
	
		// Button holes
		for(i=[0:7]) {
			translate([offset_w+(button_box_width/2),(button_box_height/2)-(i*14)-offset_h,-11]) cylinder(20, r=3);
		}

	}
		// Snap-together holes
		for(i=[0:4]) {
			translate([-(button_box_width/2)-snp_offset_w,(button_box_height/2)-(i*20)-snp_offset_h,0]) rotate([90,0,90]) cylinder(5, r=3);
			translate([(button_box_width/2)-snp_offset_w, (button_box_height/2)-(i*20)-snp_offset_h,0]) rotate([90,0,90]) cylinder(5, r=3);


		}

}


translate([-compute_box_width/2,button_box_height+(compute_box_height/2),0]) computebox();

translate([compute_box_width/2,button_box_height+(compute_box_height/2),0]) dummybox();

translate([-button_box_width/2, -button_box_height/2, 0]) buttonbox(); 
translate([button_box_width/2,-button_box_height/2,0]) buttonbox();
translate([-button_box_width/2,button_box_height/2,0]) buttonbox();
translate([button_box_width/2,button_box_height/2,0]) buttonbox();
