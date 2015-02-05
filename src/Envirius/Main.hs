--module Main where

import System.Environment (getArgs)
import Text.Read (readMaybe)

import Envirius.Types.Command
import Envirius.Util (getAppName, getAppVersion, capitalized)


commandNotFound :: String -> IO ()
commandNotFound cmd = putStrLn $ unlines [
        "Error: '" ++ cmd ++ "'command not found.",
        "",
        "Try follow command to get full list of commands:",
        "  " ++ getAppName ++ " --help"
    ]

help :: IO ()
help = putStrLn $ unlines [
        getAppName ++ " " ++ getAppVersion,
        "",
        "Commands:",
        -- "   ls      " ++ (commandDesc Ls),
        "Try follow command to get help for certain command:",
        "   " ++ getAppName ++ " <command> --help"
    ]

main :: IO ()
main = do
    rowArgs <- getArgs
    case rowArgs of
        ["--help"] -> help
        (cmdStr:args) ->
            case readMaybe $ capitalized cmdStr :: Maybe Command of
                Just cmd -> 
                    case args of
                        ["--help"] -> commandHelp cmd
                        _          -> commandAction cmd args
                Nothing -> commandNotFound cmdStr
        _ -> help
