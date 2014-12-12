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

def create(a, b, theta, x, y, phi, molecule, crys, mols=2500, path='.'):
    s = crys(a,b,theta, x, y, phi, molecule)
    if mols:
        mols /= s.numMols()
        na = sqrt(mols*b/a)
        nb = mols/na
        na = int(na)
        nb = int(nb)
        s.replicate(na, nb)
    print repr(s)
    unitCell.cellFile(s, path)
    unitCell.molFile(s.getMol(), path, s.getCrys())
    unitCell.lammpsFile(s, path)

if __name__ == "__main__":
    args = sys.argv
    line = sys.stdin.readline().split()
    path = '.'
    mols = 2500

    if len(args) == 6 and len(line) == 7:
        theta = float(line[0])
        a = float(line[1])
        b = float(line[2])
        x = float(line[3])
        y = float(line[4])
        phi = float(line[5])
        m = float(line[6])
        
        path = args[1]
        mols = int(args[2])
        r = float(args[3])
        d = float(args[4])
        crys = getattr(unitCell,args[5])

        s = molecule.Snowman(r,d)
       

        phi = pi/2-phi
        conv = -(1**2 +d**2 - r**2)/(2*d)
        
        
        create(a, b, theta, x, y, phi, s, crys, mols, path)
         
