tabela_dados <- function(dados){

  dados <- kable(dados,
                 format="html", 
                 booktabs=TRUE,
                 digits=1,
                 padding=10,
                 row.names = NULL)
  
  rownames(dados) <- NULL
  
  dados <- column_spec(dados, 1:2, width="10em", bold=FALSE, italic=FALSE)
  dados <- column_spec(dados, 1, bold=TRUE, italic=FALSE)
  
  return(dados)
}
