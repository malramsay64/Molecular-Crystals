set terminal png enhanced truecolor

ext = '.png'
plot_dir = 'myplot/'

set xrange [0:15]
set style fill solid
set style line 5 lw 3

set output plot_dir."radial".ext

plot "radial_dist.dat" using 1:2 with line ls 5 lc -1 title 'Radial Distribution'
