
from math import *
import sys
import molecule
import unitCell

def create(a, b, theta, x, y, phi):
    da = b*cos(theta)
    x0 = x
    y0 = y
    x1 = (1-x)
    y1 = (1-y)
    x0 *= a + y0*b*cos(theta)
    y0 *= b*sin(theta)
    x1 *= a + y1*b*cos(theta)
    y1 *= b*sin(theta)
    d = 1
    r = 0.637556
    const = (1**2 + d**2 - r**2)/(2*d*1)
    #x0 += -(const)*cos(-phi)
    #y0 += -(const)*sin(-phi)
    #x1 += -(const)*cos(phi)
    #y1 += -(const)*sin(phi)
    #x *= a + y*self.b*cos(theta)
    #y *= b*sin(self.theta)
    s = ""
    s += "{0}, {1}\n".format(0,0)
    s += "{0}, {1}\n\n".format(a,0)
    s += "{0}, {1}\n".format(0,0)
    s += "{0}, {1}\n\n".format(da,b)
    s += "{0}, {1}\n".format(a,0)
    s += "{0}, {1}\n\n".format(a+da,b)
    s += "{0}, {1}\n".format(da,b)
    s += "{0}, {1}\n\n".format(a+da,b)
    s += "{0}, {1}\n".format(0,0)
    s += "{0}, {1}\n\n".format(a+da,b)
    
    s += "{0}, {1}, 1\n\n".format(x1,y1)
    s += "{0}, {1}, 1\n\n".format(x0,y0)
    
    theta2 = atan(b/(a+da))
    x2 = cos(theta2)
    y2 = sin(theta2)
    
    x3 = x2
    y3 = y2

    x4 = x3/a - y3*(cos(theta)/(a*sin(theta)))
    y4 = y3/(b*sin(theta))
   
    x4 = 1-x4  
    y4 = 1-y4  

    x4 = a*x4 + y4*b*cos(theta)
    y4 = y4*b*sin(theta)

    s += "{0}, {1}, 1\n\n".format(x2,y2)
    s += "{0}, {1}, 1\n\n".format(x3,y3)
    s += "{0}, {1}, 1\n\n".format(x4,y4)

    print s


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

        x *= a + y*b*cos(theta)
        y *= b*sin(theta)
        const = (1**2 + d**2 - r**2)/(2*d*1)
        phi = pi/2-phi
        x += -(const)*cos(phi-pi/2)
        y += -(const)*sin(phi-pi/2)
        
        x *= 1/a - y*cos(theta)/(a*sin(theta))
        y *= 1/(b*sin(theta))

        create(a, b, theta, x, y, phi)
         
