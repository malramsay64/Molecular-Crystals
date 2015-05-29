load '~/make/gnuplot/config.plot'

set terminal term_type enhanced size term_size,term_size font ",12"

set polar
set angles degrees
set size square

set rrange[0:0.02]
set grid polar 40

unset xtics
unset ytics
#unset rtics
unset raxis
unset border
unset key

set style line 5 pt 7 lw 1

infile = prefix.'angular.dat'

set output plot_dir."angular".ext
# Labels
set_label(x, text) = sprintf("set label '%s' at (0.6*cos(%f)), (0.6*sin(%f))     center", text, x, x)
eval set_label(60, "60")
eval set_label(120, "120")
eval set_label(180, "180")
eval set_label(240, "240")
eval set_label(300, "300")

plot infile using 1:2 with points ls 5 lc 1

