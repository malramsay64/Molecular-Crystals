#set terminal pdf
set terminal png

set style data histogram
set style histogram cluster gap 1
set style fill solid border -1
show key

set output "histogram.png"

filenames = "neighbours contacts"
plot for [file in filenames] "stats/".file.".dat" using 2:xtic(1) title file
