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


for dir in dirs:
    f = open("{dir}/mol_pres.tex".format(dir=dir), "rU")
    print f.read()
    f.close()
