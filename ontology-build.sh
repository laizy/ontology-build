#!/usr/bin/env bash

set -ex

if ! which rustup ; then
	curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable
	source $HOME/.cargo/env
fi

git clone https://github.com/ontio/ontio-wasmjit
cd ontio-wasmjit/wasmjit-onto-interface

cargo build --release

cd ../../
git clone https://github.com/ontio/ontology
cp ontio-wasmjit/target/release/libwasmjit_onto_interface* ontology/smartcontract/service/wasmvm

cd ontology
make ontology
