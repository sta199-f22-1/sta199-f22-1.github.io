# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)
library(lubridate)
library(robotstxt)

# check that we can scrape -----------------------------------------------------

paths_allowed("https://www.amazon.com")

# read page --------------------------------------------------------------------

page <- read_html("https://www.amazon.com/Yankee-Candle-Large-Apple-Pumpkin/product-reviews/B008P8YTU6/ref=cm_cr_arp_d_paging_btm_next_2?ie=UTF8&reviewerType=all_reviews&pageNumber=1")

# parse reviews ----------------------------------------------------------------

titles <- page |>
  html_nodes(".a-text-bold span") |>
  html_text()

reviews <- page |>
  html_nodes(".review-text-content span") |>
  html_text()

countries_dates <- page |>
  html_nodes("#cm_cr-review_list .review-date") |>
  html_text()

yc_reviews_1 <- tibble(
  title = titles,
  review = reviews,
  country_date = countries_dates
)

# function: scrape_review ---------------------------------------------------------------
# input: url
# output: a data frame with 10 reviews from a page

scrape_review <- function(url){

  page <- read_html(url)

  titles <- page |>
    html_nodes(".a-text-bold span") |>
    html_text()

  reviews <- page |>
    html_nodes(".review-text-content span") |>
    html_text()

  countries_dates <- page |>
    html_nodes("#cm_cr-review_list .review-date") |>
    html_text()

  tibble(
    title = titles,
    review = reviews,
    country_date = countries_dates
  )

}

# test function ----------------------------------------------------------------

# page 1
scrape_review("https://www.amazon.com/Yankee-Candle-Large-Apple-Pumpkin/product-reviews/B008P8YTU6/ref=cm_cr_arp_d_paging_btm_next_2?ie=UTF8&reviewerType=all_reviews&pageNumber=1")

# page 2
scrape_review("https://www.amazon.com/Yankee-Candle-Large-Apple-Pumpkin/product-reviews/B008P8YTU6/ref=cm_cr_arp_d_paging_btm_next_2?ie=UTF8&reviewerType=all_reviews&pageNumber=2")

# page 3
scrape_review("https://www.amazon.com/Yankee-Candle-Large-Apple-Pumpkin/product-reviews/B008P8YTU6/ref=cm_cr_arp_d_paging_btm_next_2?ie=UTF8&reviewerType=all_reviews&pageNumber=3")

# create a vector of URLs ------------------------------------------------------

yc_urls <- paste0("https://www.amazon.com/Yankee-Candle-Large-Apple-Pumpkin/product-reviews/B008P8YTU6/ref=cm_cr_arp_d_paging_btm_next_2?ie=UTF8&reviewerType=all_reviews&pageNumber=", 1:10)
yc_urls

# map function over URLs -------------------------------------------------------

yc_reviews_all <- map_dfr(yc_urls, scrape_review)

# write data -------------------------------------------------------------------

write_csv(yc_reviews_all, file = "data/yc-reviews-all.csv")
