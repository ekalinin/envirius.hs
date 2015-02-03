module Envirius.Commands.Types where

import Envirius.Commands.Ls as Ls
import Envirius.Util (showCmd)

data Command = Ls deriving (Show, Read)

class Commandable c where

    commandAction  :: c -> [String] -> IO()
    commandDesc    :: c -> String
    commandHelp    :: c -> IO()


instance Commandable Command where

    commandAction Ls opts = Ls.action opts

    commandDesc Ls = Ls.desc

    commandHelp cmd =
        let help1 = [
                "Command:     " ++ (showCmd cmd),
                "Description: " ++ (commandDesc cmd),
                ""]
            help2 = case cmd of
                       Ls -> Ls.help
            help' = help1 ++ help2
        in putStrLn $ unlines help'


--data Shell = Ksh | Zsh | Sh | Bash | Docker | Lxc
--    deriving (Show, Eq)
