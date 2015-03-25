set terminal png enhanced truecolor

ext = '.png'
prefix = './'
plot_dir = 'myplot/'

set key autotitle columnhead
set yrange [-0.1:1]
set style fill solid
set style line 5 pt 7 lw 3

# Rotations
nc = system("awk -F, 'NR==1 {print NF;exit}' rotation.csv")
set datafile separator ","
set output plot_dir."rotation".ext

plot for [i=2:nc] "rotation.csv" using 1:i with linespoints ls 5 lc i-1,\
    0 lc 0,\
    0.25 lc 0,\
    0.1406 lc 0
