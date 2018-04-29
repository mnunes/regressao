# funcao para criar a tabela anova da regressao

tabela_anova <- function(ajuste){
  
  tabela_anova <- anova(ajuste)
  
  n.row  <- 3
  tabela <- as.data.frame(matrix(rep(NA, 6*n.row), nrow=n.row))
  
  
  # construcao da tabela
  colnames(tabela) <- c("Fonte de Variação", "gl", "SQ", "QM", "F", "Pr(>F)")
  rownames(tabela) <- NULL
  
  tabela[, 1] <- c("Regressão", "Resíduos", "Total")
  tabela[, 2] <- c(tabela_anova[, 1], sum(tabela_anova[, 1]))
  tabela[, 3] <- c(tabela_anova[, 2], sum(tabela_anova[, 2]))
  tabela[, 4] <- c(tabela_anova[, 3], sum(tabela_anova[, 2])/sum(tabela_anova[, 1]))
  tabela[, 5] <- c(tabela_anova[, 4][1], NA, NA)
  tabela[, 6] <- c(tabela_anova[, 5][1], NA, NA)
  
  # conversao da tabela para html
  tabela <- kable(tabela, 
                  format="html", 
                  booktabs=TRUE,
                  digits=4,
                  padding=10)
  
  tabela <- column_spec(tabela, 1:6, width="10em", bold=FALSE, italic=FALSE)
  tabela <- column_spec(tabela, 1, bold=TRUE, italic=FALSE)
  
  return(tabela)
}
