module Envirius.Commands.Types where

import Envirius.Commands.Ls as Ls
import Envirius.Commands.Mk as Mk
import Envirius.Util (showCmd)

data Command = Ls
             | Mk
             deriving (Show, Read)

class Commandable c where

    commandAction  :: c -> [String] -> IO()
    commandDesc    :: c -> String
    commandHelp    :: c -> IO()


instance Commandable Command where

    commandAction Ls opts = Ls.action opts
    commandAction Mk opts = Mk.action opts

    commandDesc Ls = Ls.desc
    commandDesc Mk = Mk.desc

    commandHelp cmd =
        let help1 = [
                "Command:     " ++ (showCmd cmd),
                "Description: " ++ (commandDesc cmd),
                ""]
            help2 = case cmd of
                       Ls -> Ls.help
                       Mk -> Mk.help
            help' = help1 ++ help2
        in putStrLn $ unlines help'


--data Shell = Ksh | Zsh | Sh | Bash | Docker | Lxc
--    deriving (Show, Eq)
