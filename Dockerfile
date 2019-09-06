# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/rstudio:3.6.0

# required
MAINTAINER Nicolas Frerebeau <nicolas.frerebeau@u-bordeaux-montaigne.fr>

COPY . /archeosciences2019

# go into the repo directory
RUN . /etc/environment \
  # Install linux depedendencies here
  && sudo apt-get update \
  && sudo apt-get install libudunits2-dev -y \
  # build this compendium package
  && install2.r packrat \
  && Rscript -e 'packrat::restore()' \
  && echo '.libPaths("/packrat/lib/x86_64-pc-linux-gnu/3.6.0")' >> /usr/local/lib/R/etc/Rprofile.site \
  #&& R -e "devtools::install('/archeosciences2019', dep=TRUE)" \
  # render the manuscript into a docx, you'll need to edit this if you've
  # customised the location and name of your main Rmd file
  && R -e "rmarkdown::render('/archeosciences2019/analysis/paper/paper.Rmd, analysis/paper/paper.Rmd')"
