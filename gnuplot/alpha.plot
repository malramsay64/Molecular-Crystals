
load '~/make/gnuplot/config.plot'

set terminal term_type enhanced font ",".font_size size term_size*scaling, term_y*scaling

set datafile separator ","
set output prefix.plot_dir.'alpha'.ext
set yrange [-0.02:0.6]
set style line 5 pointtype 7 linewidth 2*scaling pointsize 0.5*scaling
set encoding utf8

set key off

set ylabel '{/Symbol a}'
set xlabel 'Timestep'
set logscale x
set format x "10^{%L}"

plot prefix.'/msd.csv' using 1:4 with linespoints linestyle 5 linecolor 1
