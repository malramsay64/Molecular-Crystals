#!/usr/bin/python

from create import *
import os
import glob
import sys

if len(sys.argv) > 1:
    prefix = sys.argv[1]
else:
    prefix = ".."

theta = 0

orderDir = "{dir}/order/"
imageDir = "{dir}/images/"
plotDir = "{dir}/"
trjDir = "{dir}/trj_contact/"

plotext = ".png"
imageext = ".jpg"

unused = [(images, imageDir, "State")]

plots = [(order, orderDir,"Order Parameter"), (discs, trjDir, "Configuration"), (angles, trjDir,"Angle Distribution"), (shortOrder, plotDir, "Short Range Ordering"), (msd, plotDir, "Mean Squared Displacement"), (rotation, plotDir, "Rotational Relaxation"), (histogram, plotDir, "Contact Number"), (props, plotDir, "Properties"), (data, plotDir, "Data")]

dirs = glob.glob("{prefix}/*-*-*".format(prefix=prefix))
dirs.sort()

collated("", "plots/", "Temperature Dependence") 

for plot, itsDir, text in plots:
    print r"\section{{{text}}}".format(text=text)
    for dir in dirs:
    # Find plots and images in folder
        plot(dir, itsDir)

