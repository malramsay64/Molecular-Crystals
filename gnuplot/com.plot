load "~/make/gnuplot/config.plot"


infile = prefix.'/complot.dat'
a = system("awk 'NR==1 {print  $1; exit}' ".infile)
height = system("awk 'NR==1 {print  $2; exit}' ".infile)


set xrange[-2:a+2]
#set pm3d
#set palette defined (0 "#ffeea0", 1 "#f03b20")
set size ratio -1
set object rectangle from -0,0 to a,height
set style fill transparent solid 1 noborder
set style line 1 lt 1 lc -1 lw 2
set key off
unset xtics
unset ytics
unset border

set output prefix.plot_dir."com".ext
set datafile separator " "
set terminal term_type size term_size,(term_size/a)*height

plot infile every ::1 using 1:2 with points lc 'black' pointsize 0.5 pointtype 7 title "Centers of Mass"

set output plot_dir."com_neigh".ext
set palette defined (0 "blue", 1 "red")
unset colorbox
plot infile every ::1 using 1:2:($5+0.==6?1.0:0.0) with points lc palette pointsize 0.5 pointtype 7 title "Centers of Mass"
