install.packages("rtweet")
library(rtweet)
library(dplyr)

hashtags <-  ("#WhiteLivesMatter,#WhiteSupremacy,
#WhiteSupremacist,#whitepower,#WhitePride,#WhiteNatalism,#WhitePro,
#mywhiteprivilege,#populationreplacement,#chrislam,#clownworld,#honkhonk")

??rtweet

remove(access_secret)
remove(access_token)
remove(consumer_key)
remove(consumer_secret)

get_tokens()

hastags <- c("#WhiteLivesMatter,#WhiteSupremacy,#WhiteSupremacist,#whitepower, #WhitePride,#WhiteNatalism,#WhitePro,#mywhiteprivilege,#populationreplacement, #chrislam,#clownworld,#honkhonk")
streamtime <- 172800
filename <- "rtweet.json"


## Stream initalizing
rt <- stream_tweets(q = hastags, timeout = streamtime, file_name = filename, language="en")

# Creates dataframe
rt <- parse_stream("rtweet.json")

clean_rt <- rt %>% 
  filter(is_retweet == FALSE, hashtags != is.na(NA)) %>% 
  select(user_id,screen_name,hashtags,text)

