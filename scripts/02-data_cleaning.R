#### Preamble ####
# Purpose: Cleans the raw data 
# Author: Heyucheng Zhang
# Date: 26 March 2024 
# Contact: heyucheng.zhang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need raw data to be saved

#### Workspace setup ####
library(arrow)
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_data.csv")

cleaned_data <-
  raw_data |>
  janitor::clean_names() |>
  select(-timestamp) |>
  rename(c(certainty = how_certain_about_your_guess_are_you,
           outcome = what_was_the_outcome)) |> 
  mutate(
    outcome = if_else(outcome == "Guessed right",
                      1,
                      0))


#### Save data ####
write_parquet(cleaned_data, "data/analysis_data/analysis_data.parquet")