$fn = 100*1;

wall_thickness = 2;
bottom_inner_diameter = 45;
bottom_height = 25;
top_outer_diameter = 11;
top_height = 25;
taper_height = 15;

module make_adaptor() {
  union() {
    hull(){
      translate([bottom_inner_diameter / 2, 0, 0])
        square(wall_thickness);
      translate([(bottom_inner_diameter / 2) + (wall_thickness / 2), bottom_height, 0])
        circle(wall_thickness / 2);
    }
    
    hull(){
      translate(
        [(bottom_inner_diameter / 2) + (wall_thickness / 2),
         bottom_height,
         0])
        circle(wall_thickness / 2);
      translate(
        [(top_outer_diameter / 2) - (wall_thickness / 2),
         bottom_height + taper_height,
         0])
        circle(wall_thickness / 2);
     }
     
     hull(){
      translate(
         [(top_outer_diameter / 2) - (wall_thickness / 2),
          bottom_height + taper_height,
          0])
        circle(wall_thickness / 2);
      translate(
         [(top_outer_diameter / 2) - (wall_thickness / 2),
          bottom_height + taper_height + top_height,
          0])
        circle(wall_thickness / 2);
     }
 };
}

rotate_extrude(angle = 360, convexity = 10)
make_adaptor();
