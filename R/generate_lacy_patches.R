
generate_lacy_patches <- function(n.patches, extent, n.foci, l.smooth, n.trials){
  # Generates a random corridorey 2D landscape, in a extent*extent square
  # Favours patches along the zero contour of a random (symmetric about zero) smooth landscape.
  # Creates a surplus of such patches, then returns the most highly ranked
  # n.foci: number of foci that the patches avoid.  Uncorrelated if this -> infinity
  # l.smooth: spatial scale for the smoothing kernel.  Uncorrelated if this -> infinity or zero
  # n.trials: number of trial patches (generated at random)


  # could set where you want foci to be

  x.foci <- extent*runif(n.foci)
  y.foci <- extent*runif(n.foci)

  # half of foci are "positive", half negatve
  sign.foci <- rep(c(1, -1), c(n.foci/2, n.foci - n.foci/2))

  x.trial<- extent*runif(n.trials)
  y.trial<- extent*runif(n.trials)

  score<- rep(0, n.trials)

  for (i in 1:n.trials){
    #i=1
    rr<- sqrt((x.trial[i]-x.foci)^2 + (y.trial[i]-y.foci)^2)
    score[i]<- (sum(sign.foci * exp(-rr / l.smooth) / l.smooth^2))^2
  }

  sorted <- sort(score, index.return=T)

  returned <- sorted$ix[1:n.patches]

  return(list(x=x.trial[returned], y=y.trial[returned]))
}
