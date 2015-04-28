#!/usr/bin/python

import os
import glob
import sys

plotext = ".png"
imageext = ".jpg"
frameExt = ".png"


plot_dict = {\
        "order":("*[0-9].*","Order Parameter"),\
        "frame":("frame-*", "Configuration"),\
        "angle":("*-angles.*","Angle Distribution"),\
        "short-order":("short_order.*", "Short Range Ordering"),\
        "msd":("msd.*", "Mean Squared Displacement"),\
        "rotation":("rotation.*", "Rotational Relaxation"),\
        "hist":("hist.*", "Contact Number"),\
        "props":("props.*", "Properties"),\
        "short-order-hist":("short-order-hist.*", "Short Order Histogram"),\
        "radial":("radial.*", "Radial Distribution"),\
        "struct":("struct.*", "Structural Relaxation"),\
        "com":("com.*", "Centers of Mass"),\
        "moved":("moved.*", "Motion of Particles"),\
        "alpha":("alpha.*", "Non Gaussian"),\
        "regio":("regio*.*", "Regional Relaxation"),\
        "hexatic":('hexatic_order.*', "Hexatic Ordering"),\
        "table":("contact.log", "Data"),\
        "rot-diff":("rot_diff.*", "Rotation vs Diffusion"),\
        "radial2d":("radial2d_*", "2D Radial Distribution")
        }

plots=plot_dict.values()

def figure(prefix, filename, caption=0):
    if not caption:
        caption = name(prefix)
    filename = "{dir}/myplot/".format(dir=prefix)+filename
    plots = [os.path.splitext(file)[0] for file in glob.glob(filename)]
    plots.sort()
    if len(plots) > 1:
        print r"\begin{figure}[H]"
        for plot in plots:
            print r"\begin{subfigure}{0.5\textwidth}"
            print r"\centering"
            print r"\includegraphics[width=\mywidth]{{{{{{{0}}}}}}}".format(plot)
            print r"\caption{{{0}}}".format(os.path.basename(plot).split("_")[-1])
            print r"\end{subfigure}"
        print r"\caption{{{name}}}".format(name=caption)
        print r"\end{figure}"
    elif filename.endswith(".log") and len(plots) == 1:
        print r"\begin{minipage}{0.5\textwidth}"
        print r"\begin{tabular}{L{4cm} S[table-format=1.5e2]}"
        contact = open(plots[0]+".log", "rU")
        for line in contact:
            print ' & '.join(line.split(':')), r"\\"
        print r"\end{tabular}"
        print r"\captionof{{table}}{{{name}}}".format(name=caption)
        print r"\end{minipage}"
    elif len(plots) == 1:
        print r"\begin{minipage}{0.5\textwidth}"
        print r"\begin{figure}[H]"
        print r"\centering"
        print r"\includegraphics[width=\mywidth]{{{{{{{0}}}}}}}".format(plots[0])
        print r"\caption{{{name}}}".format(name=caption)
        print r"\end{figure}"
        print r"\end{minipage}"

def collated(prefix, filename, caption):
    if not caption:
        caption = name(prefix)
    filename = "{dir}/".format(dir=prefix)+filename
    plots = [os.path.splitext(file)[0] for file in glob.glob(filename)]
    plots.sort()
    for plot in plots:
        print r"\begin{minipage}{0.5\textwidth}" 
        print r"\begin{figure}[H]"
        print r"\centering"
        print r"\includegraphics[width=\mywidth]{{{{{{{0}}}}}}}".format(plot)
        print r"\caption{{{name}}}".format(name=caption)
        print r"\end{figure}"
        print r"\end{minipage}"

def collatedEx(prefix, filename, caption, exclude):
    if not caption:
        caption = name(prefix)
    filename = "{dir}/".format(dir=prefix)+filename
    plots = [os.path.splitext(file)[0] for file in glob.glob(filename)]
    plots.sort()
    for plot in plots:
        for x in exclude:
            if x in plot:
                break
        print r"\begin{minipage}{0.5\textwidth}" 
        print r"\begin{figure}[H]"
        print r"\centering"
        print r"\includegraphics[width=\mywidth]{{{{{{{0}}}}}}}".format(plot)
        print r"\caption{{{name}}}".format(name=caption)
        print r"\end{figure}"
        print r"\end{minipage}"

def name(dir):
    dir = os.path.basename(dir)
    d = dir.split("-")
    shape = d[0]
    crys = 0
    theta = 0
    if shape == "Snowman":
        if len(d) == 5:
            shape, temp, radius, dist, crys = d
            return r"Snowman: Temp$ = {0}$, $r = {1}$, $d = {2}$, {3}".format(temp, radius, dist, crys)
        elif len(d) == 6:
            shape, temp, radius, dist, crys, bound = d
            return r"Snowman: Temp$ = {0}$, $r = {1}$, $d = {2}$, {3}".format(temp, radius, dist, crys)
        else:
            shape, temp, radius, dist = d
            return r"Snowman: Temp$ = {0}$, $r = {1}$, $d = {2}$".format(temp, radius, dist, crys)
    elif shape == "Trimer":
        shape, temp, radius, dist, theta = d
        return r"Trimer: Temp $= {0}$, $r = {1}$, $d = {2}$, $\theta = {3}$".format(temp, radius, dist, theta)
    else:
        shape, temp = d
        return r"Disc: Temp $= {0}$".format(temp)



if __name__ == "__main__":
    if len(sys.argv) == 3:
        prefix = sys.argv[1]
        plot = sys.argv[2]
        filename, caption = plot_dict.get(plot)
        figure(prefix, filename, caption)
