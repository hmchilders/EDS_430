## Rshiny App
# load packages ----
library(shiny)
library(tidyverse)
library(DT)
library(shinyWidgets)
library(shinycssloaders)
library(markdown)
library(rsconnect)
#load in the data ------
library(palmerpenguins)
library(lterdatasampler)

# user interface ----
ui <- fluidPage(
  # app title ----
  tags$h1("My App Title"),
  
  # app subtitle ----
  h4(strong("Exploring Antarctic Penguin Data")),
  
  # body mass slider input ----
  sliderInput(inputId = "body_mass_input", label = "Select a range of body masses (g)",
              min = 2700, max = 6300, value = c(3000, 4000)),
  
  # body mass plot output ----
  plotOutput(outputId = "bodyMass_scatterplot_output")
)

# server instructions ----
server <- function(input, output) {
  output$bodyMass_scatterplot_output <- renderPlot({
    
  })
}

# combine UI & server into an app ----
shinyApp(ui = ui, server = server)
