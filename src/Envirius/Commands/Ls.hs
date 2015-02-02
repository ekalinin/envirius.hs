module Envirius.Commands.Ls where

import Data.Char (toLower)
import Envirius.Commands.Types
import Envirius.Util (listEnvs, showEnv)


instance Commandable Command where

    -- main command action
    commandAction Ls opts = do
        envs <- listEnvs
        let showMetaInfo = "--no-meta" `notElem` opts
        case length envs of
            0 -> putStrLn "No environments found."
            _ -> do
                putStrLn "Available environment(s):"
                mapM_ (showEnv showMetaInfo) envs

    -- command short name
    commandDesc Ls = "List environments"

    -- help for command
    commandHelp Ls = unlines [
            "Command: " ++ (map toLower $ show Ls),
            "",
            "Options:",
            "   --no-meta      Do not show meta information of the environment"
        ]
