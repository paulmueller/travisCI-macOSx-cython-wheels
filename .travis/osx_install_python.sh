#!/bin/bash
# MacPython version
MPV="$1"

if [ -z $MPV ]; then
    echo "Please specify Python version in command line!"
    exit 1
fi

# previous directory
OLD="$(pwd)"

# directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR

# download directory
DLD=${DIR}/dl_cache
mkdir -p $DLD

# download MacPython
PKG="python-${MPV}-macosx10.6.pkg"
wget -c -P ${DLD} https://www.python.org/ftp/python/${MPV}/${PKG}

# install MacPython
sudo installer -pkg ${DLD}/${PKG} -target /

export PATH="/Library/Frameworks/Python.framework/Versions/${MPV::3}/bin/:$PATH"

if [ ${MPV::1} == "3" ]; then
    alias mypython=python3
else
    alias mypython=python
fi
mypython --version

# install latest version of pip
# (avoids [SSL: TLSV1_ALERT_PROTOCOL_VERSION] errors)
curl https://bootstrap.pypa.io/get-pip.py -o ${DLD}/get-pip.py
sudo mypython ${DLD}/get-pip.py

sudo mypython -m pip install virtualenv

sudo mypthon -m virtualenv .env

source .env/bin/activate

cd $OLD
