# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

setup: libs deps
.PHONY: setup

libs:
	git submodule update --init --recursive
.PHONY: libs

deps:
	pnpm install --frozen-lockfile
.PHONY: deps

build:
	forge build
.PHONY: build

clean:
	forge clean
.PHONY: clean

nuke: clean
	git clean -Xdf
.PHONY: nuke

lint:
	pnpm run lint
.PHONY: lint

test:
	forge test
.PHONY: test

testgas:
	forge test --gas-report
.PHONY: testgas

testfork:
	forge test --fork-url $ETH_NODE
.PHONY: testfork

watch:
	forge test --watch src/
.PHONY: watch

# To initialize a fresh git repo from the contents.
init:
	git init .
	git commit --allow-empty -m "initial empty commit"
	rm -f .gitmodules
	rm -rf lib
	git submodule add git@github.com:foundry-rs/forge-std.git lib/forge-std
	git submodule add git@github.com:OpenZeppelin/openzeppelin-contracts.git lib/openzeppelin
	git submodule add git@github.com:Rari-Capital/solmate.git lib/solmate
.PHONY: init