init:
	@cabal sandbox init

build:
	@cabal configure
	@cabal build

tests:
	#@cabal configure --enable-tests
	#@cabal build
	#@cabal test
	@runhaskell -isrc -itest test/Spec.hs
