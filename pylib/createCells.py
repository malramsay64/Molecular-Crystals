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
        na += na % 2
        nb = int(nb)
        nb += nb % 2
        if boundary == 1:
            s.replicate(2*na, nb)
        elif boundary == 2:
            s.replicate(na,2*nb)
        else:
            s.replicate(na, nb)
    filename = molecule.getFilename()
    if s.getCrys():
        filename+="-"+s.getCrys()
    if boundary:
        filename+="-"+str(boundary)
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
    shape = args[3]
    r = args[4]
    d = args[5]
    m = getattr(molecule, shape)
    if shape == "Trimer":
        theta = args[6]
        crys = args[7]
        try:
            boundary = int(args[8])
        except IndexError:
            boundary = ''
        s = m(r,d,theta)
    elif shape == "Snowman":
        crys = args[6]
        try:
            boundary = int(args[7])
        except IndexError:
            boundary = ''
        s = m(r,d)

    if len(line) % 3 == 0 and len(line) > 0:
        a = float(line[0])
        b = float(line[1])
        theta = float(line[2])
        molpos = line[3:]
        create(a, b, theta, molpos, s, crys, mols, path, boundary)
