require("jsonlite")
require("RCurl")
require("dplyr")
require("ggplot2")
require(dplyr)

# Change the USER and PASS below to be your UTEid
aluminum <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from ALUMINUM1"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_mmc2762', PASS='orcl_mmc2762', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

aluminum <- aluminum %>% filter(YEAR == "2007")

ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title='Cost of aluminum by kilograms 2007') +
  labs(x="Total USD", y=paste("Quanitity(kg)")) +
  layer(data=aluminum, 
        mapping=aes(x=as.numeric(as.character(TRADE_USD)), y=as.numeric(as.character(QUANTITY_KG))), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list()
        
  )
