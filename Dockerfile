FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y software-properties-common

RUN apt-get install -y unzip vim tmux cmake wget git build-essential python3-dev python3-pip g++ libxerces-c-dev libfox-1.6-dev libgdal-dev libproj-dev libgl2ps-dev swig curl apt-transport-https ca-certificates gnupg lsb-release

# OMNet++
WORKDIR /root
ADD omnetpp %%OMNETDIR%%

WORKDIR %%OMNETDIR%%
RUN pip3 install numpy scipy pandas matplotlib posix_ipc
ENV PATH="%%OMNETDIR%%/bin:${PATH}"
ENV PYTHONPATH="%%OMNETDIR%%/python:${PYTHONPATH}"
ENV HOSTNAME=""
ENV HOST=""
ENV QT_SELECT="5"
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-add-repository universe
RUN apt-get update
RUN apt-get install -y bison flex qt5-default libopenscenegraph-dev openscenegraph-plugin-osgearth openmpi-bin libopenmpi-dev libpcap-dev docker-ce docker-ce-cli containerd.io 
RUN ./configure
RUN make -j`nproc`

# Veins
WORKDIR /root
RUN wget http://veins.car2x.org/download/veins-5.1.zip
RUN unzip veins-5.1.zip
RUN rm veins-5.1.zip
RUN mv veins-veins-5.1 veins

WORKDIR /root/veins
ENV VEINSDIR="/root/veins"
ENV PATH="/root/veins/bin:${PATH}"
RUN ./configure
RUN make -j`nproc`

# Sumo
WORKDIR /root
RUN git clone -b v1_8_0 --recursive https://github.com/eclipse/sumo

WORKDIR /root/sumo
RUN apt install -y cmake python g++ libxerces-c-dev libfox-1.6-dev libgdal-dev libproj-dev libgl2ps-dev swig
ENV SUMO_HOME="/root/sumo"
RUN mkdir -p build/cmake-build

WORKDIR /root/sumo/build/cmake-build
RUN cmake ../..
RUN make -j`nproc`
ENV PATH="/root/sumo/bin:${PATH}"

WORKDIR /root/project
RUN apt install -y gdb gdbserver
RUN wget -O ~/.gdbinit-gef.py -q http://gef.blah.cat/py
RUN echo source ~/.gdbinit-gef.py >> ~/.gdbinit
ENV LC_ALL="en_US.UTF-8"
ENTRYPOINT bash