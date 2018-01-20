use <MCAD/boxes.scad>

// panel setup
section_width = 26;
section_height = 78.2;
sections = 5;
panel_thick = 5;
margin_left = 5;
margin_right = 10;
grid_size = 5;
grid_thick = 2;
construction_frame_thick = 3;
construction_frame_width = 3;

// switch setup
switch_body_width = 19.5;
switch_body_height = 13.2;
switch_frame_width = 22;
switch_frame_height = 16;
switch_frame_thick = 2;
switch_margin_top = 8;

// power LED setup
led_width = 5.5;
led_height = 2.5;
led_margin_top = 28.5;

// socket setup
socket_mount_hole = 8;
socket_frame_hole = 10.2;
socket_frame_thick = 3;
socket_vcc_margin_top = 40;
socket_gnd_margin_top = 60;

// box setup
box_frame = 10;
box_rounding = 20;
pcb_depth = 52;
back_depth = 4;
back_holder_width = 10;
pcb_thick = 2.3;
box_top_depth = 20;
frame_hole_dia = 3.6;
frame_hole_head = 8;
cable_hole_dia = 10;

// workbench setup
mountholes_pitch = 38;
mounthole_dia = 5.5;




// internal
total_width = margin_left + margin_right + sections*section_width;
box_depth = pcb_depth + back_depth;

//translate([total_width/-2, (section_height)/-2, box_depth/2-2]) front_plate();
//back_cover();
translate([0, 0, 20]) top_cover();

 box_width = total_width + 2*box_frame;
box_height = section_height + 2*box_frame;

cutout_width = total_width - 2*construction_frame_width;
cutout_height = section_height - 2*construction_frame_width;

module top_cover() {
    top_cover_depth = box_top_depth+construction_frame_thick-1;
    difference() {
        roundedBox([box_width, box_height, top_cover_depth], box_rounding, 10);
        
        // inner cutout
        translate([0, 0, top_cover_depth/-2+box_top_depth/2-1]) cube(size=[box_width-box_frame-5+1, box_height-box_frame-5+1, box_top_depth], center=true);
        
        // switch+LED cutout
        switch_section_size = (socket_vcc_margin_top - (socket_vcc_margin_top - led_margin_top - led_height)/2 - grid_size/2) - construction_frame_width + 1;
        translate([0, section_height/2 - switch_section_size/2 - construction_frame_width + 0.5, 0]) cube(size=[total_width - 2*construction_frame_width+1, switch_section_size, top_cover_depth+1], center=true);
        
        // vcc cutout
        vcc_section_size = (socket_gnd_margin_top - (socket_gnd_margin_top - socket_vcc_margin_top - socket_frame_hole)/2 - grid_size/2) - (socket_vcc_margin_top - (socket_vcc_margin_top - led_margin_top - led_height)/2 + grid_size/2) + 1;
        translate([0, section_height/-2 + vcc_section_size/2 + (section_height - socket_gnd_margin_top + (socket_gnd_margin_top - socket_vcc_margin_top - socket_frame_hole)/2 + grid_size/2 - 0.5), 0]) cube(size=[total_width - 2*construction_frame_width+1, vcc_section_size, top_cover_depth+1], center=true);
        
        // gnd cutout
        gnd_section_size = section_height - switch_section_size - vcc_section_size - 2*grid_size - 2*construction_frame_width + 3;
        translate([0, section_height/-2 + gnd_section_size/2 + construction_frame_width - 0.5]) cube(size=[total_width - 2*construction_frame_width+1, gnd_section_size, top_cover_depth+1], center=true);
        
        // grid cutout 
        translate([]) cube(size=[total_width - 2*construction_frame_width+1, section_height-2*construction_frame_width-2, top_cover_depth - grid_thick*2 +1], center=true);
        
        // frame holes
        translate([box_width/-4, box_height/2+1, -construction_frame_thick]) rotate(a=[90, 0, 0]) cylinder(d=frame_hole_dia, h=box_height+10, $fn=100);
        translate([box_width/4, box_height/2+1, -construction_frame_thick]) rotate(a=[90, 0, 0]) cylinder(d=frame_hole_dia, h=box_height+10, $fn=100);
        // screw head holes
        translate([box_width/-4, box_height/-2-1, -construction_frame_thick]) rotate(a=[-90, 0, 0]) cylinder(d=frame_hole_head, h=5, $fn=100);
        translate([box_width/4, box_height/-2-1, -construction_frame_thick]) rotate(a=[-90, 0, 0]) cylinder(d=frame_hole_head, h=5, $fn=100);
        translate([box_width/-4, box_height/2 + 1, -construction_frame_thick]) rotate(a=[90, 0, 0]) cylinder(d=frame_hole_head, h=5, $fn=100);
        translate([box_width/4, box_height/2 + 1, -construction_frame_thick]) rotate(a=[90, 0, 0]) cylinder(d=frame_hole_head, h=5, $fn=100);
    }
    //translate([box_width/-4, box_height/-2-1, -construction_frame_thick]) rotate(a=[-90, 0, 0]) cylinder(d=frame_hole_head, h=5, $fn=100);
}

