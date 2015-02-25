ext = '.png'

set terminal png enhanced

set datafile separator ","

set key off
set logscale y
set style line 5 pt 7 lw 3

command = sprintf("awk -F, 'NR==2 {print NF;exit}' %s.csv", filename)
nd = system(command)
shape(s) = system(sprintf("echo %s | cut -d/ -f7-",s))

do for [i=2:nd] {

    command = sprintf("awk -F, 'NR==1 {print $%i;exit}' %s.csv", i, filename)
    f = filename."_".system(command)

    set title shape(filename)
    set output f.ext
    set xlabel "1/T"
    set ylabel system(command)
    plot filename.".csv" using (1/$1):i with linespoints ls 5 lc 1

}
