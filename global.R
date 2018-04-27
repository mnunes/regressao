library(shiny)
library(ggplot2)
library(dplyr)
library(knitr)
library(ggfortify)
library(kableExtra)

# funcao para formatar os resultados da regressao
source("tabela_regressao.R")


# limites para o grafico e construcao do conjunto de dados
minimo <- -5
maximo <- 5
passo  <- 0.1

x <- seq(from=minimo, to=maximo, by=passo)
y <- seq(from=minimo, to=maximo, by=passo)

data <- expand.grid(x, y)

names(data) <- c("x", "y")


