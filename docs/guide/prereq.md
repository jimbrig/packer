# Prerequisites

This page includes what is necessary to understand in order to work with packer but is not a full-blown tutorial on how to get up to speed.

## R packages

R packages make sharing code, datasets, and anything else R-related extremely easy, they also come with a relatively strict structure, the ability to run unit tests, and much more. These have thus become a core feature of the R ecosystem and therefore are also used as the backbone of every packer project.

```r
# create a package named usesJS
usethis::create_package("usesJS")
```

<Note>
Only the <code>scaffold_rmd</code> is not rooted in a package and instead from a project.
</Note>

## Npm

Npm is Node's Package Manager and is, in a sense, Node's equivalent of CRAN, albeit much less strict. It contains a plethora of JavaScript packages waiting to be used with R packages, shiny apps, and plenty of other things. Npm is at its core very simple and packer provides convenience functions to interact with it from R.

```r
# install the sass package for development purposes.
packer::npm_install("sass", scope = "dev")
```

## Rspack

Rspack is the core of packer, it's what enables modularising JavaScript code, very much like modularising a shiny application: making code more manageable and reusable throughout the application. It is configured from the `rspack.config.js` file which handles both development and production builds - development builds include sourcemaps for clearer error messages while production builds are optimized for deployment.

You can interact with rspack from R with packer using `packer::bundle` to bundle all the files or `packer::watch` to watch for changes in the JavaScript files and re bundles them when things change, ideal while developing the package.

```r
# bundle JavaScript files for prod (default)
packer::bundle()
```
