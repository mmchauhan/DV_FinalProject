library(shiny)
require(shinydashboard)
require(leaflet)

dashboardPage(
  dashboardHeader(title = "Data Visualization: Import/Export of Metals", titleWidth = 450
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Scatter Plot", tabName = "scatter", icon = icon("th")),
      menuItem("Barchart", tabName = "barchart", icon = icon("bar-chart")),
      menuItem("Crosstab", tabName = "crosstab", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "scatter",
              selectInput("year", "Year:", 
                          choices=c(2007, 2009)),
              plotOutput("scatterPlot1"),
              plotOutput("scatterPlot2"),
              plotOutput("scatterPlot3")
      ),
      
      tabItem(tabName = "barchart",
              selectInput("flow", "Flow:", 
                          choices=c('Export', 'Import')),
              plotOutput("barChart")
              
      ),
      tabItem(tabName = "crosstab",
              sliderInput("KPI1", "KPI_Low_Max_value:", 
                          min = 1, max = 100000000,  value = 100000000),
              sliderInput("KPI2", "KPI_Medium_Max_value:", 
                          min = 100000000, max = 1000000000,  value = 1000000000),
              plotOutput("crosstab")
      )
    )
  )
)