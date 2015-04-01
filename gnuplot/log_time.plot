
term_type = 'png'
ext = '.'.term_type
if (!exists("prefix")) prefix = './'
if (!exists("plot_dir")) plot_dir = 'plots/'
if (!exists("molecule")) molecule = 'Snowman-0.637556-1.0'

set terminal term_type enhanced

glob = system('echo '.molecule.' | sed s/-/-*-/')
files = system("ls -d ".prefix.glob)

temp(s) = system(sprintf("echo %s | cut -d- -f2",s))
e = 2.71828

set xlabel "Timestep"
set ylabel "MSD"
set format x "10^{%L}"
set format y "10^{%L}"
set title molecule font ",14"
set key outside right


set logscale x
set logscale y

set output prefix.plot_dir.molecule.'-msd'.ext
set datafile separator ","
set style line 5 pointtype 7 linewidth 2 pointsize 0.5

plot for [i=1:words(files)] word(files, i)."/msd.csv" using 1:2 with linespoints linestyle 5\
     linecolor i title temp(word(files,i)), \
     0.00001*x linecolor 'black' title 'x'

set output prefix.plot_dir.molecule."-r1".ext
unset logscale y
set format y "%g"
set ylabel "R1"
set yrange [-0.1:1]

plot for [i=1:words(files)] word(files, i)."/rotation.csv" using 1:2 with linespoints linestyle 5\
     linecolor i title temp(word(files,i)), 0 linecolor 'black', 1/e linecolor 'black'

set output prefix.plot_dir.molecule."-r2".ext
set ylabel "R2"

plot for [i=1:words(files)] word(files, i)."/rotation.csv" using 1:3 with linespoints linestyle 5\
     linecolor i title temp(word(files,i)), 0 linecolor 'black', 1/e linecolor 'black'

set output prefix.plot_dir.molecule."-struct".ext
set ylabel "Structure Function"

plot for [i=1:words(files)] word(files, i)."/struct.csv" using 1:2 with linespoints linestyle 5\
     linecolor i title temp(word(files,i)), 0 linecolor 'black', 1/e linecolor 'black'

