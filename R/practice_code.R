# practice code

library(palmerpenguins)
library(tidyverse)
library(DT)

# filter body masses
body_mass_df <- penguins %>% 
  filter(body_mass_g %in% c(3000, 4000))


# create scatter plot

ggplot(na.omit(body_mass_df),
       aes(x = flipper_length_mm,
           y = bill_length_mm,
           color = species,
           shape = species))+
  geom_point()+
  #scale_color_manual(values = c())+
  labs(x = "Flipper length (mm)",
       y = "Bill lenght (mm)",
       color = "Penguin Species",
       shape = "Penguin Species")


# Create a table using DT package





