#! /usr/bin/python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2014 malcolm <malcolm@asaph-VirtualBox>
#
# Distributed under terms of the MIT license.

"""

"""
import molecule
from copy import deepcopy as copy
from math import *

class cell:

    def __init__(self, a, b, theta, molpos, mol, crys):
        self.a = a
        self.b = b
        self.theta = theta
        self.mol = mol
        self.crys = crys
        self.mols = []
        index = 0
        while index < len(molpos):
            x,y,phi = [float(i) for i in molpos[index:index+3]]
            if mol.getName() == "Snowman":
                const = (1*1 + mol.getDist()*mol.getDist() - mol.getRadius()*mol.getRadius())/(2*mol.getDist()*1)
                x += -(const)*cos(phi)
                y += -(const)*sin(phi)
                phi += pi/2
            if mol.getName() == "Trimer":
                phi += pi
            self.addMol(x, y, phi)
            index += 3

    def addParticle(self,x,y,phi):
        d = self.mol.dist
        r = self.mol.radius
        m = copy(self.mol)
        m.setAngle(phi*180/pi)
        m.setPos(x,y)
        self.mols.append(m)

    def addMol(self, x, y, phi):
        self.addParticle(x,y,phi)

    def getHeight(self):
        return self.b*sin(self.theta)

    def getMol(self):
        return self.mol

    def getMols(self):
        return self.mols

    def numMols(self):
        return len(self.mols)

    def numAtoms(self):
        return len(self.mols)*self.mol.numAtoms()

    def getShape(self):
        return self.a, self.b, self.theta

    def getCrys(self):
        return self.crys

    def getA(self):
        return self.a

    def getB(self):
        return self.b

    def getTheta(self):
        return self.theta

    def to_fractional(self,x,y):
        x = x/self.getA() - y*(cos(self.getTheta())/(self.getA()*sin(self.getTheta())))
        y = y/self.getB()*sin(self.getTheta())
        return x,y

    def to_cartesian(self,x,y):
        x = x*self.getA() + y*sef.getB()*cos(self.getTheta())
        y = y*self.getB()*sin(self.getTheta())
        return x,y

    def replicate(self, nx=1, ny=1):
        base = self.getMols()
        new = []
        a,b,theta = self.getShape()
        for i in xrange(nx):
            for j in xrange(ny):
                for mol in base:
                    mnew = copy(mol)
                    mnew.translate(i*a + j*b*cos(theta), j*self.getHeight())
                    new.append(mnew)

        self.a = nx*a
        self.b = ny*b
        self.mols = new

    def __str__(self):
        mid = 1
        aid = 1
        s = ""
        for mol in self.getMols():
            mx,my = mol.COM()
            mx2,my2 = wrap(mx,my,self.getA(),self.getHeight(),self.getB()*cos(self.getTheta()))
            mol.translate(mx2-mx,my2-my)
            taid = 1
            for atom in mol:
                x,y = atom.getPos()
                s += "{aid} {mid} {tid} {taid} {atype} {x} {y} {z}\n"\
                        .format(aid=aid, mid=mid, tid=1,\
                        taid=taid, atype=atom.getType(),\
                        x=x, y=y, z = 0)
                aid += 1
                taid += 1
            mid += 1
        return s

    def __repr__(self):
        xy = self.b*cos(self.theta)
        s = ""
        s += "0,0\n"
        s += "{a},0\n\n".format(a=self.a)
        s += "0,0\n"
        s += "{xy},{b}\n\n".format(xy=xy, b=self.getHeight())
        s += "{xy},{b}\n".format(xy=xy, b=self.getHeight())
        s += "{a},{b}\n\n".format(a=self.a+xy, b=self.getHeight())
        s += "{a},0\n".format(a=self.a)
        s += "{a},{b}\n\n".format(a=self.a+xy, b=self.getHeight())
        for mol in self.mols:
            for atom in mol:
                x,y = atom.getPos()
                x,y = wrap(x,y,self.getA(),self.getHeight(),xy)
                s += "{x}, {y}, {size}\n".format(x=x,y=y,size=atom.getSize())
            s += "\n"

        for mol in self.mols:
            d = mol.dist
            r = mol.radius
            phi = mol.angle()
            phi *= pi/180
            x,y = mol.atoms[0].getPos()
            const = (1**2 + d**2 - r**2)/(2*d*1)
            s += "{x}, {y}, 0.1\n\n".format(x=x-const*cos(phi-pi/2),y=y+const*sin(phi-pi/2))
        return s

    def rotation(self, pos, degree, n=1):
        x,y = self.mols[pos].atoms[0].getPos()
        xy = self.b*sin(self.theta)
        x = self.a - x + xy
        y = self.b - y
        self.mols[pos].rotate((360/degree)*n)
        self.mols[pos].setPos(x,y)

def lammpsFile(cell,path='.', filename=""):
    mol = cell.getMol()
    a,b,theta = cell.getShape()
    xy = 0
    xy = b*tan(pi/2-theta)
    string = ""
    string += "ITEM: TIMESTEP\n"
    string += "0\n"
    string += "ITEM: NUMBER OF ATOMS\n"
    string += "{}\n".format(cell.numAtoms())
    string += "ITEM: BOX BOUNDS\n"
    xy = 0
    if xy < 0:
        string += "{xmin} {xmax} {xy}\n".format(xmin=xy, xmax=a, xy=xy)
    else:
        string += "{xmin} {xmax} {xy}\n".format(xmin=0, xmax=a+xy, xy=xy)
    string += "{ymin} {ymax} {yz}\n".format(ymin=0, ymax=cell.getHeight(), yz=0)
    string += "{zmin} {zmax} {zx}\n".format(zmin=-0.5, zmax=0.5, zx=0)
    string += "ITEM: ATOMS\n"
    atomID = 1
    molID = 1
    for m in cell.getMols():
        #mx,my = m.COM()
        #mx2,my2 = wrap(mx,my,self.getA(),self.getHeight(),self.getB()*cos(self.getTheta()))
        #mol.translate(mx2-mx,my2-my)
        for atom in m:
            x,y = atom.getPos()
            #x,y = wrap(x,y,cell.getA(),cell.getHeight(), xy)
            string += "{id} {molID} {type} {diam} {x} {y} {z}\n".format(\
                    id=atomID, molID=molID, type=atom.getType(),\
                    diam=2*atom.getSize(), x=x, y=y, z=0)
            atomID += 1
        molID += 1
    if not filename:
        mol.getFilename()
    f = open('{path}/{filename}.lammpstrj'.format(path=path, filename=filename),'w')
    f.write(string)
    f.close()


