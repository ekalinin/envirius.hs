module Envirius.Types.Command where

import Text.Read (readMaybe)
import Data.Char (toLower, toUpper, isUpper)

import Envirius.Commands.Ls as Ls
import Envirius.Commands.Mk as Mk
import Envirius.Commands.Current as Current
import Envirius.Commands.LsCommands as LsCommands
import Envirius.Util (getAppName, rpad)
import Envirius.TH (listConstructors)

-- | Command type
data Command = Ls
             | Mk
             | Current
             | LsCommands
             deriving (Show, Read)

-- | Returns all constructors for Command type
getCommands :: [String]
getCommands = $(listConstructors ''Command)

-- | Parsed string and returns Command type
readCommand :: String -> Maybe Command
readCommand cmdStr = readMaybe cmdStr'' :: Maybe Command
  where helper x acc
            | x == '-' = [toUpper $ acc !! 0] ++ (drop 1 acc)
            | otherwise = x : acc
        cmdStr' = foldr helper "" cmdStr
        cmdStr'' = [toUpper $ cmdStr' !! 0] ++ drop 1 cmdStr'

showCommand :: Command -> [Char]
showCommand cmd = foldl helper "" cmdStr
  where cmdStr = show cmd
        helper acc x = (if (acc /= "") && (isUpper x)
                            then acc ++ "-"
                            else acc) ++ [toLower x]

-- | Show all commands (Envirius.Commands.*)
showCommands :: [String]
showCommands =
    map (\cmdStr -> "  " ++
            case readCommand cmdStr of
                Just cmd -> (rpad 15 (showCommand cmd)) ++ commandDesc cmd
                Nothing -> cmdStr ++ " -- unknown command")
         getCommands

-- | Type class for Commands
class Commandable c where

    commandAction  :: c -> [String] -> IO()
    commandDesc    :: c -> String
    commandUsage   :: c -> String
    commandHelp    :: c -> IO()

-- | Implementation of the main parts of Commands
instance Commandable Command where

    commandAction Ls = Ls.action
    commandAction Mk = Mk.action
    commandAction Current = Current.action
    commandAction LsCommands = (\_ -> putStrLn $ unlines $ showCommands)

    commandDesc Ls = Ls.desc
    commandDesc Mk = Mk.desc
    commandDesc Current = Current.desc
    commandDesc LsCommands = LsCommands.desc

    commandUsage Ls = Ls.usage
    commandUsage Mk = Mk.usage
    commandUsage Current = Current.usage
    commandUsage LsCommands = LsCommands.usage

    commandHelp cmd = putStrLn $ unlines help'
      where help_cmn = [
                "Usage:       $ " ++ getAppName ++ " "
                                ++ (showCommand cmd) ++ " " ++ (commandUsage cmd),
                "Description: " ++ (commandDesc cmd),
                ""]
            help_cmd = case cmd of
                       Ls -> Ls.help
                       Mk -> Mk.help
                       Current -> Current.help
                       LsCommands -> LsCommands.help
            help' = help_cmn ++ help_cmd


--data Shell = Ksh | Zsh | Sh | Bash | Docker | Lxc
--    deriving (Show, Eq)
