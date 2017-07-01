

# Server logic
server <- function(input, output) {
  
  # change plot based on restrictions from input
  output$Plot <- renderPlot({
    plot(price ~ carat, diamonds[which(diamonds$cut == input$cutInput
                                       & diamonds$color == input$colorInput
                                       & diamonds$clarity == input$clarInput),])
    # also put the linear model on the plot
    abline(lm(price ~ carat, 
              diamonds[which(diamonds$cut == input$cutInput),]),col = 'blue')
  })
}