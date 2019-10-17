# Install packages to a docker image with packrat

# Initialize packrat ===========================================================
## Install packrat
utils::install.packages("packrat", repos = "https://cran.rstudio.com/")

## Initialize packrat, but don't let it try to find packages to install itself
packrat::init(
  infer.dependencies = FALSE,
  enter = TRUE,
  restart = FALSE
)

# Setup repository =============================================================
## Specify repositories so they get included in packrat.lock file
my_repos["CRAN"] <- "https://cloud.r-project.org/"
options(repos = my_repos)

# Install packages =============================================================
## All packages will be installed to the project-specific packrat library
## Install CRAN packages
cran_packages <- c(
  "akima",
  "bookdown",
  "compositions",
  "cowplot",
  "dplyr",
  "FactoMineR",
  "ggdendro",
  "ggplot2",
  "ggrepel",
  "ggtern",
  "kableExtra",
  "khroma",
  "knitr",
  "magrittr",
  "MASS",
  "rmarkdown",
  "robCompositions",
  "roxygen2",
  "tidyr",
  "usethis"
)
utils::install.packages(cran_packages)

## Install github packages
# github_packages <- c("benmarwick/rrtools")
# remotes::install_github(github_packages)

# Take snapshot ================================================================
packrat::snapshot(
  ignore.stale = TRUE,
  snapshot.sources = TRUE,
  infer.dependencies = FALSE
)
