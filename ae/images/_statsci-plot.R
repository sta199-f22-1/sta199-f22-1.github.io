# load packages ----------------------------------------------------------------

library(tidyverse)

# load data --------------------------------------------------------------------

statsci <- read_csv(here::here("ae/data", "statsci.csv"))

# make draft plot --------------------------------------------------------------

statsci |>
  pivot_longer(
    cols = -degree,
    names_to = "year",
    names_transform = as.numeric,
    values_to = "n"
  ) |>
  mutate(n = if_else(is.na(n), 0, n)) |>
  separate(degree, sep = " \\(", into = c("major", "degree_type")) |>
  mutate(
    degree_type = str_remove(degree_type, "\\)"),
    degree_type = fct_relevel(degree_type, "BS", "BS2", "AB", "AB2")
  ) |>
  ggplot(aes(x = year, y = n, color = degree_type)) +
  geom_point() +
  geom_line()

ggsave(filename = here::here("ae/images", "statsci-plot-draft.png"), width = 7, height = 5)

# make plot --------------------------------------------------------------------

statsci |>
  pivot_longer(
    cols = -degree,
    names_to = "year",
    names_transform = as.numeric,
    values_to = "n"
  ) |>
  mutate(n = if_else(is.na(n), 0, n)) |>
  separate(degree, sep = " \\(", into = c("major", "degree_type")) |>
  mutate(
    degree_type = str_remove(degree_type, "\\)"),
    degree_type = fct_relevel(degree_type, "BS", "BS2", "AB", "AB2")
    ) |>
  ggplot(aes(x = year, y = n, color = degree_type)) +
  geom_point() +
  geom_line() +
  scale_x_continuous(breaks = seq(2011, 2021, 2)) +
  scale_color_manual(
    values = c("BS" = "cadetblue4",
               "BS2" = "cadetblue3",
               "AB" = "lightgoldenrod4",
               "AB2" = "lightgoldenrod3")) +
  labs(
    x = "Graduation year",
    y = "Number of majors graduating",
    color = "Degree type",
    title = "Statistical Science majors over the years",
    subtitle = "Academic years 2011 - 2021",
    caption = "Source: Office of the University Registrar\nhttps://registrar.duke.edu/registration/enrollment-statistics"
  ) +
  theme_minimal() +
  theme(
    legend.position = c(0.2, 0.7),
    legend.background = element_rect(fill = "white", color = "gray")
    )

ggsave(filename = here::here("ae/images", "statsci-plot.png"), width = 7, height = 5)

