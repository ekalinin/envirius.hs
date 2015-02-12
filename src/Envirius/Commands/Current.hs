module Envirius.Commands.Current where

import Envirius.Util (currentEnv)

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
