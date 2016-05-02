{-# LANGUAGE PatternGuards, BangPatterns, DeriveDataTypeable, OverloadedStrings, ScopedTypeVariables #-}
module Filter where
import Data.Maybe
import Text.Feed.Types
import Text.Feed.Query
import Text.Regex
import Data.Char
import Data.Configurator
-- строки с совпадениями будут исключены
--regexString="телефон|ремонт"::String
--regexString :: IO String

filterTitle::String->String->Bool
filterTitle t regexString = case found of
    Just x -> False
    otherwise -> True
    where found = matchRegex ( mkRegex regexString) t

filterItems::[Item] -> String -> [Item]
filterItems items regexString =
    filter (\x -> filterTitle (fromJust $ getItemTitle x) regexString) itemsWithTitle
    where itemsWithTitle= filter (isJust . getItemTitle) items
