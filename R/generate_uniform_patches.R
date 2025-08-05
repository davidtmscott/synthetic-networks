#' Generate Uniformly Distributed Patches
#'
#' Creates a spatially uniform distribution of habitat patches within a square landscape.
#'
#' @param n.patches Integer. The number of habitat patches to generate.
#' @param extent Numeric. The side length of the square landscape in which patches are placed.
#'
#' @return A list with numeric vectors \code{x} and \code{y}, representing the coordinates of each patch.
#'
#' @examples
#' patches <- generate_uniform_patches(n.patches = 100, extent = 10)
#'
#' @export
generate_uniform_patches <- function(n.patches, extent) {
  x <- runif(n.patches, 0, extent)
  y <- runif(n.patches, 0, extent)
  return(list(x = x, y = y))
}
