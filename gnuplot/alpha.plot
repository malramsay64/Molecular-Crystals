
set terminal png enhanced font "arial"

ext ='.png'
prefix = "./"

set datafile separator ","
set output prefix.'/myplot/alpha'.ext
set yrange [-0.02:0.6]
set style line 5 pointtype 7 linewidth 2 pointsize 0.5
set encoding utf8

set key off

set ylabel '{/Symbol a}'
set xlabel 'Timestep'
set logscale x

plot prefix.'/msd.csv' using 1:4 with linespoints linestyle 5 linecolor 1
