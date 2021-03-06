set terminal png enhanced truecolor size 800,800

ext ='.png'
filename = 'hexatic'
in_ext = '.csv'
infile = filename.in_ext
plot_dir = 'myplot/'

set datafile separator ","
set style fill solid
set key autotitle columnhead

set style line 5 pt 7 lw 3

nc = system("awk -F, 'NR==2 {print NF;exit}' ".infile)

set output myplot.filename.ext
set logscale y
set logscale x

plot for [i=2:nc] infile using 1:i with linespoints ls 5 lc i-1
