## Practice Script fro the single file app stucture
#load in the necessary libraries------
library(palmerpenguins)
library(tidyverse)

body_mass_df <-penguins %>% 
  filter(body_mass_g %in% c(3000:4000))

#create a practice plot-------
ggplot(na.omit(body_mass_df), 
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

#..........................load packages.........................
library(lterdatasampler)
library(tidyverse)

#............custom ggplot theme (apply to both plots)...........
myCustomTheme <- function() {
  theme_light() +
    theme(axis.text = element_text(size = 12),
          axis.title = element_text(size = 14, face = "bold"),
          legend.title = element_text(size = 14, face = "bold"),
          legend.text = element_text(size = 13),
          legend.position = "bottom",
          panel.border = element_rect(linewidth = 0.7))
}

#.......................wrangle trout data.......................
clean_trout <- and_vertebrates |>
  filter(species == "Cutthroat trout") |>
  select(sampledate, section, species, length_mm = length_1_mm, weight_g, channel_type = unittype) |> 
  mutate(channel_type = case_when(
    channel_type == "C" ~ "cascade",
    channel_type == "I" ~ "riffle",
    channel_type =="IP" ~ "isolated pool",
    channel_type =="P" ~ "pool",
    channel_type =="R" ~ "rapid",
    channel_type =="S" ~ "step (small falls)",
    channel_type =="SC" ~ "side channel"
  )) |> 
  mutate(section = case_when(
    section == "CC" ~ "clear cut forest",
    section == "OG" ~ "old growth forest"
  )) |> 
  drop_na()

#..................practice filtering trout data.................
trout_filtered_df <- clean_trout |> 
  filter(channel_type %in% c("pool", "rapid")) |> 
  filter(section %in% c("clear cut forest"))

#........................plot trout data.........................
ggplot(trout_filtered_df, aes(x = length_mm, y = weight_g, color = channel_type, shape = channel_type)) +
  geom_point(alpha = 0.7, size = 5) +
  scale_color_manual(values = c("cascade" = "#2E2585", "riffle" = "#337538", "isolated pool" = "#DCCD7D", 
                                "pool" = "#5DA899", "rapid" = "#C16A77", "step (small falls)" = "#9F4A96", 
                                "side channel" = "#94CBEC")) +
  scale_shape_manual(values = c("cascade" = 15, "riffle" = 17, "isolated pool" = 19, 
                                "pool" = 18, "rapid" = 8, "step (small falls)" = 23, 
                                "side channel" = 25)) +
  labs(x = "Trout Length (mm)", y = "Trout Weight (g)", color = "Channel Type", shape = "Channel Type") +
  myCustomTheme()

#..........................load packages.........................
library(palmerpenguins)
library(tidyverse)

#..................practice filtering for island.................
island_df <- penguins %>%
  filter(island %in% c("Dream", "Torgesen"))

#........................plot penguin data.......................
ggplot(na.omit(island_df), aes(x = flipper_length_mm, fill = species)) +
  geom_histogram(alpha = 0.6, position = "identity", bins = 25) +
  scale_fill_manual(values = c("Adelie" = "#FEA346", "Chinstrap" = "#B251F1", "Gentoo" = "#4BA4A4")) +
  labs(x = "Flipper length (mm)", y = "Frequency",
       fill = "Penguin species") +
  myCustomTheme()

#..............................SETUP.............................

# load packages ----
library(tidyverse)
library(leaflet)

# read in data ----
lake_data <- read_csv(here::here("shiny_dashboard", "data", "lake_data_processed.csv"))

#.......................PRACTICE FILTERING.......................

filtered_lakes <- lake_data |> 
  filter(Elevation >= 8 & Elevation <= 20) |> 
  filter(AvgDepth >= 2 & AvgDepth <= 3) |> 
  filter(AvgTemp >= 4 & AvgTemp <= 6)

#..........................PRACTICE VIZ..........................

leaflet() |> 
  
  # add tiles
  addProviderTiles(providers$Esri.WorldImagery, # make note of using appropriate tiles
                   options = providerTileOptions(maxNativeZoom = 19, maxZoom = 100)) |> 
  
  # add mini map
  addMiniMap(toggleDisplay = TRUE, minimized = FALSE) |> 
  
  # set view over AK
  setView(lng = -152.048442, lat = 70.249234, zoom = 6) |> 
  
  # add markers
  addMarkers(data = filtered_lakes,
             lng = filtered_lakes$Longitude, lat = filtered_lakes$Latitude,
             popup = paste0("Site Name: ", filtered_lakes$Site, "<br>",
                            "Elevation: ", filtered_lakes$Elevation, " meters (above SL)", "<br>",
                            "Avg Depth: ", filtered_lakes$AvgDepth, " meters", "<br>",
                            "Avg Lake Bed Temperature: ", filtered_lakes$AvgTemp, "\u00B0C")) # NOTE: Unicode for degree symbol icon
