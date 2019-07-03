from os.path import exists, dirname, realpath
from setuptools import setup, Extension, find_packages
import sys

# numpy and cython are installed via pyproject.toml [build-system]
import numpy as np

author = "Paul Müller"
authors = [author]
description = 'Example library for building wheels for macOSx on travisCI'
name = 'foo'
year = "2018"


sys.path.insert(0, realpath(dirname(__file__))+"/"+name)
try:
    from _version import version  # @UnresolvedImport
except:
    version = "unknown"

extensions = [Extension("foo.bar",
                        sources=["foo/bar.pyx"],
                        include_dirs=[np.get_include()],
                        )
              ]


setup(
    name=name,
    author=author,
    author_email='dev@craban.de',
    url='https://github.com/paulmueller/travisCI-macOSx-cython-wheels',
    version=version,
    packages=find_packages(),
    package_dir={name: name},
    include_package_data=True,
    license="MIT",
    description=description,
    long_description=open('README.rst').read() if exists('README.rst') else '',
    ext_modules = extensions,
    keywords=["foo-bar"],
    setup_requires=["pytest-runner"],
    tests_require=["pytest"],
    python_requires='>=3.2, <4',
    platforms=['ALL'],
    )
