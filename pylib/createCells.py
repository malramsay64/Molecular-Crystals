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

def create(a, b, theta, x, y, phi, molecule, crys, mols=2500, path='.', boundary=0):
    s = crys(a,b,theta, x, y, phi, molecule)
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

if __name__ == "__main__":
    args = sys.argv
    line = sys.stdin.readline().split()
    path = '.'
    mols = 2500

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
    try:
        boundary = int(args[6])
    except IndexError:
        boundary = ''

    s = molecule.Snowman(r,d)
    phi = 2*pi - phi

    # convert to xy coordinates
    x = x*a + y*b*cos(theta)
    y = y*b*sin(theta)

    # Move center of particle
    const = (1**2 + d**2 - r**2)/(2*d*1)
    x += -(const)*cos(phi)
    y += -(const)*sin(phi)

    # Convert back to fractional coordinates
    x = x/a - y*(cos(theta)/(a*sin(theta)))
    y = y/(b*sin(theta))

    # Convert phi to my orientation
    phi = pi/2+phi
    create(a, b, theta, x, y, phi, s, crys, mols, path, boundary)
