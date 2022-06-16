library(tidyverse)
library(rvest)
robotstxt::paths_allowed("https://www.imdb.com/chart/top/")
page <- read_html("https://www.imdb.com/chart/top/")
titles <- page %>%
    html_nodes(".titleColumn a") 
    %>% html_text() 
# .titleColumn is the class & a is the hyperlink 
str(titles)
years <- page %>% 
    html_nodes(".secondaryInfo") %>%
    html_text() %>%
    str_remove("\\(") %>% 
    str_remove("\\)") %>% 
    as.numeric()
# \\ escape character in R ( & ) have special meanings in R
ratings <- page %>% 
    html_nodes("strong") %>% 
    html_text() %>% 
    as.numeric()
imdb_top_250 <- tibble(
    title = titles,
    year = years,
    rating = ratings)
imdb_top_250 %>% 
    group_by(year) %>% 
    summarize (avg_rating = mean(rating)) %>% 
    arrange(desc(avg_rating))
#has to be rating - the column name of the dataframe next to 
# mean()
imdb_top_250 %>% filter(year == 1972)
