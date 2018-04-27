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
      geom_point(data = exclude, shape = 21, fill = NA, color = "black", alpha = 0.00) +
      coord_cartesian(xlim = c(-5, 5), ylim = c(-5, 5)) +
      theme_bw()
  })
  
  # Toggle points that are clicked
  observeEvent(input$plot1_click, {
    res <- nearPoints(data, input$plot1_click, allRows = TRUE)
    
    vals$keeprows <- xor(vals$keeprows, res$selected_)
  })
  
  # Toggle points that are brushed, when button is clicked
  observeEvent(input$exclude_toggle, {
    res <- brushedPoints(data, input$plot1_brush, allRows = TRUE)
    
    vals$keeprows <- xor(vals$keeprows, res$selected_)
  })
  
  # Reset all points
  observeEvent(input$exclude_reset, {
    vals$keeprows <- rep(TRUE, nrow(data))
  })
  
  # modelo
  model <- reactive({
    lm(y ~ x, data = data)
  })
  
}
