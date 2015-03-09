#!/usr/bin/python

import sys
import glob
import os

def collate(prefix, dir, shape, f=0):
    contact = open('{dir}/contact.log'.format(dir=dir), 'r')
    T = dir.split("-")[1]
    if not f:
        f = open('{prefix}/plots/{shape}.csv'.format(shape=shape, prefix=prefix), 'w')
        f.write("T")
        for line in contact:
            f.write("," + line.split(":")[0].strip())
        f.write("\n")
        contact = open('{dir}/contact.log'.format(dir=dir), 'r')
    f.write(T)
    for line in contact:
        if ':' in line:
            f.write("," + line.split(":")[1].strip())
    f.write("\n")
    return f

if __name__ == "__main__":
    #print sys.argv[1]
    if len(sys.argv) == 2:
        s = sys.argv[1].split("-")
        s.insert(1,"*")
        s = "-".join(s)
        shape_dirs = sorted(glob.glob(s))
        f = 0
        for d in shape_dirs:
            f = collate(os.path.dirname(sys.argv[1]), d, os.path.basename(sys.argv[1]), f)
