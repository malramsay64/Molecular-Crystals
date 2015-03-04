import os
import glob
import sys
import create

theta = 0

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

print r"\section{{{}}}".format(create.name(prefix))
for filename, text in create.plots:
    create.figure(prefix, filename, text)

