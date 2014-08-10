module Envirius.Commands.Mk where

import Envirius.Util (getAppName)

-- ------------------------------------------------------------------
-- Action
-- ------------------------------------------------------------------
action :: [String] -> IO ()
action [_options] = do
        putStrLn "Mk: action ..."
action _ = do
        putStrLn "Mk: wrong number of arguments"
        putStrLn ""
        putStrLn $ help


-- ------------------------------------------------------------------
-- Desc
-- ------------------------------------------------------------------
desc :: String
desc = "Create environment"


-- ------------------------------------------------------------------
-- Help
-- ------------------------------------------------------------------
help :: String
help = help' []

help' :: [String] -> String
help' [appName, cmdName] = unwords [
            appName ++ " " ++ cmdName ++ " <envName>",
            "--<plugin>=<version> [--<plugin>=<version>]",
            "[--on]",
            "[--no-meta]",
            "[--force]"
       ]
help' [cmdName] = help' [getAppName, cmdName]
help' _         = help' [getAppName, "mk"]
