load '~/make/gnuplot/collate_config.plot'

set terminal term_type enhanced size term_size*scaling, term_y*scaling font ",".font_size

set datafile separator ","
set datafile missing 'NAN'
set logscale y
set format y "10^{%L}"
set style line 5 pt 7 lw 2*scaling ps 0.5*scaling
set key outside right

columns(f) = system("awk -F, 'NR==1 {print NF;exit}' ".f.".csv")

mols = system('ls '.prefix.plot_dir."*\-contact.csv")

mol(m) = system('f=$(basename '.m.' | sed s/\-contact.csv//g); if [[ $f = Snowman-0.637556-1.0 ]] ; \
then echo S1 ; else if [[ $f = Snowman-0.637556-1.637556 ]] ; then echo Sc ; else echo Tr ; fi; fi')

contact = prefix.plot_dir.molecule."-contact"
num_c = columns(contact)

do for [i=2:num_c] {

    command = sprintf("awk -F, 'NR==1 {print $%i;exit}' %s.csv", i, contact)
    set output prefix.plot_dir.system(command).ext
    set xlabel "1/T"
    set ylabel system(command)
    plot for [j=1:words(mols)] word(mols,j) using (1/$1):i with linespoints ls 5 lc j title mol(word(mols,j))
}

unset logscale y
set format y "%g"

set output prefix.plot_dir.'t1.t2'.ext
set ylabel 't1/t2'
plot for [j=1:words(mols)] word(mols,j) using (1/$1):($2*$3) with linespoints ls 5 lc j title mol(word(mols,j))

set output prefix.plot_dir.'D.t1.T'.ext
set ylabel 'D.{Symbol t}_1/t'
plot for [j=1:words(mols)] word(mols,j) using (1/$1):($2*$3) with linespoints ls 5 lc j title mol(word(mols,j))

set output prefix.plot_dir.'t1.D'.ext
set ylabel't1.D'
plot for [j=1:words(mols)] word(mols,j) using (1/$1):($2*$5) with linespoints ls 5 lc j title mol(word(mols,j))

set output prefix.plot_dir.'t2.D'.ext
set ylabel't2.D'
plot for [j=1:words(mols)] word(mols,j) using (1/$1):($3*$5) with linespoints ls 5 lc j title mol(word(mols,j))


