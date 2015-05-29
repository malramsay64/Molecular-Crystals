load '~/make/gnuplot/config.plot'

set terminal term_type enhanced size term_size,term_y font ",12"

set xrange [0:12]
set yrange [0:5]
set style fill solid
set style line 5 lw 3
set key off
set xlabel "r"
set ylabel "G(r)"

set output plot_dir."radial".ext
plot "radial_dist.dat" using 1:2 with line ls 5 lc -1 title 'Radial Distribution'

set ylabel "G_p(r)"
set output plot_dir."radial_part".ext
plot "radial_part.dat" using 1:($2/2) with line ls 5 lc -1


set ylabel "G_f(r)"
set xrange[0.5:2]
set output plot_dir."radial_frac".ext
plot "radial_frac.dat" using 1:2 with line ls 5 lc -1
