
# JSON file was created from python .Github link provided below:
# Github repo: https://github.com/computermacgyver/twitter-python
# Output includes Streaming tweets within a 36 hour time span using hashtags:
# “#antiwhite”,“#whitegenocide”,“#WhiteLivesMatter”,“#WhiteSupremacy”,“#WhiteSupremacist”,
# “#whitepower”,“#WhitePride”,“#WhiteNatalism”,“#WhitePro”,“#mywhiteprivilege”,“#populationreplacement”,
# “#chrislam”,“#clownworld”,“#honkhonk”

jsonlite::fromJSON("/Users/dre/Downloads/output.json")
out <- lapply(readLines("/Users/dre/Downloads/output.json"), jsonlite::fromJSON)

# Parse user handles as 'twitterUsers'
# Parse tweet text as 'tweets'
# Parse hashtag used as 'hashtagsUsed'
for(i in seq_along(out)){
  twitterUsers[i] <- out[[i]]$user$screen_name
  tweets[i] <- out[[i]]$text
  hashtagsUsed[i] <- out[[i]][["entities"]][["hashtags"]][1]
}

#' botcheck
#'
#' This function makes a call to the Botomter API and returns the probability that a specified Twitter user is a bot.
#' @param user The Twitter handle you want to check, e.g., "barackobama". The "@" is not required.
#' @keywords Botometer API wrapper
#' @export
#' @examples
#' botcheck("barackobama")

install.packages("devtools")
library(devtools)
install_github("marsha5813/botcheck")
library(botcheck)

library(httr)
library(xml2) 
library(RJSONIO)


# API Keys
Mashape_key = "4f89b8c183msh93244cda1b308d5p195ac2jsncd35a34f81e6"
consumer_key = "CcToLh23y2QmZYdueHVpFH0mH"
consumer_secret = "cTLG3mIlD9rVZLQAdG0SwfNQ5Lhl3Iv4dIume7BODRX7rH4ckW"
access_token = "401771632-KQv6Dc3WpJ76v9gra06x97xQub4PZaEvB5YQW5vT"
access_secret = "2FXa1t4m24nCrta5MdkJHjZ7QMqT1PgUeK5CGq60eMWgm"

myapp = oauth_app("twitter", key=consumer_key, secret=consumer_secret)
sig = sign_oauth1.0(myapp, token=access_token, token_secret=access_secret)

botcheck = function(user) {
  
  users_url = "https://api.twitter.com/1.1/users/show.json?screen_name="
  statuses_url = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name="
  search_url = "https://api.twitter.com/1.1/search/tweets.json?q=%40"
  opts = "&count=200"
  
  # API call to GET user
  userdata = GET(paste0(users_url,user,opts), sig)
  
  # API call to GET tweets
  tweets = GET(paste0(statuses_url,user,opts), sig)
  
  # API call to GET mentions
  mentions = GET(paste0(search_url,user,opts), sig)
  
  
  # Put everything in a list
  body = list(
    timeline = content(tweets, type="application/json"),
    mentions = content(mentions, type="application/json"),
    user = content(userdata, type="application/json")
  )
  
  # Convert to JSON
  body_json = RJSONIO::toJSON(body, auto_unbox = T, pretty = T)
  
  # Make the API request
  result = POST("https://osome-botometer.p.mashape.com/2/check_account",
                encode="json",
                add_headers(`X-Mashape-Key`=Mashape_key),
                body=body_json)
  
  # Parse result
  result = content(result, as = "parsed")
  
  # Return "English" score
  return(result$display_scores$english)
}


# Find botmeter's bot score across all users. Note, total users is over 2,000. 
# botscore <- lapply(twitterUsers, botcheck)

# List of all twitter users
write.csv(twitterUsers, "twitterUsers.csv")

# These are the tags I was assigned. 
needTags <- c("whitegenocide", "WhiteSupremacist", "WhiteNatalism", "populationreplacement", "honkhonk")


aTrying <- ""
# For loop across assigned hashtags
# Some tweets do not have associated hashtags for some reason. A normal for loop will throw an 
# error before ilterating across all tweets. Returns with "integer(0)". This for loop skips tweets without hashtags
for(kj in 1:length(out)){
  if (is.null(out[[kj]][["entities"]][["hashtags"]][["text"]])==TRUE) {
    next
  }
  aTrying[kj] <- (match(out[[kj]][["entities"]][["hashtags"]][["text"]], needTags))
}

# For loop above creates a data frame across all tweets. Indexes with assigned hashtag
indexedHashtags <- which(aTrying != "NA")

AmyUsers <- ""
for(i in indexedHashtags){
  AmyUsers[i] <- (out[[i]]$user$screen_name)
}

# Match assiged hashtags to usernames/twitter handle
bMyUsers <- AmyUsers[which(is.na(AmyUsers) == FALSE)]
# Had emptry first instance
bMyUsers <- bMyUsers[-1]

# Remove duplicates
myUsersFinal <- bMyUsers[which(duplicated(bMyUsers) == FALSE)]
# Botscore of users across assigned hashtag
botscore <- lapply(myUsersFinal, botcheck)


finalBotChecker <- data.frame(unlist(botscore), myUsersFinal)
write.csv(finalBotChecker, "finalBotChecker.csv")
getwd()

# Analysis notes:
# Porn "SissyKatie7"
out[[which((AmyUsers) == "SissyKatie7")]][["entities"]][["hashtags"]][["text"]]

# Porn "headofslytheri1"
out[[which((AmyUsers) == "headofslytheri1")]][["entities"]][["hashtags"]][["text"]]



