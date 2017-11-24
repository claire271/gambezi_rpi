#!/bin/bash

# Install packages
sudo apt-get update
sudo apt-get install -y automake libtool cmake libssl-dev

# Build libuv
wget https://github.com/libuv/libuv/archive/v1.13.1.zip
unzip v1.13.1.zip
rm v1.13.1.zip
cd libuv-1.13.1
./autogen.sh
./autogen.sh
./configure
make
sudo make install
cd ..
rm -rf libuv-1.13.1

# Build libwebsockets
wget https://github.com/warmcat/libwebsockets/archive/v2.3-stable.zip
unzip v2.3-stable.zip
rm v2.3-stable.zip
cd libwebsockets-2.3-stable
mkdir build
cd build
cmake .. -DLWS_WITH_LWSWS=1
make
sudo make install
cd ../..
rm -rf libwebsockets-2.3-stable

# Build gambezi
wget https://github.com/tigerh/gambezi/archive/master.zip
unzip master.zip
rm master.zip
cd gambezi-master
mkdir build
cd build
cmake ..
make
sudo make install
cd ../..
rm -rf gambezi-master

# Configure lwsws
sudo cp -r lwsws /etc/

# Install launcher
cp -r gambezi /home/pi/

# Install init scripts
sudo cp gambezi.sh /etc/init.d/gambezi
sudo update-rc.d gambezi defaults
sudo update-rc.d gambezi enable

# Configure libraries
sudo ldconfig
