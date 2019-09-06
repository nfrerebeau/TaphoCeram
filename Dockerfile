# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/verse:3.6.0

# required
MAINTAINER Nicolas Frerebeau <nicolas.frerebeau@u-bordeaux-montaigne.fr>

COPY . /archeosciences2019

# go into the repo directory
RUN . /etc/environment \

  # Install linux depedendencies here
  && sudo apt-get update \

  # build this compendium package
  && R -e "devtools::install('/archeosciences2019', dep=TRUE)" \

  # make project directory writable to save images and other output
  && sudo chmod a+rwx -R archeosciences2019 \

  # render the manuscript into a html document
  && R -e "rmarkdown::render('/archeosciences2019/analysis/paper/paper.Rmd')" \
