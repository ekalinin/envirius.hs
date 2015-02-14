module Envirius.Commands.Ls where

import Envirius.Types.Command
import Envirius.Util (listEnvs, showEnv)

cmd :: Cmd
cmd = Cmd "ls" action desc usage help

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

usage :: String
usage = "env-name [--plugin=version] [--plugin=version] ..."

-- help for command
help :: [String]
help = [
        "Options:",
        "   --no-meta      Do not show meta information of the environment"
    ]
