set terminal png enhanced truecolor size 1600,1600
set polar
set angles degrees
set size square
set rrange[-0.1:0.6]
set grid polar 10
set datafile separator ","

set_label(x, text) = sprintf("set label '%s' at (0.55*cos(%f)), (0.55*sin(%f))     center", text, x, x)
eval set_label(0, "0")
eval set_label(60, "60")
eval set_label(120, "120")
eval set_label(180, "180")
eval set_label(240, "240")
eval set_label(300, "300")

set output filename.".png"
set style line 5 pt 7 lw 3
plot filename.".csv" using 1:2 with linespoints ls 5 lc 1 ,\
    filename.".csv" using 1:3 with linespoints ls 5 lc 2
    
    #filename.".csv" using 1:2:(0.005) with circles title "Absolute Angle",\
    #filename.".csv" using 1:2 with linespoints 5,\
    #filename.".csv" using 1:3:(0.005) with circles title "Relative Angle",\
    #filename.".csv" using 1:3 with lines 2
