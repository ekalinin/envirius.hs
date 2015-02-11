module Envirius.Types.Env where

import Data.List (find)
import Data.Time (getCurrentTime, diffUTCTime)
import System.Directory (createDirectoryIfMissing, removeDirectory)
import System.Directory (doesDirectoryExist)

import Envirius.Types.Plugin
import Envirius.Util (getEnvPath, replace)

data Env = Env { envName        :: String
               , envPlugins     :: [Plugin]
               }
               deriving (Show, Read)

class Envable e where

    mkEnv   :: e -> IO ()
    rmEnv   :: e -> IO ()
    isEnvExists :: e -> IO Bool


instance Envable Env where

    mkEnv env = do
        startDt <- getCurrentTime
        putStrLn $ "Creating environment " ++ name ++ " ..."
        getEnvPath name >>= createDirectoryIfMissing True
        --map (installPlugin env) (envPlugins env)
        --mapM_ print  (envPlugins env)
        stopDt <- getCurrentTime
        putStrLn $ " * done (in " ++ (show $ diffUTCTime stopDt startDt)
                                  ++ ")."
      where name = envName env

    rmEnv env = do
        putStrLn $ "Removing environment " ++ name ++ " ..."
        getEnvPath name >>= removeDirectory
      where name = envName env

    isEnvExists env = do
        getEnvPath name >>= doesDirectoryExist
      where name = envName env


parseEnv :: [String] -> Env
parseEnv xs = Env {envName = name, envPlugins = plugins}
  where plugins = parsePlugins xs
        name = case find (\x -> (take 2 x) /= "--") xs of
                   Just name' -> name'
                   Nothing -> generateEnvName xs

generateEnvName :: [String] -> String
generateEnvName = foldl helper ""
  where formatName x = dropWhile (== '-') (replace '=' '-' x)
        helper "" x  = formatName x
        helper acc x = acc ++ "-" ++ (formatName x)
