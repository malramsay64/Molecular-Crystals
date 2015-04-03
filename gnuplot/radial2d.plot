load '~/make/gnuplot/config.plot'

set terminal term_type enhanced size term_size*scaling, term_size*scaling font ",".font_size

my_colour = '#2b8cbe'

set yrange[-10:10]
set xrange[-10:10]
unset raxis
unset rtics
set datafile separator " "
set key off
set style fill solid

set palette defined (0 "#FFFFFF", 1 my_colour)
set pm3d map
#set contour base
set view map
unset colorbox
f_abs = prefix.'radial2d_abs.dat'
f_rel = prefix.'radial2d_rel.dat'

set lmargin at screen 0.1;
set rmargin at screen 0.9;
set bmargin at screen 0.1;
set tmargin at screen 0.9;

set output prefix.plot_dir.'radial2d_abs'.ext
splot f_abs every :::1 using ($2*sin($1)):($2*cos($1)):(sqrt($3)) with pm3d

unset xtics
unset ytics
set output prefix.plot_dir.'radial2d_rel'.ext
set multiplot
set origin 0,0
set size 1,1
splot f_rel every :::1 using ($2*sin($1)):($2*cos($1)):(sqrt($3)) with pm3d
#set origin 0,0
set size 1,1
plot f_rel every :::0::0 using 1:2:3 with circles linecolor rgb my_colour

unset multiplot
