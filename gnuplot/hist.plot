load '~/make/gnuplot/config.plot'

set terminal term_type

set style data histogram
set style histogram cluster gap 0.5
set style fill solid border -1
set key on
set yrange [0:1.1]
set xrange [0:15]
set ylabel "Fraction"
set output plot_dir."hist".ext
set key top left

sum(f) = system("awk '{sum+=$2} END {print sum}' stats/".f.".dat")

filenames = "neighbours contacts pairing"
plot for [f in filenames] "stats/".f.".dat" using ($2/sum(f)):xtic(1) title f
