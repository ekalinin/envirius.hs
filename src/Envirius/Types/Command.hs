module Envirius.Types.Command where

import Envirius.Commands.Ls as Ls
import Envirius.Commands.Mk as Mk
import Envirius.Util (showCmd, getAppName)

-- | Command type
data Command = Ls
             | Mk
             deriving (Show, Read)


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

    commandDesc Ls = Ls.desc
    commandDesc Mk = Mk.desc

    commandUsage Ls = Ls.usage
    commandUsage Mk = Mk.usage

    commandHelp cmd = putStrLn $ unlines help'
      where help_cmn = [
                "Usage:       " ++ getAppName ++ " "
                                ++ (showCmd cmd) ++ " " ++ (commandUsage cmd),
                "Description: " ++ (commandDesc cmd),
                ""]
            help_cmd = case cmd of
                       Ls -> Ls.help
                       Mk -> Mk.help
            help' = help_cmn ++ help_cmd


--data Shell = Ksh | Zsh | Sh | Bash | Docker | Lxc
--    deriving (Show, Eq)
