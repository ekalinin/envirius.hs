module Main where

import System.Environment (getArgs)

import Envirius.Commands.Mk as Mk
import Envirius.Util (getAppName, getAppVersion)

-- activate/deactivate environment
dispatch :: String -> [String] -> IO ()
-- dispatch "activate"     = on
-- dispatch "on"           = on
-- dispatch "use"          = on
-- 
-- dispatch "deactivate"   = off
-- dispatch "off"          = off
-- 
-- dispatch "autoon"       = autoon
-- 
-- -- environments actions
-- dispatch "cp"           = cp
-- dispatch "copy"         = cp
-- dispatch "current"      = current
-- dispatch "do-in"        = doIn
-- dispatch "ls"           = ls
-- dispatch "list"         = ls
dispatch "mk"           = Mk.action
-- dispatch "create"       = mk
-- dispatch "mv"           = mv
-- dispatch "move"         = mv
-- dispatch "rm"           = rm
-- dispatch "remove"       = rm
-- 
-- -- cache
-- dispatch "rm-cache"     = rmCache
-- dispatch "ls-cache"     = lsCache
-- 
-- -- plugins
-- dispatch "ls-plugins"   = lsPlugins
-- dispatch "ls-versions"  = lsVersions
-- 
-- -- others
-- dispatch "ls-commands"  = lsCommands
-- dispatch "version"      = version
dispatch "--help" = do
    \ _ -> (
        let appName = getAppName
            appVersion = getAppVersion
            helpTxt = [
                        appName ++ " " ++ appVersion,
                        "",
                        "Usage: ",
                        "  " ++ Mk.help
                      ]
        in putStrLn $ unlines helpTxt
           )
dispatch _ = do
    \ _ -> (
           putStrLn $ unlines [
                "Command not found.",
                "Try follow command to get full list of commands:",
                "  " ++ getAppName ++ " --help"
            ]
           )

main :: IO ()
main = do
    (command:argList) <- getArgs
    dispatch command argList
