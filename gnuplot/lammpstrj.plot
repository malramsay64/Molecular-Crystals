load '~/make/gnuplot/config.plot'

set size ratio -1
set datafile separator " "
set style fill transparent solid 1 noborder
set style line 1 lt 1 lc -1 lw 1

set pm3d
set palette file '~/make/gnuplot/husl.dat' using 1:2:3:4
set key off
unset colorbox
unset border
unset xtics
unset ytics

my_green = '#4BAC6F'


files = system('ls '.prefix.'*.lammpstrj')
mod(a,b) = a-b*floor(a/b)
print files
do for [i=1:words(files)] {

    infile = word(files,i)
    print infile
    set output plot_dir."frame-".system("basename ".infile." .dat").ext

    a = system("awk 'NR==6 {print  $2; exit}' ".infile)
    height = system("awk 'NR==7 {print  $2; exit}' ".infile)
    set yrange[-8:height+8]
    set xrange[-8:a+8]
    print a
    print height
    set terminal term_type enhanced size term_size, term_size/(a+0.)*height

    set object rectangle from -0,0 to a,height
    atoms = system("awk 'NR==4 {print $1; exit}' ".infile)
    print 'Atoms: '.atoms
    plot "< awk 'NR>9 {print $0} NR==9+".atoms." {exit}' ".infile using (mod($5,a)):6:($4/2) with circles lc rgb my_green

}
