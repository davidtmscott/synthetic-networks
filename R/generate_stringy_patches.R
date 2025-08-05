
generate_stringy_patches <- function(n.patches, extent, n.foci, l.noise){
  # Places patches on the edges of a Delaunay triangulation of a set of
  # n.foci random points, with a bit of noise (determined by l.noise)

  x.foci <- c(extent*runif(n.foci - 2), 5, 5) # changed to n.foci - 2
  y.foci <- c(extent*runif(n.foci - 2), 0, 10)
  pp<- RTriangle::pslg(matrix(c(x.foci, y.foci), ncol=2, byrow=F))
  tt<- RTriangle::triangulate(pp, Y=T)

  # place each patch on a randomly chosen edge of the triangulation
  x<- rep(0, n.patches)
  y<- rep(0, n.patches)
  n.edge<- dim(tt$E)[1]
  for (i in 1:n.patches){
    j<- sample(1:n.edge, size=1)
    rr<- runif(1)
    v1<- tt$E[j, 1]
    v2<- tt$E[j, 2]

    x[i]<- rr * x.foci[v1] + (1-rr)*x.foci[v2]
    y[i]<- rr * y.foci[v1] + (1-rr)*y.foci[v2]
  }

  # Add some noise
  if (l.noise > 0){
    r.noise<- rexp(n.patches, 1/l.noise)
    theta.noise<- 2*pi*runif(n.patches)
    x.noise <- r.noise * cos(theta.noise)
    y.noise<- r.noise *sin(theta.noise)

    # Set noise to zero if it would take the patch out of the landscape
    x.temp<- x + x.noise
    x.noise [x.temp < 0 | x.temp > extent] <- 0
    x<- x + x.noise
    y.temp<- y + y.noise
    y.noise [y.temp < 0 | y.temp > extent]<- 0
    y <- y + y.noise

  }
  return(list(x=x, y=y))
}
