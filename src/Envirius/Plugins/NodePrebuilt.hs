module Envirius.Plugins.NodePrebuilt where

import Text.Printf (printf)
import System.Info (os, arch)

import Envirius.Types.Plugin


baseUrl = "http://nodejs.org/dist"

downloadUrl version =
    printf "%s/v%s/node-v%s-%s-%s.tar.gz" baseUrl version version os arch

-- listVersions version = do ...

-- build src env do

