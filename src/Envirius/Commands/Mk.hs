module Envirius.Commands.Mk where

import Envirius.Util (getAppName)


action :: [String] -> IO ()
action _opts = putStrLn "Not implemented"

desc :: String
desc = "Create environment"

help :: [String]
help = [
        "Options:",
        "   --on         Activate environment after installation",
        "   --no-meta    Don't store meta in environment (plugin list).",
        "   --force      Re-create environment if it already exists",
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
