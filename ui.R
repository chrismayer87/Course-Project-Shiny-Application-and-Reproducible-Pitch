library(shiny)
library(datasets)
library(caret)
library(markdown)

shinyUI(fluidPage(

# Application title
titlePanel("Show Price by Carats as Determined by Key Characteristics"),

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
      tabsetPanel(
      tabPanel("How to Use Documentation", 
"Please choose the 3 characteristics from initial review of the gem.
The server calculation will restrict observations from the dataset for gems like the one you are reviewing.
A model of price by carat size will be provided in the plot tab to give a sense of market value for the gem.
"               
               ),  
      tabPanel("Plot", plotOutput("Plot")),
      tabPanel("About", 
"The Github code can be found here: https://github.com/chrismayer87/Course-Project-Shiny-Application-and-Reproducible-Pitch
               
Analysis was done beforehand (investigation.R) to find if simple linear model was sufficient for this estimation tool.
")
    )
    )
   )
))

