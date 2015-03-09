#!/usr/bin/python

import create
import os
import glob
import sys

if len(sys.argv) == 2:
    prefix = sys.argv[1]
    dirs = glob.glob("{prefix}/*-*-*".format(prefix=prefix))
    dirs.sort()
elif len(sys.argv) > 2:
    prefix = sys.argv[1]
    dirs = sys.argv[2:]
else:
    prefix = ".."
    dirs = glob.glob("{prefix}/*-*-*".format(prefix=prefix))
    dirs.sort()

theta = 0

create.collated("", "{prefix}/plots/".format(prefix=prefix), "Temperature Dependence") 

for filename, caption in create.plots:
    print r"\section{{{text}}}".format(text=caption)
    for d in dirs:
    # Find plots and images in folder
        create.figure(d, filename)

