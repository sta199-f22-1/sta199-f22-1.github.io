# load packages ----------------------------------------------------------------

library(tidyverse)

# gbpoll -----------------------------------------------------------------------

gbpoll <- tibble(
  party = c(
    rep("Labour", 494),
    rep("Conservative", 321),
    rep("Liberal Democrats", 136),
    rep("SNP", 74),
    rep("Other", 210)
  )
)

gbpoll |>
  count(party) |>
  mutate(n / sum(n))

write_csv(gbpoll, file = "ae/data/gbpoll.csv")

# survation --------------------------------------------------------------------

survation <- tibble(
  ID = 1:1858,
  `Royal Mail` = c(rep("Public sector", 1579), rep("Private sector", 130), rep("Don't know", 149)),
  Energy       = c(rep("Public sector", 1616), rep("Private sector", 112), rep("Don't know", 130)),
  Water        = c(rep("Public sector", 1746), rep("Private sector", 56),  rep("Don't know", 56)),
  Rail         = c(rep("Public sector", 1746), rep("Private sector", 56),  rep("Don't know", 56))
)

set.seed(1234)
survation <- survation |>
  sample_n(size = n())

write_csv(survation, file = "ae/data/survation.csv")

survation_longer <- survation |>
  pivot_longer(
    cols = -ID,
    names_to = "service",
    values_to = "sector"
  )

survation_longer |>
  count(service, sector) |>
  group_by(service) |>
  mutate(prop = n / sum(n))

