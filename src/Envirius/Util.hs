module Envirius.Util where

import Data.List (takeWhile, dropWhile)
import Data.Char (toLower)

--import Paths_envirius (version)
--import Data.Version (showVersion)

getAppVersion :: String
--getAppVersion = showVersion version
getAppVersion = "0.1.0"

getAppName :: String
getAppName = "envirius"

getPluginName :: [Char] -> [Char]
getPluginName s = takeWhile (/= '=') $ dropWhile (== '-') sl
    where trim = unwords . words
          sl = map toLower $ trim s
