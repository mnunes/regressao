fluidPage(
  

    
  mainPanel(
    tabsetPanel(type = "tabs",
                tabPanel("Regressão",
                column(width = 12,
                       plotOutput("plot1", height = 400, width=600,
                                  click = "plot1_click",
                                  brush = brushOpts(
                                    id = "plot1_brush"
                                    )
                                  ),
                       actionButton("exclude_reset", "Reset")
                       ),
                tableOutput("model")
                ),
                tabPanel("Regressão",
                         column(width = 12,
                                plotOutput("plot1", height = 400, width=600,
                                           click = "plot1_click",
                                           brush = brushOpts(
                                             id = "plot1_brush"
                                           )
                                ),
                                actionButton("exclude_reset", "Reset")
                         ),
                         tableOutput("model")
                )
                
    )
  )
  
  
)

