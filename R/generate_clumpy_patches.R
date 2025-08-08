#' Simulate a Clumpy Spatial Distribution of Patches
#'
#' This function generates a synthetic landscape with habitat patches
#' arranged in spatial clumps within a square area.
#'
#' @param n.patches Integer. Total number of patches to generate.
#' @param extent Numeric. The width/height of the square landscape (in coordinate units).
#' @param clump.length Numeric. The average spatial extent (size) of each clump.
#' @param n.foci Optional integer or matrix. Number of clump centers.
#'   If a matrix, it should contain explicit coordinates (columns `x`, `y`).
#' @param clump.size Optional numeric. The expected number of patches per clump.
#'
#' @return A list with two numeric vectors:
#' \describe{
#'   \item{x}{x-coordinates of patches}
#'   \item{y}{y-coordinates of patches}
#' }
#' @importFrom stats rbinom runif rmultinom
#'
#' @examples
#' landscape <- generate_clumpy_patches(n.patches = 100, extent = 100,
#'                                      clump.length = 5, clump.size = 10)
#' plot(landscape$x, landscape$y, pch = 16)
#'
#' @export
generate_clumpy_patches <- function(n.patches, extent, clump.length,
         n.foci = NULL, clump.size = NULL){
  # Generates a random clumpy 2D landscape, in a extent*extent square
  # clump.size:  mean number of patches per clump.  Landscape is  uncorrelated if this -> 0
  # clump.length: mean spatial size of clumps

  if (is.null(n.foci)){
    # Number of foci for the clumps is a random number, no bigger than n.patches, with mean n.patches/clump.size
    n.foci <- rbinom(1, size = n.patches, prob = 1 / clump.size)

    if(n.foci == 0) n.foci <- 1 # cannot be < 1

    clump.foci.x <- extent * runif(n.foci)
    clump.foci.y <- extent * runif(n.foci)
  }
  else if (is.matrix(n.foci)){
    clump.foci.x <- n.foci[,1]
    clump.foci.y <- n.foci[,2]
  }
  else {
    clump.foci.x <- extent * runif(n.foci)
    clump.foci.y <- extent * runif(n.foci)
  }

  # Use multinomial generator to generate the number of patches per clump, to ensure that
  # the total is n.patches
  clump.n.patches<- c(rmultinom(1, n.patches, prob = rep(1 / n.foci, n.foci))) # c() converts it from matrix to vector

  x<- c()
  y<- c()
  for (j in 1:n.foci){
    # Each patch in the focus is positioned at an exponentially distributed distance from the
    # focus, in a random direction

    r<- rexp(clump.n.patches[j], 1 / clump.length) # distance from focus
    theta<- 2 * pi * runif(clump.n.patches[j]) # direction from focus
    xx<- r * cos(theta) + clump.foci.x[j]
    yy<- r * sin(theta) + clump.foci.y[j]
    x<- c(x, xx)
    y<- c(y, yy)
  }

  # We now impose periodic boundary conditions, to ensure all patches are in the
  # extent x extent square
  x<- x %% extent
  y <- y %% extent

  return(list(x = x, y = y))

}
