{-# LANGUAGE OverloadedStrings  #-}
module Download where
import Network.HTTP.Conduit
--import Data.Maybe
--import Debug.Trace
import qualified Data.ByteString.Lazy.UTF8 as BL

--download::IO [String]
download lst = 
  mapM downloadURL lst

downloadURL::String -> IO String
downloadURL url=do
  resp  <- simpleHttp url
  --putStrLn $ show resp
  --traceIO (show resp)
  --putStrLn $ "body:\n" ++ resp
  let x = BL.toString resp
  return x
