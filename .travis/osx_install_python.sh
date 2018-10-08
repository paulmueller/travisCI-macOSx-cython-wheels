#!/bin/bash
set -e

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

alias python="/Library/Frameworks/Python.framework/Versions/${MPV::3}/bin/python"
export PATH="/Library/Frameworks/Python.framework/Versions/${MPV::3}/bin/:$PATH"
echo $PATH

/Library/Frameworks/Python.framework/Versions/${MPV::3}/bin/python --version
python --version

# install latest version of pip
# (avoids [SSL: TLSV1_ALERT_PROTOCOL_VERSION] errors)
curl https://bootstrap.pypa.io/get-pip.py -o ${DLD}/get-pip.py
python ${DLD}/get-pip.py

cd $OLD
