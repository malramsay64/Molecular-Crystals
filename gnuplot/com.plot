
term_type = 'pdf'
if (term_type eq 'pdf'){
    term_size = 5
}
else {
    term_size = 640
}
ext = '.'.term_type
infile = 'complot.dat'
plot_dir = 'myplot/'

a = system("awk 'NR==1 {print  $1; exit}' ".infile)
height = system("awk 'NR==1 {print  $2; exit}' ".infile)

set yrange[-2:height+2]
set xrange[-2:a+2]
set pm3d
set palette defined (0 "#ffeea0", 1 "#f03b20")
set size ratio -1
set object rectangle from -0,0 to a,height
set style fill transparent solid 1 noborder
set style line 1 lt 1 lc -1 lw 2
set key off
unset xtics
unset ytics
unset border

set output plot_dir."com".ext
set datafile separator " "
set terminal term_type size term_size,(term_size/a)*height


plot infile using 1:2:3 with points lc palette pointsize 0.5 pointtype 7 title "Centers of Mass"


