#!/usr/bin/env python
# -*- coding: utf-8 -*-
from os.path import exists, dirname, realpath
from setuptools import setup, Extension, find_packages
import sys

author = u"Paul Müller"
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
    setup_requires=['cython', 'pytest-runner'],
    tests_require=["pytest"],
    platforms=['ALL'],
    )
