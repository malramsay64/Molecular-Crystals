set terminal png enhanced truecolor

ext = '.png'
plot_dir = 'myplot/'

set datafile separator ","

set ytics nomirror
set autoscale y
set logscale y
set style line 5 pt 7 lw 3
set style fill solid 
set key autotitle columnhead

set output plot_dir."props".ext
nc = system("awk -F, 'NR==1 {print NF;exit}' props.csv")

plot for [i=2:nc] "props.csv" using 1:i:(100) with linespoints ls 5 lc i
