module Envirius.Types.Env where

import Data.List (find)
import System.Directory (createDirectoryIfMissing, removeDirectory)
import System.Directory (doesDirectoryExist)
import Envirius.Util (getEnvPath)

data Env = Env { envName        :: String
               , envPlugins     :: [String]
               }

class Envable e where

    mkEnv   :: e -> IO ()
    rmEnv   :: e -> IO ()
    isEnvExists :: e -> IO Bool

instance Envable Env where

    mkEnv env = do
        putStrLn $ "Creating environment " ++ name ++ " ..."
        getEnvPath name >>= createDirectoryIfMissing True
      where name = envName env

    rmEnv env = do
        putStrLn $ "Removing environment " ++ name ++ " ..."
        getEnvPath name >>= removeDirectory
      where name = envName env

    isEnvExists env = do
        getEnvPath name >>= doesDirectoryExist
      where name = envName env

parseEnvName :: [String] -> Maybe Env
parseEnvName opts = find (\x -> (take 2 x) /= "--") opts >>=
    (\name -> Just Env {envName = name, envPlugins = []})
