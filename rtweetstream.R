#install.package("rtweet")
library(rtweet)


# ,#WhiteLivesMatter,#WhiteSupremacy,
# #WhiteSupremacist,#whitepower,#WhitePride,#WhiteNatalism,#WhitePro,
# #mywhiteprivilege,#populationreplacement,#chrislam,#clownworld,#honkhonk")


hastags <- c("starbucks,coffee,trump")
streamtime <- 30
filename <- "rtweet.json"

## Stream 
rt <- stream_tweets(q = hastags, timeout = streamtime, file_name = filename)

