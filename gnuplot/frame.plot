load '~/make/gnuplot/config.plot'

set size ratio -1
set datafile separator " "
set style fill transparent solid 1 noborder
set style line 1 lt 1 lc -1 lw 1

set pm3d
set palette file '~/make/gnuplot/husl.dat' every ::1 using 1:2:3:4
set key off
unset colorbox
unset border
unset xtics
unset ytics

my_green = '#4BAC6F'

files = system('ls '.prefix.'/trj_contact/*.dat')
mod(a,b) = a-b*floor(a/b)

do for [i=1:words(files)] {

    infile = word(files,i)

    set output plot_dir."frame-".system("basename ".infile." .dat").ext

    a = system("awk 'NR==1 {print  $1; exit}' ".infile)
    height = system("awk 'NR==1 {print  $2; exit}' ".infile)
    set yrange[-2:height+2]
    set xrange[-2:a+2]

    set terminal term_type enhanced size term_size*scaling, term_size/(a+0.)*height*scaling

    set object rectangle from -0,0 to a,height

    plot infile every :::1 using 1:2:3 with circles lc rgb 'black',\
         infile every :::1 using 1:2:($3-0.05):(mod($4,pi)) \
                with circles lc palette title "Configuration",\
         infile every :1::1 using 1:2 with line ls 1

         # If statement for only colouring those with appropriate neighbours
         #infile every :::1 using 1:2:($3-0.05):($7==2||$7==3||$7==4?(mod($4,pi)):(-1)) 
}
