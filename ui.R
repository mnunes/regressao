fluidPage(
  fluidRow(
    column(width = 6,
           plotOutput("plot1", height = 400, width=600,
                      click = "plot1_click",
                      brush = brushOpts(
                        id = "plot1_brush"
                      )
           ),
           verbatimTextOutput("model"),
           actionButton("exclude_reset", "Reset")
    )
  )
)

