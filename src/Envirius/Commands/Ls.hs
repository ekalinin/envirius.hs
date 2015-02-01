module Envirius.Commands.Ls where


import System.Directory (getDirectoryContents)
import Envirius.Commands.Types


instance Commandable Command where

    commandAction Ls _opts = do
        envs <- getDirectoryContents "/home/kev/.envirius/envs/"
        print envs

    commandDesc Ls = "List environments"

    commandHelp Ls = "Description: " ++ (show Ls) ++ "\n"
