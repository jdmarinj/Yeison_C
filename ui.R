###################   PARA POLLO CAMILOq  ######
###getwd()
###install.packages("shinythemes")
setwd("G:/GitHub/Yeison_C")
DataPollo=read.csv("M5T3.csv",header=TRUE, sep=";", stringsAsFactors = F)
DataPollo$Fecha=as.Date(DataPollo$Fecha, format="%d/%m/%Y")

library(shiny) # Cargar paquetes
library(ggplot2)
library(shinythemes)

dataset <- diamonds
fluidPage( #theme = shinytheme("paper"),
            title="Datos de Factura Pollo",
           
            h1('Datos de Factura Pollo'),
            tabsetPanel(
              tabPanel("Filtrado de Tablas",
                            fluidRow(
                              column(4,
                                     selectInput("Cli",
                                                 "Cliente:",
                                                 c("All",
                                                   unique(as.character(DataPollo$Cliente))))
                              ),
                              column(4,
                                     selectInput("Can",
                                                 "Canal:",
                                                 c("All",
                                                   unique(as.character(DataPollo$Canal))))
                              ),
                              column(4,
                                     selectInput("Con",
                                                 "Concepto:",
                                                 c("All",
                                                   unique(as.character(DataPollo$Concepto))))
                              ),
                              column(4,
                                     selectInput("Tip",
                                                 "Tipo_IVA:",
                                                 c("All",
                                                   unique(as.character(DataPollo$Tipo_IVA))))
                              ),
                              column(4,
                                     selectInput("Pag",
                                                 "Pagada:",
                                                 c("All",
                                                   unique(as.character(DataPollo$Pagada))))
                              )
                            ),
                            # Create a new row for the table.
                            fluidRow( column(6, DT::dataTableOutput("TablaPollo")),
                                      column(6, plotOutput("x2", height = 500))
                              
                            )
#Se deja la posibilidad de dibujar tablas
                       ),
                            tabPanel("Figuras", 
                                     
                                     fluidPage(
                                       
                                       title = "Exploracion de Facturas",
                                       
                                       plotOutput('plot2'),
                                       
                                       hr(),
                                       
                                       fluidRow(
                                         column(3,
                                                h4("Diamonds Explorer"),
                                                sliderInput('sampleSize', 'Sample Size', 
                                                            min=1, max=nrow(DataPollo),
                                                            value=min(1000, nrow(DataPollo)), 
                                                            step=10, round=0),
                                                br(),
                                                checkboxInput('jitter', 'Jitter'),
                                                checkboxInput('smooth', 'Smooth')
                                         ),
                                         column(4, offset = 1,
                                                selectInput('x', 'X', names(DataPollo)),
                                                selectInput('y', 'Y', names(DataPollo), names(DataPollo)[[2]]),
                                                selectInput('color', 'Color', c('None', names(DataPollo)))
                                         )
                                        
                                       )
                                     )
                                     
                                     
                                     )
            )

)
  
