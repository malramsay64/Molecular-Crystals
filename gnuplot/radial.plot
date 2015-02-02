set terminal png enhanced truecolor size 800,800

set style fill solid
set xrange [0:15]

set style line 5 lw 3

set output "radial.png"

plot "radial_dist.dat" using 1:2 with line ls 5 lc -1 title 'Radial Distribution'
