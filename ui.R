source("helper.R")

shinyUI(
  navbarPage("Car Data Explorer", theme="bootstrap.css",
  ##headerPanel("Car Data Explorer"),     
  ##hr(),
  tabPanel("Comparison",
  sidebarLayout(
    sidebarPanel(
      h3("Select features to display"),
      selectInput(inputId="x",label="Select feature for x axis:",
                  choices = values,
                  selected="wt"),
      selectInput(inputId="y",label="Select feature for y axis:",
                  choices=values),
      checkboxInput(inputId="rl", label="Plot regression line"),
      selectInput(inputId="c",label="Select model to highlight:",
                  choices=brandnames)
    ),
    mainPanel(h2("Car features comparison"),
              tabsetPanel(
                tabPanel("Plot",
                    plotOutput("carplot")),
                tabPanel("Table",
                   dataTableOutput("cartable"))
              )
    ))
  ),
  tabPanel("Help",
    h2("How to use this app")       
           
           
           
           )
  ))