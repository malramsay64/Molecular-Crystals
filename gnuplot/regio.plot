set terminal png enhanced

ext = '.png'
plot_dir = 'myplot/'


set xlabel 'Position'
set ylabel 'Relaxation'
set logscale y
set y2tics
set style line 5 pt 7 lw 3
set key autotitle columnhead

set datafile separator ','
set output plot_dir.'regio-relax'.ext

plot for [i=2:3] 'regio-relax.csv' using 1:i with linespoints linestyle 5 linecolor i-1,\
    for [i=5:5] 'regio-relax.csv' using 1:i with linespoints linestyle 5 linecolor i-1 axes x1y2

unset logscale y
set logscale x
set xlabel 'Timestep'
set ylabel 'Position'
set zrange [-0.2:1]
set pm3d
set hidden3d

do for [i=4:5]{
    set output plot_dir.'regio_r'.(i-3).ext
    splot 'regio.csv' using 1:2:i with lines
}
