load '~/make/gnuplot/config.plot'

set terminal term_type enhanced size term_size*scaling, term_size*scaling font ",".font_size

my_colour = '#2b8cbe'
my_green = '#4BAC6F'
circle_colour = my_green

set datafile separator " "
set key off
set style fill solid
unset xtics
unset ytics
unset border
set size ratio -1
set xrange [-2:2]
set yrange [-1.5:1.5]

f = prefix.'radial2d.dat'

set output prefix.plot_dir.'mol'.ext
plot f every :::0::0 using 1:2:3 with circles linecolor 'black',\
     f every :::0::0 using 1:2:($3-0.02) with circles linecolor rgb circle_colour

