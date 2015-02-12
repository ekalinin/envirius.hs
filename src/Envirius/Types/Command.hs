module Envirius.Types.Command where

import Text.Read (readMaybe)

import Envirius.Commands.Ls as Ls
import Envirius.Commands.Mk as Mk
import Envirius.Commands.Current as Current
import Envirius.Util (showCmd, getAppName, capitalized)
import Envirius.TH (listConstructors)

-- | Command type
data Command = Ls
             | Mk
             | Current
             deriving (Show, Read)

getCommands :: [String]
getCommands = $(listConstructors ''Command)

parseCommand :: String -> Maybe Command
parseCommand cmdStr = readMaybe $ capitalized cmdStr :: Maybe Command

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

    commandDesc Ls = Ls.desc
    commandDesc Mk = Mk.desc
    commandDesc Current = Current.desc

    commandUsage Ls = Ls.usage
    commandUsage Mk = Mk.usage
    commandUsage Current = Current.usage

    commandHelp cmd = putStrLn $ unlines help'
      where help_cmn = [
                "Usage:       $ " ++ getAppName ++ " "
                                ++ (showCmd cmd) ++ " " ++ (commandUsage cmd),
                "Description: " ++ (commandDesc cmd),
                ""]
            help_cmd = case cmd of
                       Ls -> Ls.help
                       Mk -> Mk.help
                       Current -> Current.help
            help' = help_cmn ++ help_cmd


--data Shell = Ksh | Zsh | Sh | Bash | Docker | Lxc
--    deriving (Show, Eq)
