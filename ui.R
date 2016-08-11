library(shiny)
load(file="./data/DataAndModel.RData")
source("./common.R")

shinyUI(fluidPage(
    
    # Application title
    titlePanel("Esophageal Cancer Prediction"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("age", "Age Range:", levels(esoph$agegp)),
            selectInput("alc", "Daily Alcohol Consumption:", alcOpts),
            selectInput("tob", "Daily Tobacco Use:", tobOpts),
            hr(),
            div(
                p("To use this tool, simply choose your age and vice consumption levels. The result can be interpreted as the probability of having esophageal cancer given your current age and behaviors."),
                hr(),
                p("These predictions are based on logistic regression (a binomial generalized linear model with logit link).",
                  "Some loose conversions were made to translate from grams alcohol/tobacco to drinks/cigarettes. Namely:"
                  ),
                tags$ul(
                    tags$li("1 drink is approximately 14g alcohol"),
                    tags$li("1 cigarette is approximately 1 gram of tobacco")
                ),
                p("Data provided by:"),
                p("Breslow, N. E. and Day, N. E. (1980) Statistical Methods in Cancer Research. Volume 1: The Analysis of Case-Control Studies. IARC Lyon / Oxford University Press.")
            )
        ),

        
                
        # Show a plot of the generated distribution
        mainPanel(
            p("Based on your age (", 
              em(textOutput("age", inline=T)), 
              "), alcohol consumption (", 
              em(textOutput("alc", inline=T)), 
              "), and tobacco use (",
              em(textOutput("tob", inline=T)),
              "), your probability of getting esophageal cancer is currently",
              strong(style="font-size: 1.4em", textOutput("pred", inline=T)), "."
            ),
            plotOutput("predPlot"),
            p("Note that your associated risk of getting esophageal cancer varies as you age and change behaviors.")
        )
    )
))
