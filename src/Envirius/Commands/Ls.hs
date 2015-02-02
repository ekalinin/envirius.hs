module Envirius.Commands.Ls where

import Data.Char (toLower)
import Data.List (sort)
import System.Directory (getDirectoryContents)
import Envirius.Commands.Types
import Envirius.Util (getEnvRoot, remove, showEnv)


instance Commandable Command where

    -- main command action
    commandAction Ls opts = do
        envs <- getEnvRoot >>= getDirectoryContents
        case length envs of
            0 -> putStrLn "No environments found."
            _ -> do
                putStrLn "Available environment(s):"
                let showMetaInfo = "--no-meta" `notElem` opts
                    envs_clear = sort $ remove "." $ remove ".." envs
                mapM_ (showEnv showMetaInfo) envs_clear

    -- command short name
    commandDesc Ls = "List environments"

    -- help for command
    commandHelp Ls = unlines [
            "Command: " ++ (map toLower $ show Ls),
            "",
            "Options:",
            "   --no-meta      Do not show meta information of the environment"
        ]
