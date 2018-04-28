function(input, output) {
  
  # variavel que guarda os pontos excluídos e mantidos
  vals <- reactiveValues(
    keeprows = rep(FALSE, nrow(data))
  )
  
  output$plot1 <- renderPlot({
    
    # plota os pontos keep e exclude como dois data frames diferentes
    keep    <- data[ vals$keeprows, , drop = FALSE]
    exclude <- data[!vals$keeprows, , drop = FALSE]
    
    # grafico de dispersao e reta ajustada aos dados
    ggplot(keep, aes(x=x, y=y)) + 
      geom_point() +
      geom_smooth(method = lm, se = FALSE, color = "black") +
      geom_point(data = exclude, fill = NA, color = "black", alpha = 0.00) +
      coord_cartesian(xlim = 0.8*c(minimo, maximo), ylim = 0.8*c(minimo, maximo)) #+
      #scale_x_continuous(breaks=seq(minimo, maximo, 1), minor_breaks=seq(minimo, maximo, passo)) +
      #scale_y_continuous(breaks=seq(minimo, maximo, 1), minor_breaks=seq(minimo, maximo, passo))

  })
  
  # ajusta o modelo aos dados keep
  model <- reactive({
    keep           <- data[ vals$keeprows, , drop = FALSE]
    rownames(keep) <- 1:nrow(keep)
    lm(y ~ x, data = keep)
  })
  
  # cria a tabela com os resultados da regressao
  output$model <- renderPrint({
    if (sum(vals$keeprows) >= 2){
      tabela_regressao(model())
    } else {
      "Mais pontos são necessários"
    }
  })
  
  # muda os pontos clicados
  observeEvent(input$plot1_click, {
    res           <- nearPoints(data, input$plot1_click, allRows = TRUE, maxpoints=1)
    vals$keeprows <- xor(vals$keeprows, res$selected_)
  })
  
  # apaga todos os pontos
  observeEvent(input$exclude_reset, {
    vals$keeprows <- rep(FALSE, nrow(data))
  })
  
  # graficos de diagnostico
  output$plot2 <- renderPlot({
    
    # condicional para evitar um erro;
    # os graficos de diagnostico necessitam
    # de pelo menos 3 pontos para serem
    # criados
    if (sum(vals$keeprows) >= 3){
      autoplot(model())
    } else {
      mensagem <- data.frame(x=0, y=0)
      ggplot(mensagem, aes(x=x, y=y, label="Mais pontos são necessários")) +
        geom_text(size = 10) +
        coord_cartesian(xlim = 0.8*c(minimo, maximo), ylim = 0.8*c(minimo, maximo))
        
    }
  })
  
}
