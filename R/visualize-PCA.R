#' @include AllGenerics.R
NULL

# Visualize PCA results ========================================================
#' @export
#' @rdname visualize
visualize.PCA <- function(x, axes = c(1, 2),
                          map = c("individuals", "variables", "eigenvalues"),
                          extra = NULL, select = NULL, group = NULL, ...) {
  # Validation
  map <- match.arg(map, several.ok = FALSE)
  if(!is.null(extra)) {
    extra <- match.arg(
      arg = extra,
      choices = c("individuals", "quantitative", "qualitative"),
      several.ok = TRUE)
  } else {
    extra <- FALSE
  }

  ind_sup <- (map == "individuals" & "individuals" %in% extra &
                length(x$ind.sup) != 0)
  quanti_sup <- (map == "variables" & "quantitative" %in% extra &
                   length(x$quanti.sup) != 0)
  quali_sup <- (map == "variables" & "qualitative" %in% extra &
                  length(x$quali.sup) != 0)

  graph <- switch(
    map,
    individuals = plotIndividuals(x, axes = axes, ind_sup = ind_sup,
                                  select = select, group = group),
    variables = plotVariables(x, axes = axes, quanti_sup = quanti_sup,
                              quali_sup = quali_sup, select = select),
    eigenvalues = plotEigenvalues(x)
  )
  return(graph)
}

printComponentVar.PCA <- function(x, axis = 1) {
  variance <- round(x$eig[axis, 2], 1)
  paste("PC", axis, " (", variance, "%)", sep = "")
}

# Row selection ================================================================
selectRows.PCA <- function(x, criterion, axes = c(1, 2),
                           map = c("ind", "ind.sup", "var", "quanti.sup")) {
  map <- match.arg(map, several.ok = FALSE)
  data <- x[[map]]
  n <- nrow(data$coord)

  if (is.numeric(criterion)) {
    index <- criterion
  } else {
    index <- which(rownames(data$coord) %in% criterion)

    if (length(index) == 0) {
      index <- 1:n

      if(length(criterion) == 1) {
        pattern <- "(coord|contrib|cos2|dist)"
        if (!grepl(pattern, criterion)) {
          stop(paste("Your selection criterion (", dQuote(criterion),
                     ") is invalid.", sep = ""))
        }
        k <- sum(as.numeric(unlist(strsplit(criterion, pattern))), na.rm = TRUE)
        if (grepl("coord", criterion)) {
          coord <- apply(data$coord[, axes]^2, 1, sum)
          index <- rev(order(coord))[1:min(n, k)]
        }
        if (grepl("contrib", criterion)) {
          contrib <- data$contrib[, axes[1], drop = FALSE] * x$eig[axes[1], 1] +
            data$contrib[, axes[2], drop = FALSE] * x$eig[axes[2], 1]
          index <- rev(order(contrib))[1:min(n, k)]
        }
        if (grepl("cos2", criterion)) {
          cos2 <- apply(data$cos2[, axes], 1, sum)
          if (k >= 1) {
            index <- rev(order(cos2))[1:min(n, k)]
          } else {
            index <- which(cos2 > k)
          }
        }
        if (grepl("dist", criterion)) {
          index <- rev(order(data$dist))[1:min(n, k)]
        }
      }
    }
  }

  return(index)
}

# Individuals factor map =======================================================
getIndividuals.PCA <- function(x, axes = c(1, 2), ind_sup = FALSE,
                               select = NULL, group = NULL) {
  # Get individual coordinates
  ind_coords <- as.data.frame(x$ind$coord)
  ind_index <- NULL
  if (!is.null(select)) {
    ind_index <- selectRows(x, select, axes, map = "ind")
    ind_coords <- ind_coords[ind_index, ]
  }
  # Get row names
  ind_names <- rownames(ind_coords)
  ind_rows <- nrow(ind_coords)

  sup_coords <- sup_names <- NULL
  sup_rows <- 0
  if (ind_sup) {
    # Get supplementary individual coordinates
    sup_coords <- as.data.frame(x$ind.sup$coord)
    if (!is.null(select)) {
      sup_index <- selectRows(x, select, axes, map = "ind.sup")
      sup_coords <- sup_coords[sup_index, ]
    }
    # Get row names
    sup_names <- rownames(sup_coords)
    sup_rows <- nrow(sup_coords)
  }

  levels <- c("Ind.", "Ind. sup.")
  extra <- rep(levels, times = c(ind_rows, sup_rows))
  if (!is.null(group)) {
    k <- length(group)
    if (k != 1 & k != ind_rows + sup_rows) {
      stop(paste("Argument", sQuote(group), "must be length",
                 ind_rows + sup_rows, "or one, not", k))
    }
    if (k == 1) {
      group <- x$call$X[, group]
    }
    group <- as.character(group)[1:max(ind_rows, ind_rows + sup_rows)]
    extra[1:length(group)] <- group
  }

  data <- dplyr::bind_rows(ind_coords, sup_coords) %>%
    dplyr::select(axes) %>%
    dplyr::rename(x = 1, y = 2) %>%
    dplyr::mutate(label = c(ind_names, sup_names),
                  legend = extra)
  return(data)
}
plotIndividuals.PCA <- function(x, axes = c(1, 2), ind_sup = FALSE,
                                select = NULL, group = NULL) {
  # Get data coordinates
  data <- getIndividuals(x = x, axes = axes, ind_sup = ind_sup,
                         select = select, group = group)

  # ggplot2
  graph <- ggplot2::ggplot(
    data = data,
    ggplot2::aes_string(x = "x", y = "y", label = "label", color = "legend")
  ) +
    ggplot2::geom_point() +
    ggplot2::geom_vline(xintercept = 0, size = 0.5, linetype = "dashed") +
    ggplot2::geom_hline(yintercept = 0, size = 0.5, linetype = "dashed") +
    ggplot2::labs(x = printComponentVar(x, axes[1]),
                  y = printComponentVar(x, axes[2]))
  return(graph)
}

