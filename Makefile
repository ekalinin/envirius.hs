build:
	@cabal-dev configure
	@cabal-dev build

tests:
	#@cabal configure --enable-tests
	#@cabal build
	#@cabal test
	@runhaskell -isrc -itest test/Spec.hs
