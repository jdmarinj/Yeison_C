######################################
#### PARA POLLO #####
######################################
library(shiny)
library(plyr)
library(ggplot2)
DataPollo=read.csv("M5T3.csv",header=TRUE, sep=";", stringsAsFactors = F)
DataPollo$Fecha=as.Date(DataPollo$Fecha, format="%d/%m/%Y")



function(input, output) {

  
  # Filter data based on selections
  output$TablaPollo <- DT::renderDataTable(DT::datatable({
    data <- DataPollo
    if (input$Cli != "All") {
      data <- data[data$Cli == input$Cli,]
    }
    if (input$Can != "All") {
      data <- data[data$Can == input$Can,]
    }
    if (input$Con != "All") {
      data <- data[data$Con == input$Con,]
    }
    if (input$Tip != "All") {
      data <- data[data$Tip == input$Tip,]
    }
    if (input$Pag != "All") {
      data <- data[data$Pag == input$Pag,]
    }
     data
  }))
 
  dataset <- reactive({
    DataPollo[sample(nrow(DataPollo), input$sampleSize),]
  })
  
  output$plot2 <- renderPlot({
    
    p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
    
    if (input$color != 'None')
      p <- p + aes_string(color=input$color)
    
    
    if (input$jitter)
      p <- p + geom_jitter()
    if (input$smooth)
      p <- p + geom_smooth()
    
    print(p)
    
  })
  
 
  
  # Generate a summary of the data ----
#  output$summary <- renderPrint({
 #   summary(d())
 # })
}