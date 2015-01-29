#!/usr/bin/python

import create
import os
import glob
import sys

if len(sys.argv) > 1:
    prefix = sys.argv[1]
else:
    prefix = ".."

theta = 0

dirs = glob.glob("{prefix}/*-*-*".format(prefix=prefix))
dirs.sort()

create.collated("", "plots/", "Temperature Dependence") 

for filename, caption in create.plots:
    print r"\section{{{text}}}".format(text=caption)
    for d in dirs:
    # Find plots and images in folder
        create.figure(d, filename)

