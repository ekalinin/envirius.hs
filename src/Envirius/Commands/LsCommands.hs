module Envirius.Commands.LsCommands where

import Envirius.Types.Command

cmd :: Cmd
cmd = Cmd "ls-commands" action desc usage help

action :: [String] -> IO ()
action _opts = putStrLn "Will be replaced."

-- command short name
desc :: String
desc = "List available commands"

usage :: String
usage = ""

-- help for command
help :: [String]
help = [""]
