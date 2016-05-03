{-# LANGUAGE OverloadedStrings  #-}
--import Data.List
import Download
import Rss
import Filter
import Data.Configurator
import Text.Feed.Export
import qualified Text.XML.Light.Output as XML

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
  let newfeed=exportFeed filtered
  --putStrLn $ show newfeed
  let e=xmlFeed newfeed
  putStrLn $ XML.ppElement e
  putStrLn "end"
