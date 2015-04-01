load 'collate_config.plot'

set terminal term_type enhanced term_size*scaling, term_y*scaling

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

do for [i=2:3] {

    command = sprintf("awk -F, 'NR==1 {print $%i;exit}' %s.csv", i, contact)
    f = contact."_".system(command)

    set title shape(filename)
    set output f.ext
    set xlabel "1/T"
    set ylabel system(command)
    plot contact.".csv" using (1/$1):i with linespoints ls 5 lc 1, x

}

# Combination Functions

set output contact."-t1.t2".ext
set yrange [:]

plot contact.".csv" using (1/$1):($1/$2) with linespoints ls 5 lc 1 
