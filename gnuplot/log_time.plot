ext = '.png'

set terminal png enhanced

files = system("ls -d ".prefix)

temp(s) = system(sprintf("echo %s | cut -d- -f2",s))
shape(s) = system(sprintf("echo %s | cut -d- -f1,3-| cut -d/ -f6-",s))
plot_dir = system(sprintf("echo %s/plots/ | cut -d/ -f-5,7-",prefix))


set xlabel "Timestep"
set ylabel "MSD" 
set title shape(word(files,1)) font ",14"
set key top left

set logscale x
set logscale y

set output plot_dir.shape(word(files,1)).'_msd'.ext
set datafile separator ","
set style line 5 pointtype 7 linewidth 2 pointsize 0.5

plot for [i=1:words(files)] word(files, i)."/msd.csv" using 1:2 with linespoints linestyle 5\
     linecolor i title temp(word(files,i))

set output plot_dir.shape(word(files,1))."_rot_1".ext
unset logscale y
set ylabel "R1"
set yrange [-0.1:1]

plot for [i=1:words(files)] word(files, i)."/rotation.csv" using 1:2 with linespoints linestyle 5\
     linecolor i title temp(word(files,i)), 0 linecolor 'black'

set output plot_dir.shape(word(files,1))."_rot_2".ext
set ylabel "R2"

plot for [i=1:words(files)] word(files, i)."/rotation.csv" using 1:3 with linespoints linestyle 5\
     linecolor i title temp(word(files,i)), 0 linecolor 'black'

set output plot_dir.shape(word(files,1))."_struct".ext
set ylabel "Structure Function"

plot for [i=1:words(files)] word(files, i)."/struct.csv" using 1:2 with linespoints linestyle 5\
     linecolor i title temp(word(files,i))





