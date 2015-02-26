#set terminal pdf enhanced
set terminal png enhanced transparent truecolor size 3200,3200

file = 'complot.dat'

a = system(sprintf("awk 'NR==1 {print  $1; exit}' %s", file))
height = system(sprintf("awk 'NR==1 {print  $2; exit}' %s", file))

set yrange[-2:height+2]
set xrange[-2:a+2]

set size ratio -1
#set size square
set output "complot.png"
set datafile separator " "
set object rectangle from -0,0 to a,height
set style fill transparent solid 1 noborder
set style line 1 lt 1 lc -1 lw 2
plot file using 1:2 with points lc 'black' pointsize 2 pointtype 7 title "Centers of Mass"


