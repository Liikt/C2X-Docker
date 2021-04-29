#!/bin/bash

OMNETDIR=$(pwd)/omnetpp

if [ ! -d "./omnetpp" ]; then
    git clone https://github.com/omnetpp/omnetpp.git
    cp $OMNETDIR/configure.user.dist $OMNETDIR/configure.user
    sed -e "s/WITH_OSGEARTH=yes/WITH_OSGEARTH=no/g" -i $OMNETDIR/configure.user
    grep "stdexcept" $OMNETDIR/src/sim/simtime.cc $> /dev/null || sudo sed -e "s/sstream>/sstream>\n#include <stdexcept>\n#include <limits>/g" -i $OMNETDIR/src/sim/simtime.cc
fi
sed -e "s+%%OMNETDIR%%+$OMNETDIR+g" -i Dockerfile -i ./start_docker.sh -i ./install_omnetpp.sh
sudo docker build . -t c2x