{-# LANGUAGE OverloadedStrings  #-}
import Data.List
import Data.Configurator
import Data.Configurator.Types (Value)
import Download
import Rss

main :: IO ()
main = do
  putStrLn "hello"
  cfg <- load [Required "rss-job.cfg"]
  --lst <- require cfg "urllist" :: IO Value
  lst <- require cfg "urllist" :: IO [String]
  print lst

  l<- mapM downloadURL lst
  let f = map parseFeed l
  mapM_ showItems f
    
  putStrLn "end"
