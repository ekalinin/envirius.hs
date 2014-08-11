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

trim :: [Char] -> [Char]
trim = unwords . words

unifyPluginStr :: [Char] -> [Char]
unifyPluginStr s = map toLower $ trim s

getPluginName :: [Char] -> [Char]
getPluginName s =
    takeWhile (/= '=') $ dropWhile (== '-')  $ unifyPluginStr s

getPluginVersion :: [Char] -> [Char]
getPluginVersion s =
    drop 1 $ dropWhile (/= '=') $ unifyPluginStr s
