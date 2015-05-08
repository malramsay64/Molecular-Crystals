load '~/make/gnuplot/collate_config.plot'

set terminal term_type enhanced size term_size*scaling, term_y*scaling font ",".font_size

set datafile separator ","

set logscale y
set format y "10^{%L}"
set style line 5 pt 7 lw 2*scaling ps 0.5*scaling

columns(f) = system(sprintf("awk -F, 'NR==1 {print NF;exit}' %s.csv", f))
shape(s) = system(sprintf("echo %s | cut -d/ -f7-",s))

# Ordering

ordering = prefix.plot_dir.molecule."-order"
num_o = columns(ordering)
set output ordering.ext
set nologscale y
set format y "%g"
set yrange [0:1]
set key on outside top autotitle columnhead 
set xlabel "1/T"
set ylabel

plot for [i=2:num_o] ordering.".csv" using (1/$1):i with linespoints ls 5 lc i-1
