# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(lubridate)
library(robotstxt)

# check that we can scrape -----------------------------------------------------

paths_allowed("https://www.amazon.com")

# read page --------------------------------------------------------------------

page <- read_html("https://www.amazon.com/Yankee-Candle-Large-Apple-Pumpkin/product-reviews/B008P8YTU6/ref=cm_cr_getr_d_paging_btm_next_2?ie=UTF8&reviewerType=all_reviews&pageNumber=1&sortBy=recent")

# parse reviews ----------------------------------------------------------------

titles <- page |>
  html_nodes("#cm_cr-review_list .celwidget .a-row:nth-child(2)") |>
  html_text2()

reviews <- page |>
  html_nodes(".a-spacing-small.review-data") |>
  html_text2()

countries_dates <- page |>
  html_nodes("#cm_cr-review_list .review-date") |>
  html_text2()

yc_reviews_1 <- tibble(
  title = titles,
  review = reviews,
  country_date = countries_dates
)

# function: scrape_review ---------------------------------------------------------------
# input: url
# output: a data frame with 10 reviews from a page

scrape_review <- function(url){

  Sys.sleep(2)

  page <- read_html(url)

  titles <- page |>
    html_nodes("#cm_cr-review_list .celwidget .a-row:nth-child(2)") |>
    html_text2()

  reviews <- page |>
    html_nodes(".a-spacing-small.review-data") |>
    html_text2()

  countries_dates <- page |>
    html_nodes("#cm_cr-review_list .review-date") |>
    html_text2()

  tibble(
    title = titles,
    review = reviews,
    country_date = countries_dates
  )

}

# test function ----------------------------------------------------------------

# page 1
scrape_review("https://www.amazon.com/Yankee-Candle-Large-Apple-Pumpkin/product-reviews/B008P8YTU6/ref=cm_cr_getr_d_paging_btm_next_2?ie=UTF8&reviewerType=all_reviews&pageNumber=1&sortBy=recent")

# page 2
scrape_review("https://www.amazon.com/Yankee-Candle-Large-Apple-Pumpkin/product-reviews/B008P8YTU6/ref=cm_cr_getr_d_paging_btm_next_2?ie=UTF8&reviewerType=all_reviews&pageNumber=2&sortBy=recent")

# page 3
scrape_review("https://www.amazon.com/Yankee-Candle-Large-Apple-Pumpkin/product-reviews/B008P8YTU6/ref=cm_cr_getr_d_paging_btm_next_2?ie=UTF8&reviewerType=all_reviews&pageNumber=3&sortBy=recent")

# create a vector of URLs ------------------------------------------------------

yc_urls <- paste0("https://www.amazon.com/Yankee-Candle-Large-Apple-Pumpkin/product-reviews/B008P8YTU6/ref=cm_cr_getr_d_paging_btm_next_2?ie=UTF8&reviewerType=all_reviews&pageNumber=", 1:10, "&sortBy=recent")
yc_urls

# map function over URLs -------------------------------------------------------

yc_reviews_all <- map_dfr(yc_urls, scrape_review)

# write data -------------------------------------------------------------------

write_csv(yc_reviews_all, file = "data/yc-reviews-all.csv")
