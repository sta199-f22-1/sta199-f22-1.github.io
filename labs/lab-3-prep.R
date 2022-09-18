library(tidyverse)

d <- read_csv("labs/data/KEI_18092022013111718.csv") |>
  select(Country, Time, Value) |>
  rename(year = Time) |>
  janitor::clean_names()

d |>
  filter(Country %in% countries) |>
  ggplot(aes(x = Time, y = Value, color = Country)) +
  geom_line()
