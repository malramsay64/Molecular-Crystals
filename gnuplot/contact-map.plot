
load '~/make/gnuplot/config.plot'

infile = 'moved.dat'
set datafile separator " "
set output plot_dir."contact-map".ext

set size ratio -1
set key off
set style line 1 linetype 1 linecolor 'black' linewidth 2
set style arrow 1 head filled size screen 0.02,5,90 ls 1
set style fill transparent solid 1 noborder
unset xtics
unset ytics
unset border
set colorbox
set palette defined (0 '#91cf60', 0.5 '#ffffbf', 1 '#fc8d59')
set cbrange [6:15]

a = system("awk 'NR==1 {print  $1; exit}' ".infile)
height = system("awk 'NR==1 {print  $2; exit}' ".infile)
set yrange[-2:height+2]
set xrange[-2:a+2]
set object rectangle from -0,0 to a,height

set terminal term_type enhanced size term_size,term_size/(a+0.)*height

plot infile every :::1 using ($1+$3):($2+$4):(1):6 with circles linecolor palette,\
     infile every :::1 using 1:2:3:4 with vectors arrowstyle 1
