#Dashboard Header -------------
header <-dashboardHeader( 
  
  #title-------
  title = "Fish Creek Watershed Lake Monitoring",
  titleWidth = 400
)#END Header
#Dashboard Sidebar -------------
sidebar <- dashboardSidebar(
  
  #
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "welcome", icon = icon("star")),
    menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("gauge"))
  )#END Sidebar Menu
)#END Sidebar


#Dashboard Body -----------------
body <- dashboardBody(
  
  tabItems(
    
    #Welcome Tab Item
    tabItem(tabName = "welcome", 
            
            #Left and column (background)
            column(width = 6,
                   #info box
                   box(
                     width = NULL,
                     "BACKGROUND INFO HERE"
                   )#END of Box
                   ),#END Left Column
            #Right - Top Column
            column(width = 6,
              fluidRow(box(width = NULL,
                       "CITATION HERE"
                       )#END Box 1
              ),#END fluidrow
              fluidRow(
                box(width = NULL, 
                    "PLACEHOLDER TEXT"
                    )#END of box2
                )#END of fluidrow2
            )#END Right column
            
    ),#END welcome tab Item
    
    #Dashboard Tab Item
    tabItem(tabName = "dashboard", 
            
            #add a fluid row
            fluidRow(
              box(width = 4,
                  title = tags$strong("Adjust Lake Parameter Inputs"),
                  sliderInput(inputId = "elevation_slider_input",
                              label = "Elevation (meters above sea level)",
                              min = min(lake_data$Elevation),
                              max = max(lake_data$Elevation),
                              value = c(min(lake_data$Elevation),max(lake_data$Elevation) )
                              ),#END Elevation Slider
                  sliderInput(inputId = "temp_slider_input",
                              label = "Temperature (ºC)",
                              min = min(lake_data$AvgTemp),
                              max = max(lake_data$AvgTemp),
                              value = c(min(lake_data$AvgTemp),max(lake_data$AvgTemp) )
                  ), #END Depth Slider
                  sliderInput(inputId = "depth_slider_input",
                              label = "Lake Depth (meters)",
                              min = min(lake_data$AvgDepth),
                              max = max(lake_data$AvgDepth),
                              value = c(min(lake_data$AvgDepth),max(lake_data$AvgDepth) )
                  ) #END Temp Slider
                  ),# End Box
              box(width = 8,
                title = "Montioring Lakes within Creek Watershed",
                # leaflet output -------
                leafletOutput(outputId = "lake_map_output") %>% 
                  withSpinner(type = 5, color = "skyblue")
              )#END map Box
            )#END Fluid Row
            
          
    )#END dashboard tab Item
  )#END tabitems
)#END Body



#Dashboard Page ------------------
dashboardPage(header,sidebar,body)