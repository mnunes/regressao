tabela_regressao <- function(ajuste){

  lm_traducao <- function(ajuste){
    traducao <- summary(ajuste)$coefficients
    colnames(traducao) <- c("Estimativa", "Erro Padrão", "t", "p-valor")
    rownames(traducao) <- c("Intercepto", "Coef Angular")
    return(traducao)
  }

  tabela <- kable(lm_traducao(ajuste), 
                  format="html", 
                  booktabs=TRUE,
                  digits=4)
  
  return(tabela)
}
