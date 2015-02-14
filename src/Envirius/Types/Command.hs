module Envirius.Types.Command where

data Cmd = Cmd
         {  cmdName    :: String
         ,  cmdAction  :: [String] -> IO ()
         ,  cmdDesc    :: String
         ,  cmdUsage   :: String
         ,  cmdHelp    :: [String]
         }
