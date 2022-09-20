# load packages ----------------------------------------------------------------

library(tidyverse)

# load data --------------------------------------------------------------------

hotels <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-11/hotels.csv")

# make a plot ------------------------------------------------------------------

hotels %>%
  group_by(hotel, arrival_date_month) %>%   # group by hotel type and arrival month
  summarise(mean_adr = mean(adr)) %>%       # calculate mean adr for each group
  ggplot(aes(
    x = arrival_date_month,                 # x-axis = arrival_date_month
    y = mean_adr,                           # y-axis = mean_adr calculated above
    group = hotel,                          # group lines by hotel type
    color = hotel)                          # and color by hotel type
  ) +
  geom_line() +                             # use lines to represent data
  theme_minimal() +                         # use a minimal theme
  labs(
    x = "Arrival month",                 # customize labels
    y = "Mean ADR (average daily rate)",
    title = "Comparison of resort and city hotel prices across months",
    subtitle = "Resort hotel prices soar in the summer while ciry hotel prices remain relatively constant throughout the year",
    color = "Hotel type"
  )

ggsave("ae/images/hotel-prices-months.png", width = 10, height = 4)
