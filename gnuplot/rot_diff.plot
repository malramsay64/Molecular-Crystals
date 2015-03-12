ext = '.png'

set terminal png enhanced transparent truecolor

set datafile separator ","

set output "rot_diff".ext
set style fill transparent solid 0.5 noborder
set key off
#set logscale x
#set logscale y

set ylabel "Rotation (radians)"
set xlabel "Diffusion"

plot "rot_diff.csv" using 3:2 with points pointtype 7 pointsize 0.5
