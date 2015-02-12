module Envirius.Util where

import System.FilePath.Posix((</>))
import System.Directory (getHomeDirectory, doesFileExist)
import System.Directory (getDirectoryContents)
import System.Environment (lookupEnv)
import Data.Maybe (fromMaybe)
import Data.Char (toLower, toUpper)
import Data.List (sort)

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

currentEnv :: IO (Maybe String)
currentEnv = lookupEnv "NV_USED_ENV"

getRoot :: IO FilePath
getRoot = do
    -- http://www.christopherbiscardi.com/2014/02/06/environment-variables-in-haskell/
    home <- getHomeDirectory
    nv_home <- lookupEnv "NV_HOME"
    return $ fromMaybe (home </> ".envirius") nv_home

getEnvRoot :: IO FilePath
getEnvRoot = do
    nv_home <- getRoot
    return $ nv_home </> "envs"

listEnvs :: IO [String]
listEnvs = do
    envs <- getEnvRoot >>= getDirectoryContents
    return $ sort $ remove "." $ remove ".." envs

getEnvPath :: String -> IO FilePath
getEnvPath envName = do
    nv_envs_root <- getEnvRoot
    return $ nv_envs_root </> envName

getEnvMetaFilePath :: String -> IO FilePath
getEnvMetaFilePath envName = do
    env_root <- getEnvPath envName
    return $ env_root </> "envirius.info"

getEnvMetaInfo :: String -> IO String
getEnvMetaInfo envName = do
    metaFile <- getEnvMetaFilePath envName
    isExists <- doesFileExist metaFile
    case isExists of
        True -> readFile metaFile
        False -> return ""

showEnv :: Bool -> String -> IO ()
showEnv showMeta envName = do
    meta <- getEnvMetaInfo envName
    let meta' = remove '\n' meta
    case showMeta of
        True -> do
            case length meta' of
                0 -> putStrLn envName
                _ -> putStrLn (envName ++ " (" ++ meta' ++ ")")
        False -> putStrLn envName

remove :: Eq t => t -> [t] -> [t]
remove r s = [c | c <- s, c /= r]

replace src dst s = [if c == src then dst else c | c <- s]

showCmd :: Show a => a -> [Char]
showCmd c = map toLower $ show c
