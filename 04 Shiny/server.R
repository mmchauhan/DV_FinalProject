# server.R
require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)
require(shiny)
require(reshape2)
require(shinydashboard)
require(leaflet)
require(DT)

shinyServer(function(input, output) {
  
  aluminum <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from ALUMINUM1"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_mmc2762', PASS='orcl_mmc2762', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
  copper <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from COPPER11"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_mmc2762', PASS='orcl_mmc2762', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
  zinc <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from ZINC11"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_mmc2762', PASS='orcl_mmc2762', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
  gdp <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from GDP1"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_mmc2762', PASS='orcl_mmc2762', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
  
  
  output$scatterPlot1 <- renderPlot({
    aluminum <- aluminum %>% filter(YEAR == input$year)
    
    ggplot() + 
      coord_cartesian() + 
      scale_x_continuous() +
      scale_y_continuous() +
      labs(title='Cost of aluminum by kilograms') +
      labs(x="Total USD", y=paste("Quanitity(kg)")) +
      layer(data=aluminum, 
            mapping=aes(x=as.numeric(as.character(TRADE_USD)), y=as.numeric(as.character(QUANTITY_KG))), 
            stat="identity", 
            stat_params=list(), 
            geom="point",
            geom_params=list()
            
      )
  })
  
  output$scatterPlot2 <- renderPlot({
    copper <- copper %>% filter(YEAR == input$year)
    
    ggplot() + 
      coord_cartesian() + 
      scale_x_continuous() +
      scale_y_continuous() +
      labs(title='Cost of copper by kilograms') +
      labs(x="Total USD", y=paste("Quanitity(kg)")) +
      layer(data=copper, 
            mapping=aes(x=as.numeric(as.character(TRADE_USD)), y=as.numeric(as.character(QUANTITY_KG))), 
            stat="identity", 
            stat_params=list(), 
            geom="point",
            geom_params=list()
            
      )
  })
  
  output$scatterPlot3 <- renderPlot({
    zinc <- zinc %>% filter(YEAR == input$year)
    
    ggplot() + 
      coord_cartesian() + 
      scale_x_continuous() +
      scale_y_continuous() +
      labs(title='Cost of zinc by kilograms') +
      labs(x="Total USD", y=paste("Quanitity(kg)")) +
      layer(data=zinc, 
            mapping=aes(x=as.numeric(as.character(TRADE_USD)), y=as.numeric(as.character(QUANTITY_KG))), 
            stat="identity", 
            stat_params=list(), 
            geom="point",
            geom_params=list()
            
      )
  })
  
  output$barChart <- renderPlot({
    aluminum <- aluminum %>% filter(FLOW == input$flow)
    aluminum <- melt(aluminum[,c('COUNTRY','QUANTITY_KG','TRADE_USD')],id.vars = "COUNTRY")
    
    ggplot(aluminum, aes(COUNTRY, value)) +   
      geom_bar(aes(fill = variable), position = "dodge", stat="identity") +
      coord_flip()
  })
  
  observeEvent(input$clicks, {
    print(as.numeric(input$clicks))
  })

  
  # End your code here.
  return(plot)
})
  