#!/usr/bin/python

import density
import sys


if __name__ == "__main__":
    if len(sys.argv) > 1:
        filename = sys.argv[1]
    else:
        filename = "out.log"

    f = density.thermo(filename)

    print "Enthalpy:", f.mean("Enthalpy")
    f.stats("Enthalpy")

