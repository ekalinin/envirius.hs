module Envirius.Commands.Types where


data Command = Ls deriving (Show, Read)

class Commandable c where

    commandAction  :: c -> [String] -> IO()
    commandDesc    :: c -> String
    commandHelp    :: c -> String

--data Shell = Ksh | Zsh | Sh | Bash | Docker | Lxc
--    deriving (Show, Eq)