def wrap(x,y,a,height,xy):
    while y > height:
        y -= height
        x -= xy
    while y < 0:
        y += height
        x += xy
    while x > a:
        x -= a
    while x < 0:
        x += a
    return x,y

def cellFile(cell,path='.', filename=""):
    mol = cell.getMol()
    a,b,theta = cell.getShape()
    string = ""
    string += "# Unit cell data for {} molecule\n\n".format(mol.getName())
    string += '{}   atoms\n'.format(cell.numAtoms())
    string += '{}   atom types\n'.format(mol.numAtomTypes())
    string += '{}   extra bond per atom\n'.format(mol.maxBondCount())
    string += '{}   extra angle per atom\n\n'.format(mol.maxAngleCount())
    string += '0 {xdim}     xlo xhi\n'.format(xdim=a)
    string += '0 {ydim}     ylo yhi\n'.format(ydim=cell.getHeight())
    string += '{xy} {xz} {yz}   xy xz yz\n\n'.format(xy=0,xz=0,yz=0)
    string += '\nAtoms\n\n'
    string += str(cell)
    if mol.getBonds():
        string += '\nBond Coeffs\n\n'
        a,b,d = mol.getBonds()[0]
        string += '{bondID} {coeff} {dist}\n'.format(\
                bondID=1, coeff=5000, dist=d)
    if mol.getAngles():
        string += '\nAngle Coeffs\n\n'
        a,b,c,theta = mol.getAngles()[0]
        string += '{angleID} {coeff} {theta}\n'.format(\
                angleID=1, coeff=5000, theta=theta*180/pi)
    string += '\nMasses\n\n'
    for t in mol.getAtomTypes():
        string += '{type} {mass}\n'.format(type=t.getType(), mass=1)
    string += '\nPair Coeffs\n\n'
    for t in mol.getAtomTypes():
        string += '{0} {strength} {dist}\n'.format(t.getType(), strength=1, dist=2*t.getSize())
    if not filename:
        filename=mol.getFilename()
        if cell.getCrys():
            filename+="-"+cell.getCrys()
    f = open('{path}/{filename}.dat'.format(path=path, filename=filename),'w')
    f.write(string)
    f.close()

def molFile(molecule, path='.', crys = "", filename=""):
    string = ''
    string += '# Defining the {0} molecule\n\n'.format(molecule.getName())
    string += '{0}  atoms\n'.format(molecule.numAtoms())
    string += '{0}  bonds\n'.format(molecule.numBonds())
    string += '{0}  angles\n\n'.format(molecule.numAngles())
    string += 'Coords\n\n'
    atomID = 1
    for atom in molecule:
        x,y = atom.getPos()
        string += '{0} {1} {2} 0\n'.format(atomID, x, y)
        atomID += 1
    string += '\nTypes\n\n'
    atomID = 1
    for atom in molecule:
        string += '{0} {1}\n'.format(atomID, atom.getType())
        atomID += 1
    if molecule.getBonds():
        string += '\nBonds\n\n'
        bondID = 1
        for a,b,dist in molecule.getBonds():
            string += "{0} {type} {atom1} {atom2}\n".format(\
                    bondID, type=1, atom1=a, atom2=b)
            bondID += 1
    if molecule.getAngles():
        string += '\nAngles\n\n'
        angleID = 1
        for a,b,c,theta in molecule.getAngles():
            string += '{0} {type} {atom1} {atom2} {atom3}\n'.format(\
                    angleID, type=1, atom1=a, atom2=b, atom3=c)
            angleID += 1
    if molecule.getBonds():
        string += "\nSpecial Bond Counts\n\n"
        for atom in molecule: 
            string += "{0!s} {1} {2} 0\n".format(\
                    atom.getID(), molecule.bondCount(atom.getID()), \
                    molecule.angleCount(atom.getID()))
        string += "\nSpecial Bonds\n\n"
        for atom in molecule:
            string += "{0!s} {1} {2}\n".format(atom.getID(), \
                    ' '.join(str(v) for v in molecule.get12(atom.getID())),\
                    ' '.join(str(v) for v in molecule.get13(atom.getID())))
    # Write to file
    if not filename:
        filename=molecule.getFilename()
        if crys:
            filename+="-"+crys

    f = open('{path}/{filename}.mol'.format(path=path,filename=filename), 'w')
    f.write(string)
    f.close()

if __name__ == "__main__":
    c = cell(3.43,3.13, 40.5, molecule.Trimer(0.7,1.0,180))
    c.addParticle(0.734,0.25,0)
    c.addParticle(1.177,0.75,0)
    print repr(c)
    c.replicate(2,2)
    cellFile(c)
    molFile(c.getMol())
    f = open('{filename}-mol.dat'.format(filename=c.getMol().getFilename()),'w')
    f.write(string)
    f.close()

