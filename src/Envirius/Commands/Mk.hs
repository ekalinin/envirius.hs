module Envirius.Commands.Mk where

import Envirius.Types.Env
import Envirius.Util (getAppName)


action :: [String] -> IO ()
action opts = do
    -- TODO: auto activate env
    envExists <- isEnvExists env
    case (envExists, reInstall) of
        -- Environment exists and we should not re-create it
        (True, False) -> putStrLn $ unlines [
                "Environment with name '" ++  (envName env) ++
                                    "' is already exists.",
                "Please, choose another name and try again."]
        -- Environment exists and we should re-create it
        (True, True) -> rmEnv env >> mkEnv env
        -- Just create an environment
        _            -> mkEnv env
  where saveMeta = "--no-meta" `elem` opts
        reInstall = "--force" `elem` opts
        activateAfter = "--on" `elem` opts
        env = parseEnv opts

desc :: String
desc = "Create environment"

usage :: String
usage = "env-name [--plugin=version] [--plugin=version] ..."

help :: [String]
help = [
        "Options:",
        "   --on         Activate environment after installation",
        "   --force      Re-create environment if it already exists",
        "   --no-meta    Don't store meta in environment (plugin list).",
        "",
        "Examples:",
        "   If environment name is empty then it will be ganerated automatically.",
        "   For example:",
        "       $ " ++ getAppName ++" mk --rust=0.9 --erlang=17.0-rc1",
        "",
        "   Will genarate environment with name 'rust-0.9-erlang-17.0-rc1'.",
        "",
        "   To see all available plugins execute:",
        "       $ " ++ getAppName ++ " ls-plugins"
    ]
