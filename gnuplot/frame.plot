
#set terminal pdf enhanced
set terminal png enhanced transparent truecolor size 3200,3200

ext = ".png"
prefix ="./"
plot_dir = 'myplot/'

set size ratio -1
set datafile separator " "
set style fill transparent solid 1 noborder
set style line 1 lt 1 lc -1 lw 2

set pm3d
set palette model HSV defined ( 0 0 1 1, 1 1 1 1 )
set key off
unset colorbox
unset border
unset xtics
unset ytics

my_green = '#4BAC6F'

files = system('ls '.prefix.'/trj_contact/*.dat')

do for [i=1:words(files)] {

    f = word(files,i)

    set output plot_dir."frame-".system("basename ".f." .dat").ext

    a = system("awk 'NR==1 {print  $1; exit}' ".f)
    height = system("awk 'NR==1 {print  $2; exit}' ".f)
    set yrange[-2:height+2]
    set xrange[-2:a+2]

    set object rectangle from -0,0 to a,height
    plot "< tail -n +3 ".f using 1:2:3 with circles lc rgb 'black' ,\
         "< tail -n +3 ".f using 1:2:($3-0.05):4 with circles lc palette title "Configuration" ,\
        "< tail -n +3 ".f every :1 using 1:2 with line ls 1
}
