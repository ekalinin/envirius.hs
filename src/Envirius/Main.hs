--module Main where

import System.Environment (getArgs)

import Envirius.Commands
import Envirius.Util (getAppName, getAppVersion)


commandNotFound :: String -> IO ()
commandNotFound cmd = putStrLn $ unlines [
        "Error: '" ++ cmd ++ "'command not found.",
        "",
        "Try follow command to get full list of commands:",
        "  " ++ getAppName ++ " --help"
    ]

help :: IO ()
help = putStrLn $ unlines $ [
        getAppName ++ " " ++ getAppVersion,
        "",
        "Commands:"
    ]
    ++ getCommandsDesc ++
    [
        "",
        "Try follow command to get help for certain command:",
        "   " ++ getAppName ++ " <command> --help"
    ]

main :: IO ()
main = do
    rowArgs <- getArgs
    case rowArgs of
        ["--help"] -> help
        (cmdStr:args) ->
            case cmdParse cmdStr of
                Just cmd ->
                    case args of
                        ["--help"] -> cmdShowHelp cmd
                        _          -> cmdAction cmd args
                Nothing -> commandNotFound cmdStr
        _ -> help
