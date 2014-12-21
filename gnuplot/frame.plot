#set terminal pdf enhanced
set terminal png enhanced transparent truecolor size 1600,1600
set yrange[-2:]
set xrange[-2:]

set size ratio -1
#set size square
set output filename.".png"
set datafile separator " "
set style fill transparent solid 1 noborder
set style line 1 lt 1 lc -1 lw 2
plot filename.".dat" using 1:2:3:4 with circles lc variable title "Configuration" ,\
   filename.".dat" every :1 using 1:2  with line ls 1


#set output filename".png"
#set datafile separator " "
#set style fill transparent solid 1 noborder 
#plot "trj/init-frame.csv" using 1:2:3:4 with circles lc variable title "Initial Configuration"


