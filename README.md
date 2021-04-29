# Note

This is horribly hacky and I know that. If you know Docker feel free to improve
the Dockerfile and make use of builder images and stuff. For now this should
work :tm:

Use at own risk.

Currently this only works on Linux which uses the X server. Theoretically this
also works for MacOS [0] and Windows [1].

This was build for the C2X Labs of TKN at TU Berlin.

[0] https://medium.com/@mr.sahputra/running-qt-application-using-docker-on-macos-x-ad2e9d34532a

[1] https://dev.to/darksmile92/run-gui-app-in-linux-docker-container-on-windows-host-4kde


## Noteworthy Findings

Sumo has been pinned to Version `1.8.0` because the master branch would not work.

The `simtime.cc` of omnetpp has to be patched.

The Omnetpp IDE uses a docker container as a build environment so for now we
have to live with docker in docker and forwarding the host docker daemon inside
the container.

# Installation

First run the `./build_docker.sh` script. After the image is build start it with
`./start_docker.sh`. Then run the `./install_omnetpp.sh` once to install omnet++
and the ide.

# Usage

Just start the docker container with `./start_docker.sh`. For better experience
start a tmux session inside the docker container.
