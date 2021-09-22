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
    
    if (sum(vals$keeprows) >= 2){
    ggplot(keep, aes(x=x, y=y)) + 
      geom_point(colour = "#568DBA") +
      geom_smooth(method = lm, se = FALSE, color = "#3DAF85") +
      geom_point(data = exclude, fill = NA, color = "#568DBA", alpha = 0.00) +
      coord_cartesian(xlim = 0.8*c(minimo, maximo), ylim = 0.8*c(minimo, maximo)) +
      labs(x="X", y="Y", title=paste("Y = ", sprintf("%0.4f", coefficients(model())[1]), sprintf("%+0.4f", coefficients(model())[2]), "*X", ", R^2 = ", round(summary(model())$r.squared, digits=4), sep=""))
    } else {
      ggplot(keep, aes(x=x, y=y)) + 
        geom_point(colour = "#568DBA") +
        geom_smooth(method = lm, se = FALSE, colour = "#3DAF85") +
        geom_point(data = exclude, fill = NA, colour = "#568DBA", alpha = 0.00) +
        coord_cartesian(xlim = 0.8*c(minimo, maximo), ylim = 0.8*c(minimo, maximo)) +
        labs(x="X", y="Y", title="Adicione mais pontos ao gráfico")
      }

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
    }
  })
  
  # cria a tabela com os resultados da anova da regressao
  output$anova <- renderPrint({
    if (sum(vals$keeprows) >= 2){
      tabela_anova(model())
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
      check_model(model(), check = c("linearity", "qq", "homogeneity", "outliers"))
    } else {
      mensagem <- data.frame(x=0, y=0)
      ggplot(mensagem, aes(x=x, y=y, label="Mais pontos são necessários")) +
        geom_text(size = 10, colour = "#568DBA") +
        coord_cartesian(xlim = 0.8*c(minimo, maximo), ylim = 0.8*c(minimo, maximo))
        
    }
  })
  
  # cria a tabela com os resultados da anova da regressao
  output$dados <- renderPrint({
    if (sum(vals$keeprows) >= 1){
      tabela_dados(data[ vals$keeprows, , drop = FALSE])
    }
    }
  )
  
}
