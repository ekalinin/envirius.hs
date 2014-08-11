module Envirius.UtilsSpec where

import SpecHelper

spec :: Spec
spec = do
    describe "Util.getAppName" $ do
        it "app name should be 'envirius'" $ do
            getAppName `shouldBe` "envirius"

    describe "Util.getAppVersion" $ do
        it "check version" $ do
            getAppVersion `shouldBe` "0.1.0"

    describe "Util.getPluginName" $ do
        it "getPluginName for empty string" $ do
            getPluginName "" `shouldBe` ""
        it "getPluginName for --rust=0.9" $ do
            getPluginName "--rust=0.9" `shouldBe` "rust"
        it "getPluginName for --go=1.2rc4" $ do
            getPluginName "--go=1.2rc4" `shouldBe` "go"
        it "getPluginName for --python=" $ do
            getPluginName "--python=" `shouldBe` "python"
        it "getPluginName for --erlang=17.0-rc1" $ do
            getPluginName "--erlang=17.0-rc1" `shouldBe` "erlang"
        it "getPluginName for --" $ do
            getPluginName "--" `shouldBe` ""
        it "getPluginName for ' --python=2.7 '" $ do
            getPluginName " --python=2.7 " `shouldBe` "python"
        it "getPluginName for ' --PYTHON=2.7 '" $ do
            getPluginName " --PYTHON=2.7 " `shouldBe` "python"

    describe "Util.getPluginVersion" $ do
        it "getPluginVersion for --rust=0.9" $ do
            getPluginVersion "--rust=0.9" `shouldBe` "0.9"
        it "getPluginVersion for --go=1.2rc4" $ do
            getPluginVersion "--go=1.2rc4" `shouldBe` "1.2rc4"
        it "getPluginVersion for --erlang=17.0-rc1" $ do
            getPluginVersion "--erlang=17.0-rc1" `shouldBe` "17.0-rc1"
        it "getPluginVersion for --erlang" $ do
            getPluginVersion "--erlang" `shouldBe` ""
        it "getPluginVersion for --ERLANG=17.0  " $ do
            getPluginVersion " --ERLANG=17.0  " `shouldBe` "17.0"

main :: IO ()
main = hspec spec
