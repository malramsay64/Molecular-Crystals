set terminal png enhanced transparent truecolor

ext = '.png'
plot_dir = 'myplot/'

set style fill transparent solid 0.5 noborder
set key off

set ylabel "Rotation (radians)"
set xlabel "Diffusion"

set datafile separator ","
set output plot_dir."rot-diff".ext

plot "rot_diff.csv" using 3:2 with points pointtype 7 pointsize 0.5
