$fn = 100 * 1;

// Main parameters
bottom_inner_diameter = 49; // 49mm Fits 1 7/8 vacuum hose.
top_outer_diameter = 6;

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

    // Nib
    difference() {
      difference() {
        difference() {
          translate(
            [0,
              top_minus_nib_height_,
              0
            ])
          scale([1.0, curve_scale, 3.0]) circle(top_outer_diameter /
            2);
          // Minus the inside ellipse.
          translate([
            0,
            top_minus_nib_height_,
            0
          ])
          scale([1.0 / shrink_factor_, curve_scale / shrink_factor_,
            3.0 / shrink_factor_
          ]) circle(top_outer_diameter / 2);
        };
        square([top_outer_diameter / 2 - wall_thickness,
          top_minus_nib_height_
        ]);
      };
      // Get rid of negative x axis.
      translate(
        [-(top_outer_diameter - (wall_thickness * 2)), 0, 0])
      square([
        (top_outer_diameter - (wall_thickness * 2)),
        (top_minus_nib_height_ + wall_thickness +
          inflator_nib_height - inflator_nib_tip + (
            top_outer_diameter / 2) * curve_scale)
      ]);
    };
  };
};

difference() {
  rotate_extrude(angle = 360, convexity = 10)
  make_adaptor();
  // Left nib cutout
  translate(
    [-cutout_cube_x_offset_, 0, cutout_cube_z_height_]) cube([
    top_outer_diameter, top_outer_diameter, inflator_nib_height * 2
  ], center = true);
  // Right nib cutout
  translate(
    [cutout_cube_x_offset_, 0, cutout_cube_z_height_]) cube([
    top_outer_diameter, top_outer_diameter, inflator_nib_height * 2
  ], center = true);
};