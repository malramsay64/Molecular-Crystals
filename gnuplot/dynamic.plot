set terminal png enhanced truecolor size 800,800

set datafile separator ","
set style fill solid
set key autotitle columnhead
#set logscale x
#set xrange [1:10]

set style line 5 pt 7 lw 3

# Diffusion
nd = "`awk -F, 'NR==2 {print NF;exit}' msd.csv`"
#nd = 2

set output "msd.png"
plot for [i=2:nd] "msd.csv" using 1:i with linespoints ls 5 lc i-1

# Rotations
nc = "`awk -F, 'NR==1 {print NF;exit}' rotation.csv`"

set yrange [-0.1:1]
set output "rotation.png"
plot for [i=2:nc] "rotation.csv" using 1:i with linespoints ls 5 lc i-1
