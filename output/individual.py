import os
import glob
import sys

theta = 0

#out = open("present.out", 'w')

prefix = sys.argv[1]

dirs = glob.glob("{prefix}/*-*-*".format(prefix=prefix))
dirs.sort()
for dir in dirs:
    if len(dir.split("-")) == 5:
        # Trimer
        shape, temp, radius, dist, theta = dir.split("-")
    else:
        # Snowman
        shape, temp, radius, dist = dir.split("-")
    radius = float(radius)
    dist = float(dist)
    f = open("{dir}/mol_pres.tex".format(dir=dir), "rU")
    print f.read()
    f.close()

    
