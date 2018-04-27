library(shiny)
library(ggplot2)
library(dplyr)

x <- seq(from=-5, to=5, by=0.15)
y <- seq(from=-5, to=5, by=0.15)

data <- expand.grid(x, y)

names(data) <- c("x", "y")

