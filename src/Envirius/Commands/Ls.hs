module Envirius.Commands.Ls where

import Envirius.Util (listEnvs, showEnv, showCmd)

-- main command action
action :: [String] -> IO ()
action opts = do
    envs <- listEnvs
    let showMetaInfo = "--no-meta" `notElem` opts
    case length envs of
        0 -> putStrLn "No environments found."
        _ -> do
            putStrLn "Available environment(s):"
            mapM_ (showEnv showMetaInfo) envs

-- command short name
desc :: String
desc = "List environments"

-- help for command
help :: [String]
help = [
        "Options:",
        "   --no-meta      Do not show meta information of the environment"
    ]
