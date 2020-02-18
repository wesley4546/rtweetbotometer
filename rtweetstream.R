#install.package("rtweet")
library(rtweet)


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
rt <- stream_tweets(q = hastags, timeout = streamtime, file_name = filename)

# Creates dataframe
rt <- parse_stream("rtweet.json")



