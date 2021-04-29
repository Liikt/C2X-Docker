#!/bin/bash

pushd %%OMNETDIR%%
./configure
make -j`nproc`
make ide -j`nproc`
popd