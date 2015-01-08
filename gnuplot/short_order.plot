#set terminal pdf
set terminal png enhanced transparent truecolor size 800,800
set polar
set yrange[-3:3]
set xrange[-3:3]
set size ratio -1
unset raxis
unset rtics
set output "short_order.png"
set datafile separator ","
set style fill transparent solid 0.05 noborder
plot "short_order.csv" using 1:2:3:4 with circles lc variable title "Short Order"