module back_cover() {
   
    
    
    difference() {
        union() {
            difference() {
                roundedBox([box_width, box_height, box_depth], box_rounding, 10);
                
                // cutout whole box
                cube(size=[cutout_width, cutout_height, box_depth+2], center=true);
                
                
                // front plate cutout
                front_plate_cutout = panel_thick - construction_frame_thick + 1;
                translate([0, 0, front_plate_cutout/-2+box_depth/2+1]) cube(size=[total_width+1, section_height+1, front_plate_cutout], center=true);
            }
            
 
            // back holders
           translate([0, 20, box_depth/-2+back_depth/2]) cube(size=[box_width, back_holder_width, back_depth], center=true); 
            translate([0, 20-mountholes_pitch*1, box_depth/-2+back_depth/2]) cube(size=[box_width, back_holder_width, back_depth], center=true);
        }
        
        // pcb holder
        translate([0, section_height/2-led_margin_top-led_height-2.5/2, back_depth]) cube(size=[total_width+3, pcb_thick, box_depth], center=true);
        
        // cable hole
        translate([0, section_height/2-led_margin_top+led_height-2.5/2 + cable_hole_dia/2, box_depth/-2 + back_depth + cable_hole_dia/2+2]) rotate(a=[0, 90, 0]) cylinder(d=cable_hole_dia, h=box_width, $fn=100); 
        
        // mount holes
        translate([mountholes_pitch, 20, box_depth/-2-1]) cylinder(d=mounthole_dia, h=box_depth, $fn=100);
        translate([-mountholes_pitch, 20, box_depth/-2-1]) cylinder(d=mounthole_dia, h=box_depth, $fn=100);
        translate([mountholes_pitch, 20-mountholes_pitch*1, box_depth/-2-1]) cylinder(d=mounthole_dia, h=box_depth, $fn=100);
        translate([-mountholes_pitch, 20-mountholes_pitch*1, box_depth/-2-1]) cylinder(d=mounthole_dia, h=box_depth, $fn=100);
        
        // mount frame
        translate([0, 0, box_top_depth/-2+box_depth/2+0.01]) difference() {
            cube(size=[box_width+1, box_height+1, box_top_depth], center=true);
            cube(size=[box_width-box_frame-5, box_height-box_frame-5, box_top_depth+1], center=true);
    }
        // frame holes
        translate([box_width/-4, box_height/2+1, box_depth/2 - box_top_depth/2]) rotate(a=[90, 0, 0]) cylinder(d=frame_hole_dia, h=box_height+10, $fn=100);
        translate([box_width/4, box_height/2+1, box_depth/2 - box_top_depth/2]) rotate(a=[90, 0, 0]) cylinder(d=frame_hole_dia, h=box_height+10, $fn=100);
        // nut traps
        translate([box_width/-4, box_height/2-box_frame/2+5/2-box_frame/1.25, box_depth/2 - box_top_depth/2]) rotate(a=[90, 0, 0]) cylinder(r=5.5 / 2 / cos(180 / 6) + 0.05, h=50, $fn=6);
        translate([box_width/4, box_height/2-box_frame/2+5/2-box_frame/1.25, box_depth/2 - box_top_depth/2]) rotate(a=[90, 0, 0]) cylinder(r=5.5 / 2 / cos(180 / 6) + 0.05, h=50, $fn=6);
        translate([box_width/-4, box_height/-2 + box_frame+20/2+12.5, box_depth/2 - box_top_depth/2]) rotate(a=[90, 0, 0]) cylinder(r=5.5 / 2 / cos(180 / 6) + 0.05, h=22, $fn=6);
        translate([box_width/4, box_height/-2 + box_frame+20/2+12.5, box_depth/2 - box_top_depth/2]) rotate(a=[90, 0, 0]) cylinder(r=5.5 / 2 / cos(180 / 6) + 0.05, h=22, $fn=6);
    
        
    }
    
    
}

