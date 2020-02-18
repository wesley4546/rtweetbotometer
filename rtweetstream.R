#install.packages("rtweet")
library(rtweet)
library(dplyr)

hashtags <- c("#trump")
streamtime <- 30
filename <- "rtweet.json"


## Stream initalizing
rt <- stream_tweets(q = hastags, timeout = streamtime, file_name = filename, language="en")

# Creates dataframe
rt <- parse_stream("rtweet.json")

clean_rt <- rt %>%
  filter(is_retweet == FALSE, !is.na(hashtags), is_quote == FALSE) %>% 
  select(user_id,screen_name,hashtags,text)

