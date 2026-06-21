install.packages("httr2")
install.packages("jsonlite")
library(httr2) #Sends a request to the website
library(jsonlite) #Website often sends back data in messy JSON format, jsonlite transforms it into a neat table

response1 <- request ('https://www.propertyguru.com.my/property-for-rent?listingType=rent&page=1&isCommercial=false&_freetextDisplay=maluri+room+for+rent&freetext=maluri+room+for+rent') %>%
  req_headers(`User-Agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36") %>%
  req_perform()

response2 <- request('https://shopee.com.my/search?keyword=t%20shirts%20and%20jerseys')%>%
  req_headers(`User-Agent`= "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36") %>%
  req_perform()

response1 #Checking if information pulled was successful
response2

library(rvest)

page_lazada <- response1 %>% resp_body_html() #Taking the raw response from lazada and turning it into readable HTML format
page_lazada

page_lazada %>% # from the lazada page
  html_nodes("script") %>% # go into 'body', which is the standard name for website
  html_text() %>% #extract all the texts
  cat() #print out all the texts
##Results show that the website runs on JavaScript, have to change to API

mudah_api <- request("https://search.mudah.my/v1/count?category=4000&o=1&type=sell") |>
  req_headers(`User-Agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36") |>
  req_perform()

mudah_api
names(mudah_api)

pg_api <- request("https://www.propertyguru.com.my/property-for-rent?listingType=rent&page=1") |>
  req_headers(
    `User-Agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
    `Accept` = "text/html"
  ) |>
  req_perform()

pg_api

library(rvest)

# Action movies
action <- read_html("https://www.imdb.com/search/title/?genres=action&sort=num_votes,desc&title_type=feature")

# Get movie titles
titles <- action |> html_nodes(".ipc-title__text") |> html_text()
titles

library(rvest)

# Scrape action books (we'll treat categories as "genres")
page1 <- read_html("http://books.toscrape.com/catalogue/category/books/mystery_3/index.html")

# Get book titles
titles <- page1 |> html_nodes("h3 a") |> html_text()
titles

# Get prices
prices <- page1 |> html_nodes(".price_color") |> html_text()
prices

# Get ratings
ratings <- page1 |> html_nodes(".star-rating") |> html_attr("class")
ratings

library(rvest)

# Scrape action books (we'll treat categories as "genres")
page2 <- read_html("https://www.bookxcess.com/?gad_source=1&gad_campaignid=22278265097&gbraid=0AAAAACt4VrDgafeYcsXgWZc779sKt85LP&gclid=CjwKCAjwl97RBhBWEiwAa9rbXX5vV_YSmp-6jQ6bR3Qil5NwrL2hMTK3nCbDDhippYhc-8C35EEWcxoCPkAQAvD_BwE")
names(page2)
# Get book titles
titles <- page2 |> html_nodes("h3 a") |> html_text()
titles


