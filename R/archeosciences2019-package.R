#' @details
#' \tabular{ll}{
#'  \strong{Package:} \tab archeosciences2019 \cr
#'  \strong{Type:} \tab Compendium \cr
#'  \strong{Version:} \tab 1.1 \cr
#'  \strong{License:} \tab GPL-3 \cr
#'  \strong{DOI:} \tab \href{https://doi.org/10.5281/zenodo.2613512}{10.5281/zenodo.2613512}
#' }
#' @author
#' \strong{Full list of authors and contributors} (alphabetic order)
#'
#' \tabular{ll}{
#'  Nicolas Frerebeau \tab \emph{UMR 5060 IRAMAT-CRP2A, Université Bordeaux Montaigne, France} \cr
#'  Ayed Ben Amara \tab \emph{UMR 5060 IRAMAT-CRP2A, Université Bordeaux Montaigne, France} \cr
#'  Nadia Cantin \tab \emph{UMR 5060 IRAMAT-CRP2A, Université Bordeaux Montaigne, France}
#' }
#'
#' \strong{Corresponding author}
#'
#' Nicolas Frerebeau\cr
#' \email{nicolas.frerebeau@@u-bordeaux-montaigne.fr}
#'
#' UMR 5060 IRAMAT-CRP2A\cr
#' Maison de l'Archéologie\cr
#' Universite Bordeaux Montaigne\cr
#' 33607 Pessac cedex, France
#' @note
#' This work received a state financial support managed by the Agence Nationale
#' de la Recherche (France) throught the program \emph{Investissements d'avenir}
#' (ref. ANR-10-LABX-52).
#' @name archeoscience2019-package
#' @aliases archeoscience2019-package archeoscience2019
#' @docType package
#' @keywords internal
"_PACKAGE"
NULL

#' @importFrom magrittr %<>%
#' @importFrom magrittr %>%
NULL

# Quiets concerns of R CMD check: the .'s that appear in pipelines
# See https://github.com/tidyverse/magrittr/issues/29
if(getRversion() >= "2.15.1") utils::globalVariables(c("."))
