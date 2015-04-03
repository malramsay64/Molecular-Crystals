load '~/make/gnuplot/config.plot'

set terminal term_type enhanced size term_size*scaling, term_size*scaling

set yrange[-10:10]
set xrange[-10:10]
unset raxis
unset rtics
set datafile separator " "
set key off

set palette defined (0 "#FFFFFF", 1 "#f03b20")
set pm3d map
set contour base
set view map
unset colorbox
f = prefix.'radial2d_dist.dat'

set output prefix.plot_dir.'radial2d'.ext


splot f using ($2*sin($1)):($2*cos($1)):(sqrt($3)) with pm3d
