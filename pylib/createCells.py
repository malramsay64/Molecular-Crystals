#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2014 malcolm <malcolm@asaph-VirtualBox>
#
# Distributed under terms of the MIT license.

"""

"""
import unitCell
import molecule
from math import *
import sys

def create(a, b, theta, molpos, molecule, crys, mols=2500, path='.', boundary=0):
    s = unitCell.cell(a,b,theta, molpos, molecule, crys)
    if mols:
        mols /= s.numMols()
        na = sqrt(mols*b/a)
        nb = mols/na
        na = int(na)
        nb = int(nb)
        if boundary == 1:
            s.replicate(2*na, nb)
        elif boundary == 2:
            s.replicate(na,2*nb)
        else:
            s.replicate(na, nb)
    filename = "{shape} {radius} {distance} {theta} {crys} {bound}".format(shape=molecule.getName(), radius=molecule.getRadius(), distance=molecule.getDist(), theta=molecule.getTheta(), crys=s.getCrys(), bound=boundary)
    filename = "-".join([x for x in filename.split() if x])
    unitCell.cellFile(s, path, filename)
    unitCell.molFile(s.getMol(), path, s.getCrys())
    unitCell.lammpsFile(s, path, filename)

    f = open('{PATH}/{filename}-mol.dat'.format(PATH=path,filename=s.getMol().getFilename()),'w')
    f.write(str(s.getMol()))
    f.close()

if __name__ == "__main__":
    args = sys.argv
    line = sys.stdin.readline().split()
    path = '.'
    mols = 2500


    path = args[1]
    mols = int(args[2])
    r = float(args[3])
    d = float(args[4])
    crys = args[5]
    try:
        boundary = int(args[6])
    except IndexError:
        boundary = ''
    s = molecule.Snowman(r,d)
    
    print len(line)
    if len(line) % 3 == 0 and len(line) > 0:
        a = float(line[0])
        b = float(line[1])
        theta = float(line[2])
        molpos = line[3:]
        create(a, b, theta, molpos, s, crys, mols, path, boundary)
