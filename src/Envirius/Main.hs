--module Main where

import System.Environment (getArgs)
import Text.Read (readMaybe)

import Envirius.Commands.Types
import Envirius.Commands.Ls()
import Envirius.Util (getAppName, getAppVersion, capitalized)


commandNotFound :: IO ()
commandNotFound = putStrLn $ unlines [
        "Command not found.",
        "Try follow command to get full list of commands:",
        "  " ++ getAppName ++ " --help"
    ]

help :: IO ()
help = putStrLn $ unlines [
        getAppName ++ " " ++ getAppVersion,
        "",
        "Commands:",
        "   ls      " ++ (commandDesc Ls),
        "Try follow command to get help for certain command:",
        "   " ++ getAppName ++ " <command> --help"
    ]

main :: IO ()
main = do
    rowArgs <- getArgs
    case rowArgs of
        (cmdStr:args) ->
            case readMaybe $ capitalized cmdStr :: Maybe Command of
                Just cmd -> commandAction cmd args
                Nothing -> commandNotFound
        _ -> help
