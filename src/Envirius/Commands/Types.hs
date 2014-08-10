module Envirius.Commands.Types where

type Command = Command { name   :: String
                       , action :: [String] -> IO ()
                       , desc   :: String
                       , help   :: [] -> String
                       } deriving (Show)

data Shell = Ksh | Zsh | Sh | Bash | Docker | Lxc
    deriving (Show, Eq)
