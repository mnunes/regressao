library(shiny)
library(shinythemes)
library(ggplot2)
theme_set(see::theme_lucid())
library(dplyr)
library(knitr)
options(knitr.kable.NA = "")
library(performance)
library(kableExtra)

# funcoes para formatar os resultados da regressao
source("tabela_regressao.R")
source("tabela_anova.R")
source("tabela_dados.R")

# limites para o grafico e construcao do conjunto de dados
minimo <- -5
maximo <- 5
passo  <- 0.1

x <- seq(from=minimo, to=maximo, by=passo)
y <- seq(from=minimo, to=maximo, by=passo)

data <- expand.grid(x, y)

names(data) <- c("x", "y")


