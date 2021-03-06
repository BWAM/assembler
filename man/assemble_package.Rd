% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assemble.R
\name{assemble_package}
\alias{assemble_package}
\title{A Reproducible Method for Creating Packages
The intent of the assemble_package function is to create a function that
automatically creates new R packages with preconfigured settings to
\enumerate{
\item speed up the process required to create an R package and
\item standardize the settings of R packages used in production.
}}
\usage{
assemble_package(.name, .path, .private_repo = FALSE)
}
\arguments{
\item{.name}{the name of the package as a quoted string.}

\item{.path}{the file path where the package will be stored locally.}

\item{.private_repo}{a logical statement signifying if the GitHub repository should be private.
The default is FALSE, which indicates the GitHub repository is public.}
}
\value{
a preconfigured R-package.
}
\description{
A Reproducible Method for Creating Packages
The intent of the assemble_package function is to create a function that
automatically creates new R packages with preconfigured settings to
\enumerate{
\item speed up the process required to create an R package and
\item standardize the settings of R packages used in production.
}
}
\examples{
\dontrun{
assemble_package(.name = "validator",
.path = file.path("C:", "Users", "zmsmith.000",
 "OneDrive - New York State Office of Information Technology Services",
 "projects"),
.your_name = "Zachary M. Smith",
.private_repo = FALSE)
}
}
