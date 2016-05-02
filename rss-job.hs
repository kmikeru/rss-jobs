{-# LANGUAGE OverloadedStrings  #-}
--import Data.List
import Download
import Rss
import Filter
import Data.Configurator

main :: IO ()
main = do
  putStrLn "hello"
  cfg <- load [Required "rss-job.cfg"]
  urls <- require cfg "urllist" :: IO [String]
  filterRegex <- require cfg "filterRegex" :: IO String
  print filterRegex
  l<- download urls
  let feeds = map parseFeed l
  let mergedItems = mergeFeedItems feeds
  let filtered = filterItems mergedItems filterRegex
  showItems filtered

  putStrLn "end"
