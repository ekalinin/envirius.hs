module Envirius.Commands.Types where

import Envirius.Commands.Ls as Ls
import Envirius.Commands.Mk as Mk
import Envirius.Util (showCmd)

-- | Command type
data Command = Ls
             | Mk
             deriving (Show, Read)


-- | Type class for Commands
class Commandable c where

    commandAction  :: c -> [String] -> IO()
    commandDesc    :: c -> String
    commandHelp    :: c -> IO()

-- | Implementation of the main parts of Commands
instance Commandable Command where

    commandAction Ls = Ls.action
    commandAction Mk = Mk.action

    commandDesc Ls = Ls.desc
    commandDesc Mk = Mk.desc

    commandHelp cmd = putStrLn $ unlines help'
      where help_cmn = [
                "Command:     " ++ (showCmd cmd),
                "Description: " ++ (commandDesc cmd),
                ""]
            help_cmd = case cmd of
                       Ls -> Ls.help
                       Mk -> Mk.help
            help' = help_cmn ++ help_cmd


--data Shell = Ksh | Zsh | Sh | Bash | Docker | Lxc
--    deriving (Show, Eq)
