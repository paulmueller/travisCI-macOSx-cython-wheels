#!/bin/bash
# See: https://github.com/matthew-brett/multibuild/blob/devel/osx_utils.sh
# See: https://www.python.org/downloads/mac-osx/
LATEST_2p7=2.7.15
LATEST_2p6=2.6.6
LATEST_3p2=3.2.5
LATEST_3p3=3.3.5
LATEST_3p4=3.4.4
LATEST_3p5=3.5.4
LATEST_3p6=3.6.6
LATEST_3p7=3.7.0

function fill_pyver {
    # Convert major or major.minor format to major.minor.micro
    #
    # Hence:
    # 2 -> 2.7.11  (depending on LATEST_2p7 value)
    # 2.7 -> 2.7.11  (depending on LATEST_2p7 value)
    local ver=$1
    check_var $ver
    if [[ $ver =~ [0-9]+\.[0-9]+\.[0-9]+ ]]; then
        # Major.minor.micro format already
        echo $ver
    elif [ $ver == 2 ] || [ $ver == "2.7" ]; then
        echo $LATEST_2p7
    elif [ $ver == "2.6" ]; then
        echo $LATEST_2p6
    elif [ $ver == 3 ] || [ $ver == "3.7" ]; then
        echo $LATEST_3p7
    elif [ $ver == "3.6" ]; then
        echo $LATEST_3p6
    elif [ $ver == "3.5" ]; then
        echo $LATEST_3p5
    elif [ $ver == "3.4" ]; then
        echo $LATEST_3p4
    elif [ $ver == "3.3" ]; then
        echo $LATEST_3p3
    elif [ $ver == "3.2" ]; then
        echo $LATEST_3p2
    else
        echo "Can't fill version $ver" 1>&2
        exit 1
    fi
}

# MacPython version
MPV="$(fill_pyver $1)"

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

# install latest version of pip
curl https://bootstrap.pypa.io/get-pip.py -o ${DLD}/get-pip.py
python ${DLD}/get-pip.py

# install virtualenv
python -m pip install virtualenv

# create virtualenv
PP="/Library/Frameworks/Python.framework/Versions/${MPV::3}/bin/python${MPV::3}"
python -m virtualenv --no-site-packages -p $PP .env
source .env/bin/activate

cd $OLD
