module Envirius.Types.Env where

import Data.List (find)
import Data.Time (getCurrentTime, diffUTCTime)
import System.Directory (createDirectoryIfMissing, removeDirectory)
import System.Directory (doesDirectoryExist)

import Envirius.Types.Plugin
import Envirius.Util (getEnvPath)

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
        mapM_ print  (envPlugins env)
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


parseEnv :: [String] -> Maybe Env
parseEnv xs = find (\x -> (take 2 x) /= "--") xs >>=
    -- create a new environment with just founded name
    (\name -> Just Env {envName = name, envPlugins = []}) >>=
        -- added plugins into environment
        (\env -> Just env {envPlugins = parsePlugins xs})
