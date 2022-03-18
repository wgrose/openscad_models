$fn = 100 * 1;

// Main parameters
bottom_inner_diameter = 49; // 49mm Fits 1 3/4 vacuum hose.
top_outer_diameter = 11;

// Fine parameters
taper_height = 15;
bottom_height = 25;
top_height = 25;
wall_thickness = 1;
inflator_nib_height = 5;
inflator_nib_tip = 1;
curve_scale = 2;

// Privates
top_minus_nib_height_ = bottom_height + taper_height + top_height;
cutout_cube_x_offset_ = (top_outer_diameter - (top_outer_diameter / 3));
cutout_cube_z_height_ = top_minus_nib_height_ + wall_thickness +
  inflator_nib_height - inflator_nib_tip - wall_thickness;
shrink_factor_ = 1.5;

module make_adaptor() {
  union() {
    // Bottom to taper
    hull() {
      translate([bottom_inner_diameter / 2, 0, 0])
      square(wall_thickness);
      translate([(bottom_inner_diameter / 2) + (wall_thickness / 2),
        bottom_height, 0
      ])
      circle(wall_thickness / 2);
    };

    // Taper to upper
    hull() {
      translate(
        [(bottom_inner_diameter / 2) + (wall_thickness / 2),
          bottom_height,
          0
        ])
      circle(wall_thickness / 2);
      translate(
        [(top_outer_diameter / 2) - (wall_thickness / 2),
          bottom_height + taper_height,
          0
        ])
      circle(wall_thickness / 2);
    };

    // Upper to top
    hull() {
      translate(
        [(top_outer_diameter / 2) - (wall_thickness / 2),
          bottom_height + taper_height,
          0
        ])
      circle(wall_thickness / 2);
      translate(
        [(top_outer_diameter / 2) - (wall_thickness / 2),
          top_minus_nib_height_,
          0
        ])
      circle(wall_thickness / 2);
    };
  };
};

rotate_extrude(angle = 360, convexity = 10)
make_adaptor();
