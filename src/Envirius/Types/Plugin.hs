module Envirius.Types.Plugin where


data Plugin = NodePrebuilt {pluginVersion :: String}
            deriving (Show, Read)

class Plugable plugin where

    downloadUrl :: plugin -> String

--    downloadPlugin  :: Env -> Plugin -> IO ()
----    downloadPlugin env plugin = do
--
--    unpackPlugin    :: Env -> Plugin -> IO ()
--    buildPlugin     :: Env -> Plugin -> IO ()
--    copyPluginToEnv :: Env -> Plugin -> IO ()
--    installPlugin   :: Env -> plugin -> IO ()
----    installPlugin env plugin = do



parsePlugins :: [String] -> [Plugin]
parsePlugins _xs = [
        NodePrebuilt {pluginVersion="0.12.0"},
        NodePrebuilt {pluginVersion="0.11.0"}
    ]
