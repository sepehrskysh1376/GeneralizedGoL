#!/bin/bash

# Installing Julia (If you are using )
OS=$(awk '/DISTRIB_ID=/' /etc/*-release | sed 's/DISTRIB_ID=//' | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
VERSION=$(awk '/DISTRIB_RELEASE=/' /etc/*-release | sed 's/DISTRIB_RELEASE=//' | sed 's/[.]0/./')

if [ -z "$OS" ]; then
    OS=$(awk '{print $1}' /etc/*-release | tr '[:upper:]' '[:lower:]')
fi

if [ -z "$VERSION" ]; then
    VERSION=$(awk '{print $3}' /etc/*-release)
fi

if [ $OS == "ubuntu" ]; then
  sudo snap install julia --classic
fi

# Installing the required packages
julia ./install.jl
