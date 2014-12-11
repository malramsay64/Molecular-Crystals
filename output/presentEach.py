import os
import glob
import sys
from create import *

theta = 0

orderDir = "{dir}/order/"
imageDir = "{dir}/images/"
plotDir = "{dir}/"
trjDir = "{dir}/trj_contact/"

plotext = ".png"
imageext = ".jpg"

prefix = sys.argv[1]
dirs = glob.glob("{prefix}/*-*-*".format(prefix=prefix))

plots = [(order, orderDir,"Order Parameter"), (discs, trjDir, "Configuration"), (angles, trjDir,"Angle Distribution"), (shortOrder, plotDir, "Short Range Ordering"), (msd, plotDir, "Mean Squared Displacement"), (rotation, plotDir, "Rotational Relaxation"), (histogram, plotDir, "Contact Number"), (props, plotDir, "Properties"), (data, plotDir, "Data")]

#print prefix
print r"\section{{{}}}".format(name(prefix))
for plot, itsDir, text in plots:
    #print r"\subsection{{{text}}}".format(text=text)
    plot(prefix, itsDir, text)

