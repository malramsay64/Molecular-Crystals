#!/usr/bin/python

import os
import glob
import sys

plotext = ".png"
imageext = ".jpg"
frameExt = ".png"


plot_dict = {"order":("order/*[0-9].png","Order Parameter"), "frame":("trj_contact/*[0-9].png", "Configuration"), "angle":("trj_contact/*-angles.png","Angle Distribution"), "short-order":("short_order.png", "Short Range Ordering"), "msd":("msd.png", "Mean Squared Displacement"), "rotation":("rotation.png", "Rotational Relaxation"), "hist":("histogram.png", "Contact Number"), "props":("props.png", "Properties"), "short-order-hist":("short_order_hist.png", "Short Order Histogram"), "radial":("radial.png", "Radial Distribution"), "struct":("struct.png", "Structural Relaxation"), "com":("complot.png", "Centers of Mass"), "moved":("moved.png", "Motion of Particles"), "alpha":("alpha.png", "Non Gaussian"), "regio":("regio*.png", "Regional Relaxation"), "hexatic":('hexatic_order.png', "Hexatic Ordering"), "data":("contact.log", "Data"), "rot-diff":("rot_diff.png", "Rotation vs Diffusion")}

plots=plot_dict.values()

def figure(prefix, filename, caption=0):
    if not caption:
        caption = name(prefix)
    filename = "{dir}/".format(dir=prefix)+filename
    plots = [os.path.splitext(file)[0] for file in glob.glob(filename)]
    plots.sort()
    if len(plots) > 1:
        print r"\begin{figure}[H]"
        for plot in plots:
            print r"\begin{subfigure}{0.5\textwidth}"
            print r"\centering"
            print r"\includegraphics[width=\mywidth]{{{{{0}}}{ext}}}".format(plot, ext=plotext)
            print r"\caption{{{0}}}".format(os.path.basename(plot).split("_")[-1])
            print r"\end{subfigure}"
        print r"\caption{{{name}}}".format(name=caption)
        print r"\end{figure}"
    elif filename.endswith(".log") and len(plots) == 1:
        print r"\begin{minipage}{0.5\textwidth}"
        print r"\begin{tabular}{L{4cm} S[table-format=3.4e2]}"
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
        print r"\includegraphics[width=\mywidth]{{{{{0}}}{ext}}}".format(plots[0],ext=plotext)
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
        print r"\includegraphics[width=\mywidth]{{{{{0}}}{ext}}}".format(plot, ext=plotext)
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
        elif len(d) == 6:
            shape, temp, radius, dist, crys, bound = d
        else:
            shape, temp, radius, dist = d
    elif shape == "Trimer":
        shape, temp, radius, dist, theta = d
    else:
        print shape
    if theta:
        return r"Trimer: Temp $= {0}$, $r = {1}$, $d = {2}$, $\theta = {3}$".format(temp, radius, dist, theta)
    elif crys:
        return r"Snowman: Temp$ = {0}$, $r = {1}$, $d = {2}$, {3}".format(temp, radius, dist, crys)
    else:
        return r"Snowman: Temp$ = {0}$, $r = {1}$, $d = {2}$".format(temp, radius, dist, crys)

if __name__ == "__main__":
    if len(sys.argv) == 3:
        prefix = sys.argv[1]
        plot = sys.argv[2]
        filename, caption = plot_dict.get(plot)
        figure(prefix, filename, caption)
