#!/usr/bin/python

import create
import os
import glob
import sys

if len(sys.argv) >= 3:
    prefix = sys.argv[1]
    mol = sys.argv[2]
    if len(sys.argv) > 3:
        exclude=["Snowman", "Trimer"]
        create.collatedEx("{prefix}/plots/".format(prefix=prefix), "*.png", "Temperature Dependence", exclude)
    else:
        create.collated("{prefix}/plots/".format(prefix=prefix), mol+"*.png", "Temperature Dependence")