# Variables factor map =========================================================
getVariables.PCA <- function(x, axes = c(1, 2), quanti_sup = FALSE,
                             quali_sup = FALSE, select = NULL) {
  # Get variables coordinates
  var_coords <- as.data.frame(x$var$coord)
  var_index <- NULL
  if (!is.null(select)) {
    var_index <- selectRows(x, select, axes, map = "var")
    var_coords <- var_coords[var_index, ]
  }
  # Get row names
  var_names <- rownames(var_coords)

  quanti_coords <- quanti_names <- NULL
  quali_coords <- quali_names <- NULL
  extra <- rep("Var.", nrow(var_coords))
  if (quanti_sup) {
    # Get quantitative supplementary variable coordinates
    quanti_coords <- as.data.frame(x$quanti.sup$coord)
    # Get row names
    quanti_names <- rownames(quanti_coords)
    extra <- c(extra, rep("Quanti. sup.", nrow(quanti_coords)))
  }
  if (quali_sup) {
    # Get categorical supplementary variable coordinates
    quali_coords <- as.data.frame(x$quali.sup$coord)
    # Get row names
    quali_names <- rownames(quali_coords)
    extra <- c(extra, rep("Quali. sup.", nrow(quali_coords)))
  }

  # Bind coordinates
  data <- dplyr::bind_rows(var_coords, quanti_coords, quali_coords) %>%
    dplyr::select(axes) %>%
    dplyr::rename(x = 1, y = 2) %>%
    dplyr::mutate(label = unlist(list(var_names, quanti_names, quali_names)),
                  zero = rep(0, nrow(.)),
                  legend = extra)
  return(data)
}
plotVariables.PCA <- function(x, axes = c(1, 2), quanti_sup = FALSE,
                              quali_sup = FALSE, select = NULL) {
  # Get data coordinates
  data <- getVariables(x = x, axes = axes, quanti_sup = quanti_sup,
                       quali_sup = quali_sup, select = select)
  # ggplot2
  gg_unit <- gg_circle <- NULL
  if(x$call$scale.unit) {
    gg_unit <- ggplot2::coord_fixed()
    gg_circle <- ggplot2::geom_path(
      data = cbind.data.frame(
        x = 1 * cos(seq(0, 2 * pi, length = 200)),
        y = 1 * sin(seq(0, 2 * pi, length = 200))),
      ggplot2::aes_string(x = "x", y = "y"), size = 0.5, inherit.aes = FALSE)
  }

  graph <- ggplot2::ggplot(
    data = data, ggplot2::aes_string(x = "x", y = "y",
                                     label = "label", colour = "legend")) +
    ggplot2::geom_vline(xintercept = 0, size = 0.5, linetype = "dashed") +
    ggplot2::geom_hline(yintercept = 0, size = 0.5, linetype = "dashed") +
    gg_unit + gg_circle +
    ggplot2::geom_segment(
      ggplot2::aes_string(x = "zero", xend = "x", y = "zero", yend = "y"),
      arrow = ggplot2::arrow(length = ggplot2::unit(0.2, "cm")),
      size = 0.5) +
    ggplot2::labs(x = printComponentVar(x, axes[1]),
                  y = printComponentVar(x, axes[2]))
  return(graph)
}

# Eigenvalues and cumulative variance ==========================================
plotEigenvalues.PCA <- function(x, variance = TRUE) {
  # Eigenvalues
  data <- as.data.frame(x$eig) %>%
    dplyr::mutate(PC = factor(1:nrow(.), levels = 1:nrow(.)))
  k <- max(data[, 1]) / max(data[, 3])

  if (variance) {
    gg_var <- list(
      ggplot2::geom_line(
        mapping = ggplot2::aes_string(
          y = "`cumulative percentage of variance` * k"
        ), group = 1
      ),
      ggplot2::geom_point(
        mapping = ggplot2::aes_string(
          y = "`cumulative percentage of variance` * k"
        )
      ),
      ggplot2::scale_y_continuous(
        sec.axis = ggplot2::sec_axis(
          ~ . / k, name = "Cumulative percentage of variance"
        )
      )
    )
  }

  graph <- ggplot2::ggplot(data = data,
                           mapping = ggplot2::aes_string(x = "PC")) +
    ggplot2::geom_col(mapping = ggplot2::aes_string(y = "eigenvalue")) +
    gg_var +
    ggplot2::labs(x = "PC", y = "Eigenvalue")
    ggplot2::scale_x_continuous(breaks = 1:nrow(data))

  return(graph)
}
