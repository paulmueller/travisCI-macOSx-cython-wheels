travisCI-macOSx-cython-wheels
=============================

|Build Status|

It is not straight-forward to build Python wheels for MacOSx on travisCI.
This repository is a minimum-working example with ideas taken from
https://github.com/MacPython/wiki/wiki/Spinning-wheels and
https://github.com/MacPython/wiki/wiki/Wheel-building.
It is also demonstrated how an osx build could coexist with a linux build
on travisCI.


The pipeline includes:

- Downloading and installing MacPython from https://www.python.org/ftp/python/
  (The Python version has to be specified with the `MAC_PYTHON_VERSION=X.Y`
  environment variable in `.travis.yml`).
  I did not use homebrew or macports because python.org provides universal
  (in the sense that they are compatible with all osx versions above 10.6)
  MacPython installers that work on x64 and i386 systems.
- Building a cython extension for a basic .pyx script (`foo/bar.pyx`)
- Running pytest
- Building a wheel
- Using delocate to make the wheel work everywhere
- Uploading the wheel to GitHub releases


Notes:

- All relevant scripts are located in the `.travis` directory.
- The version of the `foo` package is determined from the current git tag and
  wheels are named accordingly.


.. |Build Status| image:: http://img.shields.io/travis/paulmueller/travisCI-macOSx-cython-wheels.svg
   :target: https://travis-ci.org/paulmueller/travisCI-macOSx-cython-wheels/