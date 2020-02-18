install.packages("rtweet")
library(rtweet)


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

## Stream 
rt <- stream_tweets(q = hastags, timeout = streamtime, file_name = filename)


