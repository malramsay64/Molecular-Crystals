#set terminal pdf enhanced
set terminal png enhanced transparent truecolor size 1600,1600

file = filename.'.dat'

a = system(sprintf("awk 'NR==1 {print  $1; exit}' %s", file))
height = system(sprintf("awk 'NR==1 {print  $2; exit}' %s", file))

set yrange[-3:height+3]
set xrange[-3:a+3]

set size ratio -1
#set size square
set output filename.".png"
set datafile separator " "
set object rectangle from 0,0 to a,height
set style fill transparent solid 1 noborder
set style line 1 lt 1 lc -1 lw 2
plot filename.".dat" every ::1 using 1:2:3:4 with circles lc variable title "Configuration" ,\
   filename.".dat" every :1:1 using 1:2  with line ls 1


#set output filename".png"
#set datafile separator " "
#set style fill transparent solid 1 noborder 
#plot "trj/init-frame.csv" using 1:2:3:4 with circles lc variable title "Initial Configuration"


