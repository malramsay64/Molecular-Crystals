set terminal png enhanced truecolor

ext = '.png'
plot_dir = 'myplot/'

set key autotitle columnhead
set logscale x
set yrange [0:1.1]
#set y2range [0:1.1]
set y2tics
set style line 5 pt 7 lw 3
set style fill solid

nd = system("awk -F, 'NR==2 {print NF;exit}' struct.csv")
set datafile separator ","
set output plot_dir."struct".ext

plot "struct.csv" using 1:2 with linespoints ls 5 lc 1 axes x1y1,\
    "struct.csv" using 1:3 with linespoints ls 5 lc 2 axes x1y2

set output plot_dir."chi4".ext
plot "struct.csv" using 1:3 with linespoints ls 5 lc 1 axes x1y2,\
