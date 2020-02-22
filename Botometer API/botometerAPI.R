
#' botcheck
#'
#' This function makes a call to the Botomter API and returns the probability that a specified Twitter user is a bot.
#' @param user The Twitter handle you want to check, e.g., "barackobama". The "@" is not required.
#' @keywords Botometer API wrapper
#' @export
#' @examples
#' botcheck("barackobama")

#install.packages("devtools")
library(devtools)
#install_github("marsha5813/botcheck")
library(botcheck)
library(httr)
library(xml2) 
library(RJSONIO)
library(rtweet)
library(dplyr)
library(ggplot2)


#Twitter/Botometer API Keys
Mashape_key = "4f89b8c183msh93244cda1b308d5p195ac2jsncd35a34f81e6"
consumer_key = "CcToLh23y2QmZYdueHVpFH0mH"
consumer_secret = "cTLG3mIlD9rVZLQAdG0SwfNQ5Lhl3Iv4dIume7BODRX7rH4ckW"
access_token = "401771632-KQv6Dc3WpJ76v9gra06x97xQub4PZaEvB5YQW5vT"
access_secret = "2FXa1t4m24nCrta5MdkJHjZ7QMqT1PgUeK5CGq60eMWgm"

#Connecting to botometer API
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

setwd("~//Documents//GitHub//rtweetbotometer")
tweets <- parse_stream("Data/rtweet.json")

clean_rt <- tweets %>%
  filter(is_retweet == FALSE, !is.na(hashtags), is_quote == FALSE) %>% 
  select(user_id,screen_name,hashtags,text)

names <- unique(unlist(clean_rt$screen_name))



botcheck("AndrewS78530059")

usernames <- names


scored_names <- lapply(names[1:88],botcheck) #took about ~7 minutes


  
scored <- data.frame(usernames= usernames[c(-9)],
                     scores= unlist(scored_names))


scored_sorted <- scored %>% 
  arrange(scores)


densityplot <- ggplot(scored_sorted, aes(x=scores))  +
  geom_histogram(aes(y=..density..), binwidth = .25, fill = "#F8923A", color = "black" ) +
  geom_density(fill="#3AA0F8",alpha = .3, color = "black") +
  ggtitle("Density plot of botometer scores")
densityplot


scored_sorted_coded <- read.csv("scored_sorted_coded.csv")


cor(scored_sorted_coded$bot,scored_sorted_coded$botometer)

data.frame(botometerbot = )





