
generate_transition_matrix <- function(landscape, dispersal, R, total.patches, extent){

  # get distances between each point
  distances = dist(landscape, diag = T, upper = T)

  # set up negative exponential dispersal kernel
  #dispersal <- 2
  #cellside <- 1
  #R <- 100

  lambda <- 2 / dispersal # was x / 2
  #norm <- R * lambda ^ 2 / 2 / pi * cellside ^ 4
  #k <- extent^2 * lambda^2 / (2 * pi * total.patches) # my old one

  # calculate transition rates based on distance calculated
  #W <- norm * exp(-lambda * distances)
  #W <- R * k * exp(-lambda * distances) # my old one
  W <- R * (lambda^2) * exp(-lambda * distances)
  return(as.matrix(W))
}
