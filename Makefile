init:
	@cabal sandbox init

build:
	@cabal configure
	@cabal build

shell:
	@cabal repl

tests:
	#@cabal configure --enable-tests
	#@cabal build
	#@cabal test
	@runhaskell -isrc -itest test/Spec.hs

loc1:
	@find ./src/ -type f | xargs wc -l

loc2:
	@sloccount ./src

loc3:
	@cloc ./src/
