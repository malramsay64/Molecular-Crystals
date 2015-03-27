import molecule
import unitCell
import math
import sys
import files
import unitCell
from math import pi

def cellFile(cell,path='.', filename=""):
    mol = cell.getMol()
    a,b,theta = cell.getShape()
    string = ""
    string += "# Unit cell data for {} molecule\n\n".format(mol.getName())
    string += '{}   atoms\n'.format(cell.numAtoms())
    string += '{}   atom types\n'.format(mol.numAtomTypes())
    string += '{}   extra bond per atom\n'.format(mol.maxBondCount())
    string += '{}   extra angle per atom\n\n'.format(mol.maxAngleCount())
    string += '-{xdim} {xdim}     xlo xhi\n'.format(xdim=a)
    string += '-{ydim} {ydim}     ylo yhi\n'.format(ydim=b)
    string += '{xy} {xz} {yz}   xy xz yz\n\n'.format(xy=0,xz=0,yz=0)
    
    string += '\nAtoms\n\n'
    string += str(cell)
    if mol.getBonds():
        string += '\nBond Coeffs\n\n'
        a,b,d = mol.getBonds()[0]
        string += '{bondID} {coeff} {dist}\n'.format(\
                bondID=1, coeff=500, dist=d)
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
    string += "\nAtoms\n"
    if not filename:
        if mol.getAngles():
            filename="{shape}-{radius}-{dist}-{theta}".format(shape=mol.getName(),radius=mol.radius, dist=mol.dist, theta=mol.theta)
        elif cell.getCrys():
            filename="{shape}-{radius}-{dist}-{crys}".format(shape=mol.getName(),radius=mol.radius, dist=mol.dist, crys=cell.getCrys())
        else:
            filename="{shape}-{radius}-{dist}".format(shape=mol.getName(),radius=mol.radius, dist=mol.dist)
    f = open('{path}/{filename}.dat'.format(path=path, filename=filename),'w')
    f.write(string)
    f.close()


class parallel(unitCell.cell):

    def __init__(self, mol):
        self.a, self.b = [x*2 for x in mol.dimensions() ]
        self.theta = math.pi/2
        self.mol = mol
        self.mols = []
        dx = 1/self.a
        dy = math.sqrt(3)/self.b
        dtheta = math.pi/2
        self.addMol(0,0,math.pi/2)
        self.addMol(dx,dy,dtheta)
        self.crys = "parallel"

class antiparallel_1(unitCell.cell):
    
    def __init__(self,mol):
        self.a, self.b = [x*2 for x in mol.dimensions() ]
        self.theta = math.pi/2
        self.mol = mol
        self.mols = []
        dx = (1+mol.getDist())/self.a
        dy = math.sqrt((1+mol.getRadius())**2 - 1)/self.b
        dtheta = pi
        self.addMol(0,0,pi/2)
        self.addMol(dx,dy,pi/2+dtheta)
        self.crys = "antiparallel1"

class antiparallel_2(unitCell.cell):

    def __init__(self,mol):
        self.a, self.b = [x*2 for x in mol.dimensions() ]
        self.theta = math.pi/2
        self.mol = mol
        self.mols = []
        dx = 1.2/self.a
        dy = math.sqrt((1+1)**2 - 1)/self.b
        dtheta = pi
        self.addMol(0,0,pi/2)
        self.addMol(dx,dy,pi/2+dtheta)
        self.crys = "antiparallel2"

class chiral(unitCell.cell):

    def __init__(self,mol):
        self.a, self.b = [x*2 for x in mol.dimensions() ]
        self.theta = math.pi/2
        self.mol = mol
        self.mols = []
        dx = 1-mol.getDist()
        dy = 1+math.sqrt((1+mol.getRadius())**2 - 1)
        dtheta = 2*math.atan((1-mol.getRadius())/mol.getDist())
        self.addMol(2,1,180)
        self.addMol(2+dx,1+dy,180+dtheta)
        self.crys = "chiral"


if __name__ == '__main__':
    prefix = sys.argv[1]
    if len(sys.argv) == 5:
        r = float(sys.argv[3])
        d = float(sys.argv[4])
        m = molecule.Snowman(r,d)
    elif len(sys.argv) == 6:
        r = float(sys.argv[3])
        d = float(sys.argv[4])
        theta = float(sys.argv[5])
        m = molecule.Trimer(r,d,theta)
    
    unitCell.molFile(m,prefix)

    p1 = parallel(m)
    cellFile(p1,prefix)
    p2 = antiparallel_1(m)
    cellFile(p2,prefix)
    p3 = antiparallel_2(m)
    cellFile(p3,prefix)
    p4 = chiral(m)
    cellFile(p4,prefix)


