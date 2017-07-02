Reproducible Pitch Presentation: Show Price by Carats as Determined by Key Characteristics
========================================================
author: Christopher Mayer 
date: 07/02/2017
autosize: true

========================================================

This deck satisfies the pitch requirement for the course project. The assignment was to build a simple application in Shiny that reacts to user inputs and performs calculations.

- R standard dataset: carets
- User Inputs: Cut, Color, Clarity
- Output: Graph of price by carat with linear model

Sufficient variation in price exists to support a tool and its development from this dataset.

![plot of chunk unnamed-chunk-1](Pitch-figure/unnamed-chunk-1-1.png)

========================================================

A tool to add the customer in finding a price based on key features as well as a rough sense of how much data is used for the price would be helpful. A test was performed to confirm that a linear model would be suitable.

The server code runs the plot based on inputs and the linear model display. It reacts to new user inputs.


```r
# Server logic
server <- function(input, output) {
  
  # change plot based on restrictions from input
  output$Plot <- renderPlot({
    plot(price ~ carat, diamonds[which(diamonds$cut == input$cutInput
                                       & diamonds$color == input$colorInput
                                       & diamonds$clarity == input$clarInput),])
    # also put the linear model on the plot
    abline(lm(price ~ carat, 
              diamonds[which(diamonds$cut == input$cutInput
                                       & diamonds$color == input$colorInput
                                       & diamonds$clarity == input$clarInput),]))
  })
}
```


========================================================


```r
library(randomForest)
train = sample(1:dim(diamonds)[1],size=dim(diamonds)[1]/4,replace=F)
train_diamonds = diamonds[train,]
test_diamonds = diamonds[-train,]
set.seed(1337)
mod_rf <- randomForest(price ~ .,data = train_diamonds)

mod_lm <- lm(formula = price ~ carat + cut + color + clarity, data = diamonds)

rfresult <- predict(mod_rf, test_diamonds)
lmresult <- predict(mod_lm, test_diamonds)

mean(diff(rfresult - test_diamonds$price))
```

```
[1] -0.001697069
```

```r
mean(diff(lmresult - test_diamonds$price))
```

```
[1] 0.07620071
```

A separate analysis with random Forest found a smaller number of variance but required too much resources. This order of magniture difference is acceptable as the quick reactivity is desired.

========================================================

The tool recreates linear models based on Cut, Color, and Clarity. This is the ui code that enables the customer to make changes.


```r
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
    )  )  )
```



