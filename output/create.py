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


def order(dir, orderDir, caption=0):
    if not caption:
        caption = name(dir) 
    oDir = orderDir.format(dir=dir)
    plots = [os.path.splitext(file)[0] for file in os.listdir(oDir) if file.endswith(plotext)]
    plots.sort()
    print r"\begin{figure}[H]"
    if len(plots) >= 2:
        print r"\begin{subfigure}{0.5\textwidth}"
        print r"\centering"
        print r"\includegraphics[width=\mywidth]{{{0}}}".format(oDir+plots[-2])
        print r"\caption{Pre minimisation}"
        print r"\end{subfigure}"
    print r"\begin{subfigure}{0.5\textwidth}"
    print r"\centering"
    print r"\includegraphics[width=\mywidth]{{{0}}}".format(oDir+plots[-1])
    print r"\caption{Post CG minimisation}"
    print r"\end{subfigure}"
    print r"\caption{{{name}}}".format(name=caption)
    print r"\end{figure}"

def images(dir, imageDir,caption=0):
    if not caption:
        caption = name(dir)
    iDir = imageDir.format(dir=dir)
    images = [os.path.splitext(file)[0] for file in os.listdir(iDir) if file.endswith(imageext)]
    images.sort()
    print r"\begin{figure}[H]"
    if len(images) >= 2:
        print r"\begin{subfigure}{0.5\textwidth}"
        print r"\centering"
        print r"\includegraphics[width=\mywidth]{{{0}}}".format(iDir+images[-2])
        print r"\caption{Pre minimisation}"
        print r"\end{subfigure}"
    print r"\begin{subfigure}{0.5\textwidth}"
    print r"\centering"
    print r"\includegraphics[width=\mywidth]{{{0}}}".format(iDir+images[-1])
    print r"\caption{Post CG minimisation}"
    print r"\end{subfigure}"
    print r"\caption{{{name}}}".format(name=caption)
    print r"\end{figure}"

def msd(dir, plotDir, caption=0):
    if not caption:
        caption = name(dir)
    pDir = plotDir.format(dir=dir)
    plots = ["msd"]
    print r"\begin{minipage}{0.5\textwidth}" 
    print r"\begin{figure}[H]"
    print r"\centering"
    print r"\includegraphics[width=\mywidth]{{{0}}}".format(pDir+plots[-1])
    print r"\caption{{{name}}}".format(name=caption)
    print r"\end{figure}"
    print r"\end{minipage}"
   
def shortOrder(dir, plotDir,caption=0):
    if not caption:
        caption = name(dir)
    pDir = plotDir.format(dir=dir)
    plots = ["short_order"]
    print r"\begin{minipage}{0.5\textwidth}" 
    print r"\begin{figure}[H]"
    print r"\centering"
    print r"\includegraphics[width=\mywidth]{{{0}}}".format(pDir+plots[-1])
    print r"\caption{{{name}}}".format(name=caption)
    print r"\end{figure}"
    print r"\end{minipage}"

def rotation(dir, plotDir, caption=0):
    if not caption:
        caption = name(dir)
    pDir = plotDir.format(dir=dir)
    plots = ["rotation"]
    print r"\begin{minipage}{0.5\textwidth}" 
    print r"\begin{figure}[H]"
    print r"\centering"
    print r"\includegraphics[width=\mywidth]{{{0}}}".format(pDir+plots[-1])
    print r"\caption{{{name}}}".format(name=caption)
    print r"\end{figure}"
    print r"\end{minipage}"
    
def discs(dir, plotDir, caption=0):
    if not caption:
        caption = name(dir)
    pDir = plotDir.format(dir=dir)
    plots = [os.path.splitext(file)[0] for file in os.listdir(pDir) if file.endswith(frameExt) and "angle" not in file]
    plots.sort()
    print r"\begin{minipage}{\textwidth}" 
    print r"\begin{figure}[H]"
    print r"\begin{subfigure}{0.5\textwidth}"
    print r"\centering"
    print r"\includegraphics[width=\mywidth]{{{0}}}".format(pDir+plots[-2])
    print r"\caption{Initial Configuration}"
    print r"\end{subfigure}"
    print r"\begin{subfigure}{0.5\textwidth}"
    print r"\centering"
    print r"\includegraphics[width=\mywidth]{{{0}}}".format(pDir+plots[-1])
    print r"\caption{Final Configuration}"
    print r"\end{subfigure}"
    print r"\caption{{{name}}}".format(name=caption)
    print r"\end{figure}"
    print r"\end{minipage}"
    

def angles(dir, plotDir, caption=0):
    if not caption:
        caption = name(dir)
    pDir = plotDir.format(dir=dir)
    plots = [os.path.splitext(file)[0] for file in os.listdir(pDir) if file.endswith("angles"+plotext)]
    plots.sort()
    print r"\begin{minipage}{\textwidth}" 
    print r"\begin{figure}[H]"
    print r"\begin{subfigure}{0.5\textwidth}"
    print r"\centering"
    print r"\includegraphics[width=\mywidth]{{{0}}}".format(pDir+plots[-2])
    print r"\caption{Initial Configuration}"
    print r"\end{subfigure}"
    print r"\begin{subfigure}{0.5\textwidth}"
    print r"\centering"
    print r"\includegraphics[width=\mywidth]{{{0}}}".format(pDir+plots[-1])
    print r"\caption{Final Configuration}"
    print r"\end{subfigure}"
    print r"\caption{{{name}}}".format(name=caption)
    print r"\end{figure}"
    print r"\end{minipage}"
    



def histogram(dir, plotDir, caption=0):
    if not caption:
        caption = name(dir)
    pDir = plotDir.format(dir=dir)
    plots = ["histogram"]
    print r"\begin{minipage}{0.5\textwidth}" 
    print r"\begin{figure}[H]"
    print r"\centering"
    print r"\includegraphics[width=\mywidth]{{{0}}}".format(pDir+plots[-1])
    print r"\caption{{{name}}}".format(name=caption)
    print r"\end{figure}"
    print r"\end{minipage}"

def data(dir, dataDir, caption=0):
    if not caption:
        caption = name(dir)
    print r"\begin{minipage}{0.5\textwidth}"
    print r"\begin{tabular}{L{4cm} S[table-format=3.4e2]}"
    contact = open('{dir}/contact.log'.format(dir=dir), 'r')
    for line in contact:
        print ' & '.join(line.split(':')), r"\\"
    print r"\end{tabular}"
    print r"\captionof{{table}}{{{name}}}".format(name=caption)
    print r"\end{minipage}"

def shortOrderHist(dir, plotDir, caption=0):
    if not caption:
        caption = name(dir)
    pDir = plotDir.format(dir=dir)
    plots = ["short_order_hist"]
    print r"\begin{minipage}{0.5\textwidth}" 
    print r"\begin{figure}[H]"
    print r"\centering"
    print r"\includegraphics[width=\mywidth]{{{0}}}".format(pDir+plots[-1])
    print r"\caption{{{name}}}".format(name=caption)
    print r"\end{figure}"
    print r"\end{minipage}"


def props(dir, plotDir, caption=0):
    if not caption:
        caption = name(dir)
    pDir = plotDir.format(dir=dir)
    plots = ["props"]
    print r"\begin{minipage}{0.5\textwidth}" 
    print r"\begin{figure}[H]"
    print r"\centering"
    print r"\includegraphics[width=\mywidth]{{{0}}}".format(pDir+plots[-1])
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
