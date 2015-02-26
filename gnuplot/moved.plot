ext = '.png'

set terminal png enhanced transparent size 1600, 1200

set size ratio -1

set datafile separator " "
set style line 1 linetype 1 linecolor 'red' linewidth 0.5
set key off

file = 'moved.dat'

a = system(sprintf("awk 'NR==1 {print  $1; exit}' %s", file))
height = system(sprintf("awk 'NR==1 {print  $2; exit}' %s", file))

set yrange[-2:height+2]
set xrange[-2:a+2]

set object rectangle from -0,0 to a,height

set output "moved".ext
set style fill transparent solid 1 noborder

plot "< tail -n +2 moved.dat" using 1:2 with line linestyle 1,\
     "< tail -n +2 moved.dat" using 1:2:($3*2) with circles linecolor 'purple'
