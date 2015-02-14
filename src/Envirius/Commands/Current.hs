module Envirius.Commands.Current where

import Envirius.Types.Command
import Envirius.Util (currentEnv)

cmd :: Cmd
cmd = Cmd "current" action desc usage help

-- main command action
action :: [String] -> IO ()
action _opts = currentEnv >>= (\x -> case x of
                                        Just envName -> putStrLn envName 
                                        _ -> return ())

-- command short name
desc :: String
desc = "Current activated environment's name"

usage :: String
usage = ""

-- help for command
help :: [String]
help = [""]
