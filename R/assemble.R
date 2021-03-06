#' A Reproducible Method for Creating Packages
#' The intent of the assemble_package function is to create a function that
#' automatically creates new R packages with preconfigured settings to
#' 1) speed up the process required to create an R package and
#' 2) standardize the settings of R packages used in production.
#' @param .name the name of the package as a quoted string.
#' @param .path the file path where the package will be stored locally.
#' @param .private_repo a logical statement signifying if the GitHub repository should be private.
#' The default is FALSE, which indicates the GitHub repository is public.
#' @return a preconfigured R-package.
#' @export
#' @examples
#'\dontrun{
#' assemble_package(.name = "validator",
#' .path = file.path("C:", "Users", "zmsmith.000",
#'  "OneDrive - New York State Office of Information Technology Services",
#'  "projects"),
#' .your_name = "Zachary M. Smith",
#' .private_repo = FALSE)
#'}


assemble_package <- function(.name, .path, .private_repo = FALSE) {
  file_path.vec <- file.path(.path, .name)

  usethis::create_package(
    # The .path and .name will be concatenated to represent the file path.
    # It seemed more intuitive to specify the name independently of the path.
    path = file_path.vec,
    fields = list(),
    # Will create an RStudio package.
    rstudio = rstudioapi::isAvailable(),
    # Yes, always use royxgen2 for documentation format.
    roxygen = TRUE,
    # We will not be publishing to CRAN, therefore this check is not needed.
    check_name = FALSE,
    # Do not open a new RStudio session at this point
    open = FALSE
  )

  usethis::with_project(
    path = file_path.vec,
    code = list(
      usethis::use_description_defaults(),
      # Puts fields in standard order and alphabetizes dependencies.
      usethis::use_tidy_description(),
      # Add the MIT license to the Description file.
      # usethis::use_mit_license(name = .your_name),
      # Include test coverage once I have a better understanding of
      # implementation.
      #use_coverage(type = c("codecov", "coveralls")),
      # Add a description of the package.
      usethis::use_package_doc(),
      # Create a readMe template.
      usethis::use_readme_md(open = FALSE),
      # The package should always start as experimental and be
      # updated as progress is made.
      usethis::use_lifecycle_badge(stage = "Experimental"),
      # Add spell check of vignettes to R CMD Check.
      usethis::use_spell_check(
        vignettes = TRUE,
        lang = "en-US",
        # Does not throw an error but provides
        # a list of potential spelling errors.
        error = FALSE
      ),
      # Setup testthat infrastructure.
      usethis::use_testthat(),
      # Start with a fresh session each time the project is opened.
      usethis::use_blank_slate(scope = "project"),
      # Make devtools available in interactive sessions with the package.
      usethis::use_devtools(),
      # Make usethis available in interactive sessions with the package.
      usethis::use_usethis(),
      # Create a git repository.
      usethis::use_git(),
      # Establish GitHub repository in BWAM.
      usethis::use_github(
        organisation = "BWAM",
        private = .private_repo,
        protocol = "https",
        credentials = NULL,
        auth_token = gh::gh_token(),
        host = NULL
      ),
      # devtools::document(pkg = file_path.vec),
      # devtools::build(pkg = file_path.vec),
      # Always create a website to house documentation.
      usethis::use_pkgdown(config_file = "_pkgdown.yml",
                           destdir = "docs"),
      # # Run to build the website
      # pkgdown::build_site(pkg = file_path.vec,
      #                     install = FALSE),
      # I believe this add the URL to the pkgdown website.
      usethis::use_github_links(
        auth_token = usethis::github_token(),
        host = "https://api.github.com",
        overwrite = FALSE
      ),
      # Adds .DS_Store, .Rproj.user, and .Rhistory to your global .gitignore.
      usethis::git_vaccinate()
      # Setup infrastructure for github actions.
      # usethis::use_github_actions(),
      # Add a github actions badge to the readMe.
      # usethis::use_github_actions_badge(name = "R-CMD-check"),
      # This action runs R CMD check via the rcmdcheck package on
      # the three major OSs (linux, macOS and Windows) on the
      # release version of R and R-devel.
      # usethis::use_github_action_check_standard(save_as = "R-CMD-check.yaml",
      #                                           ignore = FALSE,
      #                                           open = FALSE)#,
      # # Include a code of conduct.
      # usethis::use_code_of_conduct(path = NULL)
    )# End List
  ) # End with_project

  usethis::proj_activate(path = file_path.vec)

}
