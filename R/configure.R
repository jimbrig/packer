configure <- function(
    name = "index",
    entry_dir = "",
    output_dir = "./inst/app/www",
    externals = list(shiny = "Shiny", jquery = "jQuery")) {

  cli::cli_h2("Creating rspack configuration")

  # Create config directory
  create_directory("srcjs/config")

  # Save entry points
  entry_points <- as.list(sprintf("%s/%s.js", entry_dir, name))
  names(entry_points) <- name
  save_json(entry_points, "srcjs/config/entry_points.json")

  # Save output path
  save_json(output_dir, "srcjs/config/output_path.json")

  # Create rspack config
  rspack_config <- sprintf(
    "const path = require('path');
const entry = require('./srcjs/config/entry_points.json');
const output_path = require('./srcjs/config/output_path.json');

module.exports = {
  mode: process.env.NODE_ENV === 'production' ? 'production' : 'development',
  entry: entry,
  output: {
    path: path.resolve(__dirname, output_path),
    filename: '[name].js'
  },
  externals: %s,
  builtins: {
    html: [
      {
        template: './srcjs/index.html'
      }
    ]
  }
}",
    jsonlite::toJSON(externals, auto_unbox = TRUE)
  )

  writeLines(rspack_config, "rspack.config.js")
  cli::cli_alert_success("Created {.file rspack.config.js}")

  # Add to build ignore
  usethis::use_build_ignore("rspack.config.js")
} 