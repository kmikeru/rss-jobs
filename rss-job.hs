import Download
import Rss
main :: IO ()
main = do
  putStrLn "hello"
  str<-downloadURL "http://novosibirsk.hh.ru/search/vacancy/rss?clusters=true&enable_snippets=true&specialization=1&area=4"
  --putStrLn str
  let f = parseFeed str
  showItems f
  --parsed<-tryParse
  --putStrLn $ show parsed
  --showItems
  putStrLn "end"
