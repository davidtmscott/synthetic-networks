# inst/figures/make-readme-figures.R
library(syntheticnetworks)

# set seed 
set.seed(22)

# Uniform
uniform <- generate_uniform_patches(n.patches = 200, extent = 10)

# Visualise
png("man/figures/uniform.png", width = 600, height = 600)
plot(uniform$x, uniform$y, pch = 19, col = "blue",
     main = "Uniform patches", xlab = "x", ylab = "y")
dev.off()

# Clumpy
clumpy <- generate_clumpy_patches(n.patches = 1000, extent = 10, 
                                  clump.length = 1, n.foci = 10)

png("man/figures/clumpy.png", width = 600, height = 600)
plot(clumpy$x, clumpy$y, pch = 19, col = "darkgreen",
     main = "Clumpy patches", xlab = "x", ylab = "y")
dev.off()

# Stringy
stringy <- generate_stringy_patches(n.patches = 500, extent = 10,
                                    n.foci = 6, l.noise = 0.1)

png("man/figures/stringy.png", width = 600, height = 600)
plot(stringy$x, stringy$y, pch = 19, col = "red",
     main = "Stringy patches", xlab = "x", ylab = "y")
dev.off()

# Lacy
lacy <- generate_lacy_patches(
  n.patches = 2000, extent = 10,
  n.foci = 6, l.smooth = 0.1, n.trials = 10000)

png("man/figures/lacy.png", width = 600, height = 600)
plot(lacy$x, lacy$y, pch = 19, col = "purple",
     main = "Lacy patches", xlab = "x", ylab = "y")
dev.off()
