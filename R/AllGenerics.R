#' @include archeosciences2019-package.R
NULL

#' Get individuals coordinates
#'
#' Get coordinates and format the data frame for 'ggplot2'.
#' @param x An object of class \code{\link[FactoMineR]{PCA}} or
#'  \code{\link[FactoMineR]{CA}}.
#' @param axes A length-two \code{\link{numeric}} vector specifying the
#'  components to plot.
#' @param ind_sup A \code{\link{logical}} scalar: should the supplementary
#'  individuals be included?
#' @param select = NULL
#' @param group = NULL
#' @param ... Currently not used.
#' @return A \code{\link{data.frame}}.
#' @author N. Frerebeau
#' @keywords internal
#' @noRd
getIndividuals <- function(x, ...) UseMethod("getIndividuals")

#' Get variables coordinates
#'
#' Get coordinates and format the data frame for 'ggplot2'.
#' @param x An object of class \code{\link[FactoMineR]{PCA}} or
#'  \code{\link[FactoMineR]{CA}}.
#' @param axes A length-two \code{\link{numeric}} vector specifying the
#'  components to plot.
#' @param var_sup A \code{\link{logical}} scalar: should the supplementary
#'  columns be included?
#' @param quanti_sup A \code{\link{logical}} scalar: should the quantitative
#'  supplementary variables be included?
#' @param quali_sup A \code{\link{logical}} scalar: should the categorical
#'  supplementary variables be included?
#' @param select = NULL
#' @param ... Currently not used.
#' @return A \code{\link{data.frame}}.
#' @author N. Frerebeau
#' @keywords internal
#' @noRd
getVariables <- function(x, ...) UseMethod("getVariables")

#' Individuals factor map
#'
#' Plot individuals factor map with 'ggplot2'.
#' @inheritParams getIndividuals
#' @return A \code{\link{ggplot}} object.
#' @author N. Frerebeau
#' @keywords internal
#' @noRd
plotIndividuals <- function(x, ...) UseMethod("plotIndividuals")

#' Variables factor map
#'
#' Plot variables factor map with 'ggplot2'.
#' @inheritParams getIndividuals
#' @return A \code{\link{ggplot}} object.
#' @author N. Frerebeau
#' @keywords internal
#' @noRd
plotVariables <- function(x, ...) UseMethod("plotVariables")

#' Eigenvalues and cumulative variance
#'
#' Plot eigenvalues histogram with 'ggplot2'.
#' @param x An object of class \code{\link[FactoMineR]{PCA}} or
#'  \code{\link[FactoMineR]{CA}}.
#' @param variance A \code{\link{logical}} scalar: should the cumulative
#'  percentage of variance be displayed?
#' @return A \code{\link{ggplot}} object.
#' @author N. Frerebeau
#' @keywords internal
#' @noRd
plotEigenvalues <- function(x, ...) UseMethod("plotEigenvalues")

#' Explained variance
#'
#' Return the percentage of explained variance for a given axis.
#' @param x An object of class \code{\link[FactoMineR]{PCA}} or
#'  \code{\link[FactoMineR]{CA}}.
#' @param axis A length-one \code{\link{numeric}} vector specifying the
#'  component to use.
#' @return A \code{\link{character}} vector.
#' @author N. Frerebeau
#' @keywords internal
#' @noRd
printComponentVar <- function(x, ...) UseMethod("printComponentVar")

#' Row selection
#'
#' Select rows according to a specific criterion.
#' @param x An object of class \code{\link[FactoMineR]{PCA}} or
#'  \code{\link[FactoMineR]{CA}}.
#' @param criterion A \code{\link{character}} string specifying the rows that
#'  are selected.
#' @param axes A length-two \code{\link{numeric}} vector specifying the
#'  components to plot.
#' @param map A \code{\link{character}} string specifying which data to select
#'  from.
#'  This must be one of "\code{ind}", "\code{ind.sup}", "\code{var}",
#'  "\code{row}", "\code{row.sup}", "\code{col}", "\code{col.sup}",
#'  "\code{quanti.sup}", "\code{quali.sup}".
#' @return A \code{\link{numeric}} vector.
#' @author N. Frerebeau
#' @keywords internal
#' @noRd
selectRows <- function(x, ...) UseMethod("selectRows")

#' Plot PCA results
#'
#' Visualize multivariate exploratory data analysis results.
#' @param x An object of class \code{\link[FactoMineR]{PCA}} or
#'  \code{\link[FactoMineR]{CA}}.
#' @param axes A length-two \code{\link{numeric}} vector specifying the
#'  components to plot.
#' @param map A \code{\link{character}} string or vector of strings specifying
#'  the graph to plot (see below). Any unambiguous substring can be given.
#' @param extra A string or vector of \code{\link{character}} strings
#'  specifiying the supplementary data to plot (see below).
#'  Any unambiguous substring can be given.
#'  If \code{NULL} (default) no extra information is plotted.
#' @param select A \code{\link{numeric}} or \code{\link{character}} vector
#'  specifying a part of the elements that are drawn (see details in
#'  \code{\link[FactoMineR]{PCA}} and \code{\link[FactoMineR]{CA}}).
#'  If \code{NULL} (default) no selection is made.
#' @param group A \code{\link{character}} vector of categories or a length-one
#'  \code{\link{numeric}} vector specifiying the supplementary categorial
#'  variable from which to color the individuals.
#'  The elements are coerced to characters by \code{\link{as.character}}.
#' @param ... Further arguments passed to other methods.
#' @section PCA:
#'  \code{map} should be one of the following:
#'  \describe{
#'   \item{individuals}{Plots individuals factor map along the specified
#'    \code{axes}.}
#'   \item{variables}{Plots variables factor map along the specified
#'    \code{axes}.}
#'   \item{eigenvalues}{Plots eigenvalues and the cumulative percentage of
#'    variance.}
#'  }
#'  \code{extra} should be one or more of the following:
#'  \describe{
#'   \item{individuals}{Add supplementary individuals.}
#'   \item{qualitative}{Add supplementary categories.}
#'   \item{quantitative}{Add supplementary continuous variables.}
#'  }
#' @section CA:
#'  \code{map} should be one or more of the following:
#'  \describe{
#'   \item{rows}{Plots rows along the specified \code{axes}.}
#'   \item{columns}{Plots columns along the specified \code{axes}.}
#'  }
#'  \code{extra} should be one or more of the following:
#'  \describe{
#'   \item{rows}{Add supplementary rows.}
#'   \item{columns}{Add supplementary columns.}
#'   \item{qualitative}{Add supplementary categories.}
#'   \item{quantitative}{Add supplementary continuous variables.}
#'  }
#' @seealso \link[FactoMineR]{PCA}, \link[FactoMineR]{CA}
#' @author N. Frerebeau
#' @export
#' @name visualize
#' @rdname visualize
visualize <- function(x, ...) UseMethod("visualize")
