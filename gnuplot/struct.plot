set terminal png enhanced truecolor size 800,800

set datafile separator ","
set style fill solid
set key autotitle columnhead
set logscale x
#set xrange [1:10]

set yrange [0:1.1]
set y2range [0:1.1]

set style line 5 pt 7 lw 3

# Diffusion
nd = "`awk -F, 'NR==2 {print NF;exit}' struct.csv`"
#nd = 2

set output "struct.png"

plot "struct.csv" using 1:2 with linespoints ls 5 lc 1 axes x1y1,\
    "struct.csv" using 1:3 with linespoints ls 5 lc 2 axes x1y2
