#set terminal pdf
nc = "`awk -F, 'NR==1 {print NF;exit}' props.csv`"

set terminal png enhanced truecolor size 800,800
set key autotitle columnhead
set datafile separator ","
set style fill solid 
set output "props.png"
set ytics nomirror
set y2tics nomirror
set autoscale y
set y2range[0.2:0.6]
set style line 5 pt 7 lw 3
plot for [i=2:nc] "props.csv" using 1:i:(100) with linespoints ls 5 lc i
#plot "props.csv" using 1:2:(100) with circles axes x1y1,\
#     "props.csv" using 1:3:(100) with circles axes x1y1,\
#     "props.csv" using 1:4:(100) with circles axes x1y2
