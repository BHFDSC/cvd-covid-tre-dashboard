sass::sass(
  input = list(
    sass::sass_file("www/bhf_dsc_design.scss")
  ),
  output = "www/bhf_dsc_design_sass.css",
  options = sass::sass_options(output_style = "compressed")
)
