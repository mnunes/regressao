library(shiny)
library(ggplot2)
library(dplyr)
library(knitr)
library(kableExtra)

source("tabela_regressao.R")

minimo <- -5
maximo <- 5
passo  <- 0.1

x <- seq(from=minimo, to=maximo, by=passo)
y <- seq(from=minimo, to=maximo, by=passo)

data <- expand.grid(x, y)

names(data) <- c("x", "y")


