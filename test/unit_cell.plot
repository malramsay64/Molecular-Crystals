
set terminal png enhanced transparent truecolor size 800,800

set polar
set size ratio -1

set output 'unit_cell.png'

plot 'unit_cell.dat' using 1:2:(1) with points
