module Envirius.Commands
(
    Cmd(..),
    cmdParse,
    cmdShowHelp,
    getCommandsDesc
)
where

import Data.List (find)
import Envirius.Types.Command
import Envirius.Commands.Ls         as Ls
import Envirius.Commands.Mk         as Mk
import Envirius.Commands.Current    as Current
import Envirius.Commands.LsCommands as LsCommands
import Envirius.Util (getAppName, rpad)

getCommands :: [Cmd]
getCommands = [Ls.cmd, Mk.cmd, Current.cmd,
              -- Replace default action with function from current module.
              -- getCommandsDesc can not be used in Envirius.Commands.LsCommands
              -- as it would be a recursive import
              LsCommands.cmd {cmdAction = (\_ -> putStrLn $ unlines $ getCommandsDesc)}]

cmdParse :: String -> Maybe Cmd
cmdParse cmdStr = find (\x -> cmdName x == cmdStr) getCommands

cmdShowHelp :: Cmd -> IO()
cmdShowHelp x = putStrLn $ unlines helpTxt
  where helpTxt = [
            "Usage:       $ " ++ getAppName ++ " "
                            ++ (cmdName x) ++ " " ++ (cmdUsage x),
            "Description: " ++ (cmdDesc x),
            ""] ++ (cmdHelp x)

getCommandsDesc :: [String]
getCommandsDesc =
    map (\x -> "  " ++ (rpad 15 $ cmdName x) ++ (cmdDesc x)) getCommands
