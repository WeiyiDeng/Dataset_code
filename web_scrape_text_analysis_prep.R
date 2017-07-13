# install.packages("twitteR")
library(twitteR)

consumer_key <- "xn1xWsDrDPBDwTDckdTNMTHtt"
consumer_secret <- "L5BMk4Agdoj86CJE29sq9mdnVaOlUpl0faamsqL2vdctc1veHC"
access_token <- "2201560691-wqSaWaOXFPXgH20i5tZDBRelIOozBS3g2LJOmCP"
access_secret <- "UD8dcl0re4ozofoV6DWtSAcjuwduOPu7lddVy47ImIuyI"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

searchTwitter(searchString='#Trump', n=100, lang='en', since=NULL, until=NULL, locale=NULL, 
              geocode=NULL, sinceID=NULL, maxID=NULL, resultType='recent', retryOnRateLimit=120 )

# install.packages("tm")
library(tm)
