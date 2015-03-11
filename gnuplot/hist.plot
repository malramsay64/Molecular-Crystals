#set terminal pdf
set terminal png

set style data histogram
set style histogram cluster gap 1
set style fill solid border -1
show key
set yrange [0:1]
set xrange [0:15]
set ylabel "Fraction"
set output "histogram.png"

sum(f) = system("awk '{sum+=$2} END {print sum}' stats/".f.".dat")

filenames = "neighbours contacts pairing"
plot for [file in filenames] "stats/".file.".dat" using ($2/sum(file)):xtic(1) title file
