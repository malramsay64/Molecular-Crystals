ext='.png'
set terminal png enhanced

set key autotitle columnhead
set datafile separator ','

set xlabel 'Position'
set ylabel 'Relaxation'
set logscale y
set output 'regio-relax'.ext
#set y2range [0:1]
set y2tics
set style line 5 pt 7 lw 3

plot for [i=2:3] 'regio-relax.csv' using 1:i with linespoints linestyle 5 linecolor i-1,\
    for [i=5:5] 'regio-relax.csv' using 1:i with linespoints linestyle 5 linecolor i-1 axes x1y2

unset logscale y
set logscale x
set hidden3d
set xlabel 'Timestep'
set ylabel 'Position'
set zrange [-0.2:1]

do for [i=4:5]{
    set output 'regio_r'.(i-3).ext
    set pm3d
    splot 'regio.csv' using 1:2:i with lines
}
