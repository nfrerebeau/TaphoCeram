#' Corpus étudié
#'
#' Résultats des analyses WDXRF du corpus de céramiques et de tessons non cuits
#' provenant de l'atelier du Mas de Moreno (Foz-Calanda, Teruel, Espagne).
#' @format Un \code{\link[=data.frame]{tableau de données}} de 114 lignes
#'  (échantillons) et 30 colonnes (variables) :
#'  \describe{
#'    \item{sample}{Référence de l'échantillon.}
#'    \item{date}{Date de l'analyse.}
#'    \item{laboratory}{Laboratoire d'analyse.}
#'    \item{stratigraphy}{Unité stratigraphique.}
#'    \item{artefact}{Eléménts de typologie.}
#'    \item{part}{Portion analysée.}
#'    \item{decoration}{Présence d'un décor peint ?}
#'    \item{LOI}{Perte-au-feu (pourcents).}
#'    \item{CaO, Fe2O3, TiO2 , K2O, SiO2 , Al2O3 , MgO, MnO, P2O5,
#'    Zr, Sr, Rb, Zn, Cr, Ni, La, Ba, V, Ce, Y, Cu}{Teneurs (pourcents).}
#'  }
#' @source
#'  Frerebeau, N. and Sacilotto, C. (2017). On Some Iberian Unfired
#'  Pottery Sherds from the Late Iron Age (Second Century BC).
#'  In Gorgues, A., Rebay-Salisbury, K. and Salisbury, R. B. (eds.),
#'  \emph{Material Chains in Late Prehistoric Europe and the Mediterranean -
#'  Time, Space and Technologies of Production}. Bordeaux: Ausonius Éditions,
#'  p. 157-169. Mémoires, 48.
#'
#'  Frerebeau, N. (2015). WDXRF Analysis of Iberian Unfired Potsherds from
#'  the Late Iron Age [Data set]. \emph{Zenodo}.
#'  DOI : \href{https://doi.org/10.5281/zenodo.1414297}{10.5281/zenodo.1414297}.
#' @examples
#' # Extrait des premières lignes
#' head(corpus)
#'
#' # Résumé des données
#' summary(corpus)
#' @keywords datasets
#' @family datasets
"corpus"

#' Résumé de l'échantillonnage par unité stratigraphique.
#' @format Un \code{\link[=data.frame]{tableau de données}} de 9 lignes
#'  (contextes) et 7 colonnes (variables) :
#'  \describe{
#'    \item{materiau}{Nature du matériau.}
#'    \item{ensemble}{Ensemble chronologie.}
#'    \item{chronologie}{Chronologie calendaire.}
#'    \item{US}{Unité stratigraphique.}
#'    \item{NR}{Nombre de restes.}
#'    \item{NMI}{Nombre minimum d'individus.}
#'    \item{N}{Effectif de l'échantillonnage.}
#'  }
#'  Les cellules marquée d'une asterisque sont en cours d'étude.
#' @source
#'  Frerebeau, N. and Sacilotto, C. (2017). On Some Iberian Unfired
#'  Pottery Sherds from the Late Iron Age (Second Century BC).
#'  In Gorgues, A., Rebay-Salisbury, K. and Salisbury, R. B. (eds.),
#'  \emph{Material Chains in Late Prehistoric Europe and the Mediterranean -
#'  Time, Space and Technologies of Production}. Bordeaux: Ausonius Éditions,
#'  p. 157-169. Mémoires, 48.
#'
#'  Sacilotto, C., 2011. \emph{De l'argile à la terre cuite, le traitement des
#'  productions sur un atelier de poteries ibériques à la fin de l'Age du Fer.
#'  Étude de l'atelier de potiers du Mas de Moreno (Foz-Calanda, Teruel,
#'  Espagne) des IIe et Ier siècles a.C.} Mémoire de master, Université Bordeaux
#'  3 Michel de Montaigne, Pessac.
#' @keywords datasets
#' @family datasets
"nmi"
