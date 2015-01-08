import os
import glob
import sys

prefix = sys.argv[1]

dirs = glob.glob("{prefix}/*-*-*".format(prefix=prefix))
dirs.sort()
for dir in dirs:
    f = open("{dir}/mol_pres.tex".format(dir=dir), "rU")
    print f.read()
    f.close()
