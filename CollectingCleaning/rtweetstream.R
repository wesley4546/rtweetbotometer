#install.packages("rtweet")
library(rtweet)
library(dplyr)

# #Parameters
# hashtags <- c("#antiwhite,#WhiteSupremacy,#WhitePride,#mywhiteprivilege,#clownworld")
# streamtime <- 86400
# filename <- "rtweet.json"

## Stream initalizing
# rt <- stream_tweets(q = hashtags, timeout = streamtime, file_name = filename, language="en")

2# Creates dataframe
rt <- parse_stream("rtweet.json")




clean_rt <- rt %>%
  filter(is_retweet == FALSE, !is.na(hashtags), is_quote == FALSE) %>% 
  select(user_id,screen_name,hashtags,text)


names <- unique(unlist(clean_rt$screen_name))
