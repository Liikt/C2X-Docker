#!/bin/bash

sudo docker run \
    -v %%OMNETDIR%%:%%OMNETDIR%% \
    -v $(pwd):/root/project/ \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$HOME/.Xauthority:/root/.Xauthority:rw" \
    -e DISPLAY \
    -e "TERM=xterm-256color" \
    --net=host \
    -ti \
    c2x:latest /bin/bash