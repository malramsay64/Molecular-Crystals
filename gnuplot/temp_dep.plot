set terminal png enhanced truecolor size 1600,1600

set datafile separator ","
set style fill solid
set key autotitle columnhead
#set logscale x
#set xrange [2:4]

set style line 5 pt 7 lw 3

# Diffusion
command = sprintf("awk -F, 'NR==2 {print NF;exit}' %s.csv", filename)
nd = system(command)
#nd = "`awk -F, 'NR==2 {print NF;exit}' temps.csv`"
#nd = 2

set output filename.".png"
plot for [i=2:nd] filename.".csv" using 1:i with linespoints ls 5 lc i-1

