fluidPage(
  

    
  mainPanel(
    tabsetPanel(type = "tabs",
                
                # aba com o grafico e tabela de regressao
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
                
                # aba com os resultados do diagnóstico
                tabPanel("Diagnóstico",
                         column(width = 12,
                                plotOutput("plot2", height = 400, width=600,
                                           click = "plot1_click",
                                           brush = brushOpts(
                                             id = "plot2_brush"
                                           )
                                )
                         )
                )
    )
)
)

