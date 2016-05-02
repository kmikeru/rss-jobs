{-# LANGUAGE PatternGuards, BangPatterns, DeriveDataTypeable, OverloadedStrings, ScopedTypeVariables #-}
module Rss where
import Data.Maybe
import Text.Feed.Import
import Text.Feed.Query
import Text.Feed.Types
import Data.List
--import Text.Regex
--import Data.Char

tryParse::IO Feed
tryParse  =
  parseFeedFromFile "rss.xml"

parseFeed::String -> Maybe Feed
parseFeed inp =
  parseFeedString inp

showItem::Item -> IO ()
showItem item = case title of
  Nothing -> putStrLn "none"
  Just f -> putStrLn (f++" "++itemid)
  where  title = getItemTitle item
         itemid = snd $ fromJust (getItemId item)

showItems::[Item] -> IO ()
showItems items =
  mapM_ showItem items

showFeed::Maybe Feed -> IO ()
showFeed feed = case feed of
  Nothing -> putStr ""
  Just f ->  do
  let items=feedItems  f
  showItems items

mergeFeedItems::[Maybe Feed] ->[Item]
mergeFeedItems feeds =
  nub $ concat (map (feedItems . fromJust ) feeds)

instance Eq Item where
        (==) a b = getItemId a == getItemId b
