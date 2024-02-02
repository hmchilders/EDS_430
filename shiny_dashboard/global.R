#..............................setup.............................
library(shiny)
library(shinydashboard)
library(tidyverse)
library(leaflet)
library(shinycssloaders)

lake_data <- read_csv("data/lake_data_processed.csv")