#install.packages("rtweet")
library(rtweet)
library(dplyr)

## Collecting

#Parameters
 hashtags <- c("#antiwhite,#WhiteSupremacy,#WhitePride,#mywhiteprivilege,#clownworld")
 streamtime <- 172800
 filename <- "rtweetafterdebate.json"

 #Print time
print(paste("Started at:", format(Sys.time(), "%D, %I:%H %p")))
 
 
# Stream initalizing
rt <- stream_tweets(q = hashtags, timeout = streamtime, file_name = filename, language="en")

 
 
## Cleaning
 
# Creates dataframe
rt <- parse_stream("rtweetafterdebate.json")



clean_rt <- rt %>%
  filter(is_retweet == FALSE, !is.na(hashtags), is_quote == FALSE) %>% 
  select(user_id,screen_name,hashtags,text)
names <- unique(unlist(clean_rt$screen_name))


