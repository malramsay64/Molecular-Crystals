set terminal png enhanced size 1600,1600

set xrange [-0.5:]
set yrange [-0.5:]

set size ratio -1

set output "crys.png"
set datafile separator ","

plot "crys.dat" every :::::3 using 1:2 with lines title "Unit Cell" ,\
    "crys.dat" every :::4 using 1:2:3 with circles title "Molecules" ,\
    "crys.dat" every :::4 using 1:2 with lines lc -1 title "Bonds" 
