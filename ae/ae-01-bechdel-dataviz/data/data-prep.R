# load packages ----------------------------------------------------------------

library(tidyverse)
library(fivethirtyeight)

# data prep --------------------------------------------------------------------

bechdel <- bechdel |>
  filter(between(year, 1990, 2013)) |>
  mutate(
    gross_2013 = intgross_2013 + domgross_2013,
    roi = (intgross_2013 + domgross_2013) / budget_2013
    ) |>
  relocate(title, year, gross_2013, budget_2013, roi, binary, clean_test)

# write data -------------------------------------------------------------------

write_csv(bechdel, file = here::here("data/bechdel.csv"))