module front_plate() {

    
    
    
    difference() {
        cube(size=[total_width, section_height, panel_thick]);
        
        // mount holes
        for (i = [0:sections-1]) {
            translate([margin_left+section_width/2+i*section_width, 0, 0]) section_holes();            
        }
        
        // grid between switch and vcc
        translate([-1, section_height - socket_vcc_margin_top + (socket_vcc_margin_top - led_margin_top - led_height)/2 - grid_size/2, panel_thick - grid_thick]) cube(size=[total_width+2, grid_size, grid_thick+1]);
        // grid between vcc and gnd
        translate([-1, section_height - socket_gnd_margin_top + (socket_gnd_margin_top - socket_vcc_margin_top - socket_frame_hole)/2 - grid_size/2, panel_thick - grid_thick]) cube(size=[total_width+2, grid_size, grid_thick+1]);
        
        // construction frame
        // top
        translate([-1, section_height-construction_frame_width, panel_thick-construction_frame_thick]) cube(size=[total_width+2, construction_frame_width+1, construction_frame_thick+1]);
        // bottom
        translate([-1, -1, panel_thick-construction_frame_thick]) cube(size=[total_width+2, construction_frame_width+1, construction_frame_thick+1]);
        // left
        translate([-1, -1, panel_thick-construction_frame_thick]) cube(size=[construction_frame_width+1, section_height+2, construction_frame_thick+1]);
        // right
        translate([total_width-construction_frame_width, -1, panel_thick-construction_frame_thick]) cube(size=[construction_frame_width+1, section_height+2, construction_frame_thick+1]);
        
        // main power LED
        translate([total_width-construction_frame_width-1-led_height, section_height+led_width/2-led_margin_top-led_height, panel_thick/2]) cube(size=[led_height, led_width, panel_thick+2], center=true);
    }
}

module section_holes() {
    // switch body
    translate([0, section_height-switch_body_height/2-switch_margin_top, panel_thick/2]) cube(size=[switch_body_width, switch_body_height, panel_thick+2], center=true);
    // switch frame
    translate([0, section_height-switch_body_height/2-switch_margin_top, switch_frame_thick/2+panel_thick-switch_frame_thick+0.01]) cube(size=[switch_frame_width, switch_frame_height, switch_frame_thick], center=true);
    // power LED
    translate([0, section_height-led_height/2-led_margin_top, panel_thick/2]) cube(size=[led_width, led_height, panel_thick+2], center=true);
    // socket vcc body
    translate([0, section_height-socket_frame_hole/2-socket_vcc_margin_top, -1]) cylinder(d=socket_mount_hole, h=panel_thick+2, $fn=100); 
    // socket vcc frame
    translate([0, section_height-socket_frame_hole/2-socket_vcc_margin_top, panel_thick-socket_frame_thick]) cylinder(d=socket_frame_hole, h=panel_thick+2, $fn=100); 
    // socket gnd body
    translate([0, section_height-socket_frame_hole/2-socket_gnd_margin_top, -1]) cylinder(d=socket_mount_hole, h=panel_thick+2, $fn=100); 
    // socket gnd frame
    translate([0, section_height-socket_frame_hole/2-socket_gnd_margin_top, panel_thick-socket_frame_thick]) cylinder(d=socket_frame_hole, h=panel_thick+2, $fn=100); 
}