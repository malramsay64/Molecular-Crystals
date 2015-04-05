load '~/make/gnuplot/collate_config.plot'

set terminal term_type enhanced size term_size*scaling, term_y*scaling font "arial,".font_size

set encoding utf8
set xlabel "Timestep"
set ylabel "MSD"
set format x "10^{%L}"
set format x "10^{%L}"
set logscale x
set logscale y
set key outside right
set style line 5 pointtype 7 linewidth 2*scaling pointsize 0.5*scaling

set datafile separator ","
set output prefix.plot_dir.molecule."-msd".ext

plot for [i=1:words(files)] word(files,i)."/msd.csv" using 1:2 with linespoints linestyle 5\
     linecolor i title temp(word(files,i)),\
     0.00001*x linecolor black title 'x'



unset logscale y
set ylabel '{/Symbol a}(t)'
set output prefix.plot_dir.molecule."-alpha".ext

plot for [i=1:words(files)] word(files,i)."/msd.csv" using 1:4 with linespoints linestyle 5\
     linecolor i title temp(word(files,i))
