

library(shiny)
library(dplyr)
library(shinydashboard)
library(RCrimeStat)
library(ggplot2)


# Define server logic required to draw a histogram
server <- function(input, output) {
  df <- datasuccess()
  
  data <- df
  output$results <- renderTable(striped = TRUE, 
                                bordered = TRUE, {
                                  # generate bins based on input$bins from ui.RA
                                  filteredData1 <- data %>% filter(category == input$CrimeType)
                                  filteredData1 <- filteredData1 %>% select(id,category,month)
                                  # print(filteredData1)
                                  # filteredData["Count"] <- length(filteredData$category)
                                  fluidRow(
                                    DT::dataTableOutput("results",width = "80%" )
                                  )
                                  filteredData1
                                } ) 
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    filteredData <- data %>% filter(category == input$CrimeType)
    filteredData["Count"] <- length(filteredData$category)
    
    # draw the histogram with the specified number of bins
    ggplot(filteredData,aes(x=outcome_status$category))+geom_bar()
  })
  
  output$CrimeType = renderUI({ #creates State select box object called in ui
    selectInput(inputId = "CrimeType", #name of input
                label = "Crime:", #label displayed in ui
                choices = as.character(c(1,2,3,4,5)),
                # calls unique values from the State column in the previously created table
                selected = "bicycle-theft") #default choice (not required)
  })
  
  output$CrimeType <- NULL
  
}



# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("UK Police Street Crime Stats"),
  
  
  # Sidebar with a slider input for number of bins  
  sidebarLayout(
    sidebarPanel(
      selectInput("CrimeType","Select Crime Type",c("bicycle-theft","burglary","criminal-damage-arson","drugs","other-theft","possession-of-weapons","public-order","robbery","shoplifting","theft-from-the-person",
                                                    "vehicle-crime","violent-crime","other-crime"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h1("Data Table"),
      tableOutput("results"),
      br(),br(),
      h1("Data Graph"),
      plotOutput("distPlot")
      
    )
  )
)

# Run the application 
shinyApp(ui = ui, server = server)
