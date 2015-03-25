set terminal png enhanced transparent truecolor

ext = '.png'
plot_dir = 'myplot/'

set polar
set yrange[-3:3]
set xrange[-3:3]
set size ratio -1
unset raxis
unset rtics
set style fill transparent solid 0.05 noborder

set output plot_dir."short-order".ext
set datafile separator ","

plot "short_order.csv" using 1:2:3:4 with circles lc variable title "Short Order"
