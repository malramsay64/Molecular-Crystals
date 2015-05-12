load '~/make/gnuplot/config.plot'

set terminal term_type enhanced size term_size,term_y

set xrange [0:15]
set style fill solid
set style line 5 lw 3
set key off

set output plot_dir."radial".ext
plot "radial_dist.dat" using 1:2 with line ls 5 lc -1 title 'Radial Distribution'

set output plot_dir."radial_part".ext
plot "radial_part.dat" using 1:2 with line ls 5 lc -1
