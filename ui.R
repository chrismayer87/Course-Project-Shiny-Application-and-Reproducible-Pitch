library(shiny)
library(datasets)
library(caret)

ui <- fluidPage(
  
  # Application title
  titlePanel("Show Price by Carats
             as Determined by Key Characteristics"),
  
  sidebarLayout(
    
    # Sidebar with 3 input variables to modify the eventual output
    sidebarPanel(
      radioButtons("cutInput","Type of Cut",
                   choices = c("Fair","Good","Very Good","Premium","Ideal"),
                   selected = "Fair"),
      
      radioButtons("colorInput","Color",
                   choices = c("E","I","J","H","F","G","D"),
                   selected = "E"),
      
      radioButtons("clarInput","Clarity",
                   choices = c("SI2","SI1","VS1","VS2","VVS2","VVS1","I1","IF"),
                   selected = "SI2")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Plot")
    )
  )
  )