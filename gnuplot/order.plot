set terminal png enhanced transparent truecolor size 800,800

ext = ".png"
prefix = "./"


set polar
set yrange[-10:10]
set xrange[-10:10]
set size ratio -1
unset raxis
unset rtics
set datafile separator ","
set style fill transparent solid 0.04 noborder

files = system("ls ".prefix."/order/*.csv")

do for [i=1:words(files)] {

    f = word(files,i)

    set output system("basename ".f." .csv")
    plot f using 1:2:(0.1):3 with circles lc variable

}
