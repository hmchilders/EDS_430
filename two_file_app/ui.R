
#------------------------------------------------------------------

# user interface ----
ui <- navbarPage(
  #Add a Title to the page
  title = "LTER Animal Data Explorer",
  
  # (Page 1) into TabPanel -----
  tabPanel(
    title = "About this page",
    # intro text fluidRow ----
    fluidRow(
      
      # use columns to create white space on sides
      column(1),
      column(10, includeMarkdown("text/about.md")),
      column(1)
      
    ), # END intro text fluidRow
    
    hr(), # creates light gray horizontal line
    
    # footer text ----
    includeMarkdown("text/footer.md")
  ), # END (Page 1) into TabPanel 
  # (Page 2) Data Explore TabPanel -----
  
  tabPanel(
    title = "Explore the Data",
    #tabsetpanel to contain tabs for data viz
    tabsetPanel(
      
      tabPanel(title = "Trout", 
               #Trout sidebar Layout
               sidebarLayout(
                 #trout sidebar panel
                 sidebarPanel(
                   #Channel type pickerinput
                   pickerInput(inputId = "channel_type_input",
                               label = "Select channel Type",
                               choices = unique(clean_trout$channel_type),
                               selected  = c("cascade", "pool"),
                               options = pickerOptions(actionsBox = TRUE), #Adds a select all or deselect all button)
                               multiple = TRUE), #Allows you.to add multiple options on top of each other
                   # section checkboxGroupButtons ----
                   checkboxGroupButtons(inputId = "section_input", label = "Select a sampling section(s):",
                                        choices = c("clear cut forest", "old growth forest"),
                                        selected = c("clear cut forest", "old growth forest"),
                                        individual = FALSE, justified = TRUE, size = "sm",
                                        checkIcon = list(yes = icon("check", lib = "font-awesome"), 
                                                         no = icon("xmark", lib = "font-awesome"))), # END section checkboxGroupInput
                 ), #END sidebar Panel
                 
                 #Trout Main Panel
                 mainPanel(
                   plotOutput(outputId = "trout_scatterplot_output") %>% 
                     withSpinner(color = "forestgreen", type = 5)
                 ) #END Main Trout Panel
                 
               ) #END Sidebar Layout
      ), #END trout tabPanel
      
      tabPanel(title = "Penguins", 
               sidebarLayout(
                 sidebarPanel(
                   pickerInput(inputId = "penguins_picker_input",
                               label = "Select Island(s):",
                               choices = unique(penguins$island),
                               options = pickerOptions(actionsBox = TRUE),
                               multiple = TRUE), # Penguin Input lives here
                   sliderInput(inputId = "penguins_slider_input",
                               label = "How many bins would you like the histogram to have?",
                               min = 1, max = 40,
                               value = 25) #Peguin bin widths will be set here
                   
                 ), #END Penguins Sidebar Panel
                 
                 mainPanel(
                   plotOutput(outputId = "penguins_histogram_output") %>%  #Penguins Outputs will live here"
                     withSpinner(color = "forestgreen", type = 5)
                 ) #END Penguins Main Panel
                 
               ) #END Penguin sidebar Layout
               
      ) #END penguin tabPanel
      
    )#END tabsetPanel
  ) # END (Page 2) Data Explore TabPanel 
  
) # END Navbar Page
