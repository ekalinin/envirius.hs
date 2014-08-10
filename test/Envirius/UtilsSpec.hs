module Envirius.UtilsSpec where

import SpecHelper

spec :: Spec
spec = do
  describe "Utils" $ do
    it "app name should be 'envirius'" $ do
      getAppName `shouldBe` "envirius"
    it "check version" $ do
      getAppVersion `shouldBe` "0.1.0"
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

main :: IO ()
main = hspec spec
