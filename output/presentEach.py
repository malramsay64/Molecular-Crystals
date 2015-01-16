import os
import glob
import sys
import create

theta = 0

prefix = sys.argv[1]
dirs = glob.glob("{prefix}/*-*-*".format(prefix=prefix))

print r"\section{{{}}}".format(create.name(prefix))
for filename, text in create.plots:
    create.figure(prefix, filename, text)

