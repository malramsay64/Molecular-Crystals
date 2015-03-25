set terminal png enhanced truecolor

ext = '.png'
prefix = './'
plot_dir = 'myplot/'

set datafile separator ","
set style fill solid
set key autotitle columnhead

set style line 5 pt 7 lw 3

set output plot_dir."msd".ext
set logscale y
set logscale x

plot for [i=2:2] "msd.csv" using 1:i with linespoints ls 5 lc 1

