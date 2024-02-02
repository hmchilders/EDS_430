#.............................server.............................
server <- function(input, output) {
  
  #Filter lake data -------------
  filtered_lakes_df <- reactive({
    lake_data %>% 
    filter(Elevation >= input$elevation_slider_input[1] & Elevation <= input$elevation_slider_input[2])  %>% 
    filter(AvgDepth >= input$depth_slider_input[1] &  AvgDepth <= input$depth_slider_input[2]) %>% 
      filter(AvgTemp >= input$temp_slider_input[1] & AvgTemp <= input$temp_slider_input[2])
  })
  
  #building map ------
  output$lake_map_output <- renderLeaflet({
    leaflet() |> 
      
      # add tiles
      addProviderTiles(providers$Esri.WorldImagery, # make note of using appropriate tiles
                       options = providerTileOptions(maxNativeZoom = 19, maxZoom = 100)) |> 
      
      # add mini map
      addMiniMap(toggleDisplay = TRUE, minimized = FALSE) |> 
      
      # set view over AK
      setView(lng = -152.048442, lat = 70.249234, zoom = 6) |> 
      
      # add markers
      addMarkers(data = filtered_lakes_df(),
                 lng = filtered_lakes_df()$Longitude, lat = filtered_lakes_df()$Latitude,
                 popup = paste0("Site Name: ", filtered_lakes_df()$Site, "<br>",
                                "Elevation: ", filtered_lakes_df()$Elevation, " meters (above SL)", "<br>",
                                "Avg Depth: ", filtered_lakes_df()$AvgDepth, " meters", "<br>",
                                "Avg Lake Bed Temperature: ", filtered_lakes_df()$AvgTemp, "\u00B0C")) # NOTE: Unicode for degree symbol icon
    
    
  })
  
  
  
  
  
}
