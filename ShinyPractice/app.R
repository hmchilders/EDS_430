## Rshiny App
# load packages ----
library(shiny)
library(tidyverse)
library(DT)
library(shinyWidgets)
library(shinycssloaders)
library(markdown)
library(rsconnect)
library(shiny)
library(bslib)
  

#load in the data ------
library(palmerpenguins)
library(lterdatasampler)
#Thematic info----------
thematic::thematic_shiny()

# user interface ----
ui <- fluidPage(
  # app title ----
  tags$h1("My App Title"),
  
  #Add a theme
  theme = bs_theme(bg = "#A36F6F", # background color
                   fg = "#FDF7F7", # foreground color
                   primary = "#483132", # primary accent color
                   base_font = font_google("Pacifico")),
  
  # app subtitle ----
  h4(strong("Exploring Antarctic Penguin Data")),
  
  # body mass slider input ----
  sliderInput(inputId = "body_mass_input", label = "Select a range of body masses (g)",
              min = 2700, max = 6300, value = c(3000, 4000)),
  
  # body mass plot output ----
  plotOutput(outputId = "bodyMass_scatterplot_output"),
  
  #Checkbox Input------
  checkboxGroupInput(inputId = "year_input", label = "Select year(s)",
                     choices = c("2007", "2008","2009"),
                     selected = c("2007", "2008")),
  
  #Checkbox Output ------
  DT::dataTableOutput(outputId = "year_dataTable_output")
  
)

# server instructions ----
server <- function(input, output) {
 
   #filter body masses -------
  body_mass_df <-reactive({
    
    penguins %>% 
    filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
  
  })
  
  
  #Create the scatterplot -------
  output$bodyMass_scatterplot_output <- renderPlot({
    ggplot(na.omit(body_mass_df()), 
           aes(x = flipper_length_mm, y = bill_length_mm, 
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
      scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
      labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
           color = "Penguin species", shape = "Penguin species") +
      theme_minimal() +
      theme(legend.position = c(0.85, 0.2),
            legend.background = element_rect(color = "white")) 
  })
  
 #Filter the years
  years_df <-reactive({
    
    penguins %>% 
      filter(year %in% c(input$year_input))
    
  })
  
   #render DT table ------
  output$year_dataTable_output <- DT::renderDataTable({
    DT::datatable(years_df())
    })
}

# combine UI & server into an app ----
shinyApp(ui = ui, server = server)
