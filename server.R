library(shiny)
library(ggplot2)
load(file="./data/DataAndModel.RData")
source("./common.R")

shinyServer(function(input, output) {

    selectedPoint <- reactive({
        subset(esoph, agegp==input$age & alcgp==input$alc & tobgp==input$tob)
    })
        
    output$predPlot <- renderPlot({
        
        # input$age
        # input$alc
        # input$tob

        ggplot(esoph, aes(x=tobgp, y=.pred, alpha=alcgp, group=alcgp)) +
            geom_point(size=3) +
            geom_point(alpha=1, data=selectedPoint(), color='red', size=4, show.legend = F) +
            facet_grid(~agegp) +
            labs(title="age range", 
                 x="\ntobacco use (g/day)\n", 
                 y = "predicted probability of\nesophogeal cancer\n",
                 alpha="alcohol use (g/day)") +
            theme(panel.background = element_blank(),
                  strip.background=element_blank(),
                  panel.grid.major.y = element_line(color="gray90"),
                  plot.title=element_text(family="sansserif", size=16),
                  axis.title=element_text(family="sansserif", size=16),
                  legend.title=element_text(family="sansserif", size=14),
                  strip.text=element_text(family="sansserif", size=12),
                  legend.text=element_text(family="sansserif", size=12),
                  axis.text.x=element_text(family="sansserif", size=10, angle=90),
                  legend.position="bottom",
                  axis.ticks=element_blank(),
                  panel.margin.x=unit(10, "points"),
                  panel.border=element_rect(fill=NA, color="gray70")
            ) +
            scale_x_discrete(labels=c("0-9", "10-19", "20-29", "30+")) +
            scale_alpha_discrete(labels=c("0-39", "40-79", "80-119", "120+"))    
        })
    
    output$pred <- renderText({
        sprintf("%0.1f%%", selectedPoint()[1,".pred"] * 100)
    })
    
    output$age <- renderText({input$age})
    output$alc <- renderText({getName(input$alc, alcOpts)})
    output$tob <- renderText({getName(input$tob, tobOpts)})
    
})
