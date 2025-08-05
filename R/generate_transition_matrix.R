#' Generate Transition Matrix from Patch Landscape
#'
#' Computes a matrix of transition rates between habitat patches based on their pairwise distances.
#' The rates are calculated using a negative exponential dispersal kernel, scaled by a global rate constant.
#'
#' @param landscape A data frame or matrix with two columns (`x`, `y`) representing patch coordinates.
#' @param dispersal Numeric. Mean dispersal distance; controls the steepness of the dispersal kernel.
#' @param R Numeric. A global rate parameter that scales all transition values.
#'
#' @return A square numeric matrix where element \code{[i, j]} represents the transition rate from patch \code{i} to \code{j}.
#'
#' @details The transition rate between patches \code{i} and \code{j} is computed as:
#' \deqn{R \cdot \lambda^2 \cdot \exp(-\lambda \cdot d_{ij})}
#' where \code{d_{ij}} is the Euclidean distance between patches and \code{λ = 2 / dispersal}.
#'
#' @examples
#' landscape <- data.frame(x = runif(10, 0, 10), y = runif(10, 0, 10))
#' generate_transition_matrix(landscape, dispersal = 2, R = 0.5)
#'
#' @export
generate_transition_matrix <- function(landscape, dispersal, R){

  # get distances between each point
  distances = dist(landscape, diag = T, upper = T)

  lambda <- 2 / dispersal

  # calculate transition rates based on distance calculated
  W <- R * (lambda^2) * exp(-lambda * distances)
  return(as.matrix(W))
}
