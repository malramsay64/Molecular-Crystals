term_type = png
scaling = 10

load '~/make/gnuplot/config.plot'

set terminal term_type enhanced size term_size*scaling, term_size*scaling

my_colour = '#2b8cbe'
circle_colour ="#9ecae1"

set yrange[-10:10]
set xrange[-10:10]
unset raxis
unset rtics
set datafile separator " "
set key off
set style fill solid

set palette defined  (0 "#FFFFFF", 1 my_colour)
set pm3d map
set view map
unset colorbox
unset xtics
unset ytics

f = prefix.'radial2d.dat'

max_col(n) = system('cat '.f.' | cut -d" " -f'.n.' | uniq | grep [0-9] | sort | tail -n1')
max_6 = max_col(6)
max_7 = max_col(7)
max_8 = max_col(8)

set lmargin at screen 0.1;
set rmargin at screen 0.9;
set bmargin at screen 0.1;
set tmargin at screen 0.9;

set output prefix.plot_dir.'radial2d_abs'.ext
splot f every :::1 using 3:4:(sqrt($5)) with pm3d

set output prefix.plot_dir.'radial2d_rel'.ext
set multiplot
set origin 0,0
set size 1,1
splot f every :::1 using 3:4:(sqrt($6)) with pm3d 
set size 1,1
plot f every :::0::0 using 1:2:3 with circles linecolor rgb circle_colour

unset multiplot

set pm3d interpolate 100,100
set output prefix.plot_dir.'radial2d_part'.ext
sorted = '< cat '.f.' | sort -n -r -k9'
splot f every :::1 using 3:4:9 with pm3d

set dgrid3d 300,300, splines gauss 0.2,0.2
set pm3d
set contour
set cntrparam bspline
set cntrparam points 30
set output prefix.plot_dir.'radial2d_cont'.ext
splot f every :::1 using 3:4:9 with pm3d
