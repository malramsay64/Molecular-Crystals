set terminal png enhanced size 800,800

set xrange [-1:]
set yrange [-1:]

set size ratio -1

set output "crys.png"

plot "crys.dat" every :::::3 using 1:2 with lines title "Unit Cell" ,\
    "crys.dat" every :::4 using 1:2:3 with circles title "Molecules" ,\
    "crys.dat" every :::4 using 1:2 with lines lc -1 title "Bonds" 
