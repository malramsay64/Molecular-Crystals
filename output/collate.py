#!/usr/bin/python

import create
import os
import glob
import sys

if len(sys.argv) == 3:
    prefix = sys.argv[1]
    mol = sys.argv[2]

    create.figure("{prefix}/plots/".format(prefix=prefix), mol+"*.png", "Temperature Dependence")
