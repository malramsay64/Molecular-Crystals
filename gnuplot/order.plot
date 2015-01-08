#set terminal pdf

#circ =  "awk 'NR == 1 {old =$1; next} {print $1-old; exit}' @filename"

#circ = 10
set terminal png enhanced transparent truecolor size 800,800
set polar
set yrange[-10:10]
set xrange[-10:10]
set size ratio -1
unset raxis
unset rtics
set output filename.".png"
set datafile separator ","
set style fill transparent solid 0.04 noborder
plot filename.".csv" using 1:2:(0.1):3 with circles lc variable title filename

