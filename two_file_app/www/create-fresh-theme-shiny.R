# load library ----
library(fresh)

# create theme -----
create_theme(
  
  theme = "default", # you can supply a bootstrap theme to begin with
  
  bs_vars_global( # global styling
    body_bg = "#D2D0CA", # beige
    text_color = "#F23ACB", # hot pink
    link_color = "#0E4BE3" # royal blue
  ),
  
  bs_vars_navbar( # navbar styling
    default_bg = "#13CC13", # lime green
    default_color = "#66656C" # gray
  ),
  
  bs_vars_tabs( # tab styling
    border_color = "#F90909" # red
  ),
  
  output_file = "two_file_app/www/shiny-fresh-theme.css" # generate css file & save to www/
)
