#!/usr/bin/python

import molecule
import sys
from math import *
from copy import deepcopy as copy
import unitCell


if __name__ == "__main__":
    line = sys.stdin.readline().split()
    if len(line) == 7 and len(sys.argv) == 4:
        theta = float(line[0])
        a = float(line[1])
        b = float(line[2])
        x = float(line[3])
        y = float(line[4])
        phi = float(line[5])
        m = float(line[6])

        r = float(sys.argv[1])
        d = float(sys.argv[2])
        crys = sys.argv[3]
        
        # Unit Cell
        print 0,0,"\n",a,0,"\n"
        print 0,0,"\n",0,b,"\n"
        print a,0,"\n",a,b,"\n"
        print 0,b,"\n",a,b,"\n"

        # Convert to my coordinates
        x = ((x*a+sin(phi-pi/2))/a)%1
        y = -((y*b+cos(phi-pi/2))/b)%1
        phi = phi*180/pi
        phi = phi+90
        
        s = molecule.Snowman(r,d)
        
        func = getattr(unitCell, crys)
        c = func(a,b,theta,x,y,phi,s)
        print repr(c)

