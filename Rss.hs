{-# LANGUAGE PatternGuards, BangPatterns, DeriveDataTypeable, OverloadedStrings, ScopedTypeVariables #-}
module Rss where
import Data.Maybe
import Text.Feed.Import
import Text.Feed.Query
import Text.Feed.Types
import Text.Regex
import Data.Char

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
  let filteredItems=filterSales items
  let titles=map getItemTitle filteredItems
  let t=map ( fromJust ) titles
  mapM (putStrLn) t
  --putStrLn ""

-- строки с совпадениями будут исключены
regexString="телефон|ремонт"::String

filterTitle::String->Bool
filterTitle t= case found of
  Just x -> False
  otherwise -> True
  where found = matchRegex ( mkRegex regexString) t

filterSales::[Item] -> [Item]
filterSales items =
  filter (filterTitle . fromJust . getItemTitle) itemsWithTitle
  where itemsWithTitle= filter (isJust . getItemTitle) items
