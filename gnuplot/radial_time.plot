load '~/make/gnuplot/config.plot'

set terminal term_type enhanced size term_size*scaling, term_y*scaling font ",".font_size

set xlabel "Distance"
set ylabel ""
set key outside right
set style line 5 linewidth 2*scaling
set xrange [0:4]
set yrange [0:]
set datafile missing "nan"
set datafile separator ","

no_ext(f) = system("f=".f."; echo ${f%.*}")
radial = "radial_time.csv"

set output prefix.plot_dir."radial_time".ext

stats radial
unset key

skip=2

plot for [i=0:STATS_blank:skip] radial every :::i::i using 1:($2+0*i*2/skip) with lines ls 5 lc i/skip+1, \
    #for [i=0:STATS_blank:skip] i*2/skip+1 lc 'black'
