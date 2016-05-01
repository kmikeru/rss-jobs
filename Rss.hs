{-# LANGUAGE PatternGuards, BangPatterns, DeriveDataTypeable, OverloadedStrings, ScopedTypeVariables #-}
module Rss where
import Data.Maybe
import Text.Feed.Import
import Text.Feed.Query
import Text.Feed.Types

tryParse::IO Feed
tryParse  =
  parseFeedFromFile "rss.xml"

parseFeed::String -> Maybe Feed
parseFeed inp =
  parseFeedString inp

showItems::Maybe Feed -> IO [()]
showItems feed = case feed of
  Nothing -> mapM (putStrLn) ["none"]
  Just f ->  do
  --parsed<-tryParse
  let items=feedItems  f
  let titles=map getItemTitle items
  let t=map ( fromJust ) titles
  mapM (putStrLn) t
  --putStrLn ""
