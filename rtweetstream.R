#install.package("rtweet")
library(rtweet)
library(dplyr)

# #WhiteLivesMatter,#WhiteSupremacy,
# #WhiteSupremacist,#whitepower,#WhitePride,#WhiteNatalism,#WhitePro,
# #mywhiteprivilege,#populationreplacement,#chrislam,#clownworld,#honkhonk")

#Hashtags
hastags <- c("#trump")

#Streamtime
streamtime <- 30

#Name of file
filename <- "rtweet.json"

## Stream initalizing
rt <- stream_tweets(q = hastags, timeout = streamtime, file_name = filename, language="en")

# Creates dataframe
rt <- parse_stream("rtweet.json")

clean_rt <- rt %>% 
  filter(is_retweet == FALSE, hashtags != NA) %>% 
  select(user_id,screen_name,hashtags,text)
