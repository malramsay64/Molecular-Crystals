term_type = 'png'
#scaling = 10

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
#set pm3d map
set view map
unset colorbox
unset xtics
unset ytics

f = prefix.'radial2d.dat'

max_col(n) = system('cat '.f.' | cut -d" " -f'.n.' | uniq | grep [0-9] | sort | tail -n1')
max_6 = max_col(6)
max_7 = max_col(7)
max_8 = max_col(8)

min(x,y) = (x < y) ? x : y
max(x,y) = (x > y) ? x : y

set lmargin at screen 0.1;
set rmargin at screen 0.9;
set bmargin at screen 0.1;
set tmargin at screen 0.9;


rgb(r,g,b) = 65536*int(r) + 256*int(g) + int(b)
set_colour(x,y) = rgb(max(1-sqrt(y)/3.0,0)*256,max(1-sqrt(x)/3-sqrt(y)/3,0)*256,max(1-sqrt(x)/3,0)*256)

#set dgrid3d 100,100, splines gauss 0.2,0.2
set pm3d interpolate 0,0
set mapping cylindrical
set angles radians
set contour
set cntrparam bspline
set cntrparam points 30
set output prefix.plot_dir.'radial2d_test'.ext
splot f every :::1 using ($2-pi/2):(0):1:(set_colour($7,$8)) with pm3d lc rgb variable
