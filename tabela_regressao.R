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
                  digits=4,
                  padding=10)
  
  tabela <- column_spec(tabela, 1:5, width="10em", bold=FALSE, italic=FALSE)
  tabela <- column_spec(tabela, 1, bold=TRUE, italic=FALSE)
  
  return(tabela)
}
