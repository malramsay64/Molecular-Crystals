
load '~/make/gnuplot/config.plot'

set terminal term_type enhanced font ','.font_size size term_size*scaling, term_y*scaling

#set key outside
set style line 1 pointtype 7 linewidth 4*scaling pointsize 1*scaling
set ylabel 'Packing Fraction'
set yrange [0.8:1.05]
set key outside width 0 samplen 1 spacing 1
grey = '#FFFFFF'

# Packing fraction function of dist
set xlabel 'Distance'

r = '0.5 0.6 0.637556 0.7 0.8 0.9 1.0'

set output 'dist-iso'.ext
plot for [i=1:words(r)] 'Snowman-iso.dat' using 2:($1==word(r,i)?$3:1/0) with linespoints linestyle 1 lc i title word(r,i), 0.9069 lc grey title 'Circle'

# Packing fraction as a function of radius
set xlabel 'Radius'

d = '1.0 1+0.2r 1+0.4r 1+0.6r 1+0.8r 1+r'

set output 'radius-iso'.ext
plot for [i=1:words(d)] 'Snowman-iso.dat' using 1:3 with linespoints linestyle 1 lc i title word(d,i), 0.9069 lc grey title 'Circle'

