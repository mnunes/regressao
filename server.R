function(input, output) {
  
  # For storing which rows have been excluded
  vals <- reactiveValues(
    keeprows = rep(FALSE, nrow(data))
  )
  
  output$plot1 <- renderPlot({
    # Plot the kept and excluded points as two separate data sets
    keep    <- data[ vals$keeprows, , drop = FALSE]
    exclude <- data[!vals$keeprows, , drop = FALSE]
    
    ggplot(keep, aes(x=x, y=y)) + 
      geom_point() +
      geom_smooth(method = lm, se = FALSE, color = "black") +
      geom_point(data = exclude, fill = NA, color = "black", alpha = 0.00) +
      coord_cartesian(xlim = 0.8*c(minimo, maximo), ylim = 0.8*c(minimo, maximo)) +
      #scale_x_continuous(breaks=seq(minimo, maximo, 1), minor_breaks=seq(minimo, maximo, passo)) +
      #scale_y_continuous(breaks=seq(minimo, maximo, 1), minor_breaks=seq(minimo, maximo, passo)) +
      theme_bw()

  })
  
  model <- reactive({
    keep    <- data[ vals$keeprows, , drop = FALSE]
    lm(y ~ x, data = keep)
  })
  
  output$model <- renderPrint({
    tabela_regressao(model())
  })
  
  # Toggle points that are clicked
  observeEvent(input$plot1_click, {
    res <- nearPoints(data, input$plot1_click, allRows = TRUE, maxpoints=1)
    
    vals$keeprows <- xor(vals$keeprows, res$selected_)
  })
  
  # Reset all points
  observeEvent(input$exclude_reset, {
    vals$keeprows <- rep(FALSE, nrow(data))
  })
  

  
}
