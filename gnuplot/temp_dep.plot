ext = '.png'

set terminal png enhanced

set datafile separator ","

set key off
set logscale y
set format y "10^{%L}"
set style line 5 pt 7 lw 3
set title font ",14"

columns(f) = system(sprintf("awk -F, 'NR==1 {print NF;exit}' %s.csv", f))
shape(s) = system(sprintf("echo %s | cut -d/ -f7-",s))

contact = filename."-contact"
num_c = columns(contact)

do for [i=2:num_c] {

    command = sprintf("awk -F, 'NR==1 {print $%i;exit}' %s.csv", i, contact)
    f = contact."_".system(command)

    set title shape(filename)
    set output f.ext
    set xlabel "1/T"
    set ylabel system(command)
    plot contact.".csv" using (1/$1):i with linespoints ls 5 lc 1

}

# Ordering

ordering = filename."-order"
num_o = columns(ordering)
set output ordering.ext
set nologscale y
set format y "%g"
set yrange [0:1]
set key on autotitle columnhead
set xlabel "1/T"
set ylabel

plot for [i=2:num_o] ordering.".csv" using (1/$1):i with linespoints ls 5 lc i-1

# Combination Functions

set output contact."-t1.t2".ext
unset yrange

plot contact.".csv" using (1/$1):($2/$3) with linespoints ls 5 lc 1 title 't1/t2'


set output contact."-t.D".ext


plot contact.".csv" using (1/$1):($2*$5) with linespoints ls 5 lc 1 title "t1.D",\
    contact.".csv" using (1/$1):($3*$5) with linespoints ls 5 lc 2 title "t2.D"
