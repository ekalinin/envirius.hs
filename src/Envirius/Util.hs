module Envirius.Util where

--import Data.List (takeWhile, dropWhile)
import Data.Char (toLower, toUpper)

import Paths_envirius (version)
import Data.Version (showVersion)

getAppVersion :: String
getAppVersion = showVersion version

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

capitalized :: String -> String
capitalized (x:xs) = toUpper x : map toLower xs
capitalized [] = []
