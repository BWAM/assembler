assemble_pkg <- function(.path, .open) {
  create_package(
    path = .path,
    fields = list(),
    # Will create an RStudio package.
    rstudio = rstudioapi::isAvailable(),
    roxygen = TRUE,
    # We will not be publishing to CRAN, therefore this check is not needed.
    check_name = FLASE,
    open = .open
  )

}

assemble_proj <- function(.path, .open) {
  create_project(
    path = .path,
    rstudio = rstudioapi::isAvailable(),
    open = .open
  )
}


assemble_github(.private = TRUE) {
  use_this::use_github(organisation = "BWAM",
                       private = .private)
}
