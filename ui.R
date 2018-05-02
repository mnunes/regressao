# layout

navbarPage(title="Regressão Linear Interativa", theme = shinytheme("cosmo"),

sidebarLayout(position="left",
  
  # painel lateral
  sidebarPanel(
    h2("Explore o modelo de regressão linear"),
    p("Esta ferramenta interativa permite que pontos sejam colocados no gráfico à direita, a fim de que uma reta seja ajustada a eles. Experimente colocar ao menos dois pontos no gráfico e veja o resultado."),
    p("Perceba que há algumas abas acima do gráfico. Estas abas permitem que os gráficos de diagnóstico do modelo sejam checados e que os dados criados sejam baixados para serem utilizados posteriormente. Assim, é possível criar interativamente conjuntos de dados com características específicas, como pontos de influência, heterocedasticidade e demais problemas que podem surgir em análise de modelos de regressão linear."),
    p("Aplicativo desenvolvido por", a("Marcus Nunes", href="http://marcusnunes.me/", target="_blank"), ". O código está disponível", a("no github", href="https://github.com/mnunes/regressao/", target="_blank"), ".")
  ),
           
  # painel central
  mainPanel(
    tabsetPanel(type = "tabs",
                selected = "Regressão",
                
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
                tableOutput("model"), 
                p(" "),
                tableOutput("anova")
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
                ), 
                
                # aba com os dados
                tabPanel("Dados",
                         tableOutput("dados")
                         )
                         
    )
                         
                         
    )
)
)


