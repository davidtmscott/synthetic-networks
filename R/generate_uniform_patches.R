
generate_uniform_patches <- function(n.patches, extent){
  patches <- data.frame(x = runif(n.patches, 0, extent),
             y = runif(n.patches, 0, extent))
  return(patches)
}
