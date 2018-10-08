# travisCI-macOSx-cython-wheels
Minimal setup for building Cython wheels for MacOSx on travisCI

build status (updated monthly): |Build Status|

The pipeline includes
- Downloading and installing MacPython from https://www.python.org/ftp/python/
  (The Python version has to be specified with the `MAC_PYTHON_VERSION`
  environment variable).
- Building a cython extension for a basic .pyx script (`foo/bar.pyx`)
- Running pytest
- Building a wheel
- Uploading the wheel to GitHub releases



.. |Build Status Linux| image:: http://img.shields.io/travis/paulmueller/travisCI-macOSx-cython-wheels/
   :target: https://travis-ci.org/paulmueller/travisCI-macOSx-cython-wheels/