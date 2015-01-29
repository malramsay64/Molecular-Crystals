#!/usr/bin/python

import os
import glob
import sys

plotext = ".png"
imageext = ".jpg"
frameExt = ".png"

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

plots = [("order/*[0-9].png","Order Parameter"), ("trj_contact/*[0-9].png", "Configuration"), ("trj_contact/*-angles.png","Angle Distribution"), ("short_order.png", "Short Range Ordering"), ("msd.png", "Mean Squared Displacement"), ("rotation.png", "Rotational Relaxation"), ("histogram.png", "Contact Number"), ("props.png", "Properties"), ("short_order_hist.png", "Short Order Histogram"), ("contact.log", "Data")]

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
            print r"\includegraphics[width=\mywidth]{{{0}}}".format(plot)
            print r"\caption{{{0}}}".format(os.path.basename(plot))
            print r"\end{subfigure}"
        print r"\caption{{{name}}}".format(name=caption)
        print r"\end{figure}"
    elif filename.endswith(".log"):
        print r"\begin{minipage}{0.5\textwidth}"
        print r"\begin{tabular}{L{4cm} S[table-format=3.4e2]}"
        contact = open(plots[0]+".log", "rU")
        for line in contact:
            print ' & '.join(line.split(':')), r"\\"
        print r"\end{tabular}"
        print r"\captionof{{table}}{{{name}}}".format(name=caption)
        print r"\end{minipage}"
    else:
        print r"\begin{minipage}{0.5\textwidth}"
        print r"\begin{figure}[H]"
        print r"\centering"
        print r"\includegraphics[width=\mywidth]{{{0}}}".format(plots[0])
        print r"\caption{{{name}}}".format(name=caption)
        print r"\end{figure}"
        print r"\end{minipage}"

def collated(dir, plotDir, caption):
    if not caption:
        caption = name(dir)
    pDir = plotDir.format(dir=dir)
    plots = glob.glob(pDir+"/*"+plotext)
    for plot in plots:
        plot = os.path.splitext(plot)[0]
        print r"\begin{minipage}{\textwidth}" 
        print r"\begin{figure}[H]"
        print r"\centering"
        print r"\includegraphics[width=\mywidth]{{{{{0}}}{ext}}}".format(plot, ext=plotext)
        print r"\caption{{{name}}}".format(name=caption)
        print r"\end{figure}"
        print r"\end{minipage}"
