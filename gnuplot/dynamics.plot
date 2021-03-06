load '~/make/gnuplot/collate_config.plot'

set terminal term_type enhanced size term_size*scaling, term_y*scaling font ",".font_size

set datafile separator ","
set datafile missing 'NAN'
set logscale y
set format y "10^{%L}"
set style line 5 pt 7 lw 4*scaling ps 0.5*scaling

set key outside right

columns(f) = system("awk -F, 'NR==1 {print NF;exit}' ".f.".csv")

mols = system('ls '.prefix.plot_dir."*\-contact.csv")

mol(m) = system('f=$(basename '.m.' | sed s/\-contact.csv//g); if [[ $f = Snowman-0.637556-1.0 ]] ; \
then echo D1 ; else if [[ $f = Snowman-0.637556-1.637556 ]] ; then echo Dc ; else echo Tr ; fi; fi')

contact = prefix.plot_dir.molecule."-contact"
num_c = columns(contact)

set yrange [10**-1:10**7]
set format y "10^{%L}"
set xlabel "1/T"
set format x "%.1f"
set xtics 0.2
set output prefix.plot_dir."t1".ext
set ylabel "{/Symbol t}_1"
FIT_LIMIT=1e-10
f(x) = m*x+b
g(x) = n*x+c
h(x) = o*x+d
fit [1:] f(x) word(mols,1) using (1/$1):(log($2)) via m,b
fit [0.5:0.6] g(x) word(mols,2) using (1/$1):(log($2)) via n,c
fit [0.6:0.9] h(x) word(mols,3) using (1/$1):(log($2)) via o,d
plot for [j=1:words(mols)] word(mols,j) using (1/$1):2 with linespoints ls 5 lc j title mol(word(mols,j)),\
    [1:] exp(f(x)) ls 5 lc 4 title sprintf("%.2f",m),\
    [0.5:0.6] exp(g(x)) ls 5 lc 5 title sprintf("%.2f",n),\
    [0.6:0.9] exp(h(x)) ls 5 lc 6 title sprintf("%.2f",o)

set output prefix.plot_dir."t2".ext
set ylabel "{/Symbol t}_2"
plot for [j=1:words(mols)] word(mols,j) using (1/$1):3 with linespoints ls 5 lc j title mol(word(mols,j))

set output prefix.plot_dir."ts".ext
fit [1:] f(x) word(mols,1) using (1/$1):(log($4)) via m,b
fit [0.5:0.6] g(x) word(mols,2) using (1/$1):(log($4)) via n,c
fit [0.6:0.9] h(x) word(mols,3) using (1/$1):(log($4)) via o,d
set ylabel "{/Symbol t}_s"
plot for [j=1:words(mols)] word(mols,j) using (1/$1):4 with linespoints ls 5 lc j title mol(word(mols,j)),\
    [1:] exp(f(x)) ls 5 lc 4 title sprintf("%.2f",m),\
    [0.5:0.6] exp(g(x)) ls 5 lc 5 title sprintf("%.2f",n),\
    [0.6:0.9] exp(h(x)) ls 5 lc 6 title sprintf("%.2f",o)

unset yrange

set output prefix.plot_dir."D".ext
set ylabel "D"
plot for [j=1:words(mols)] word(mols,j) using (1/$1):5 with linespoints ls 5 lc j title mol(word(mols,j))

set output prefix.plot_dir."DW".ext
set ylabel "DW"
plot for [j=1:words(mols)] word(mols,j) using (1/$1):6 with linespoints ls 5 lc j title mol(word(mols,j))

unset logscale y
set format y "%.1f"

set output prefix.plot_dir.'t1.t2'.ext
set ylabel '{/Symbol t}_1/{/Symbol t}_2'
plot for [j=1:words(mols)] word(mols,j) using (1/$1):($2/$3) with linespoints ls 5 lc j title mol(word(mols,j))

set output prefix.plot_dir.'t1.ts'.ext
set ylabel '{/Symbol t}_1/{/Symbol t}_s'
plot for [j=1:words(mols)] word(mols,j) using (1/$1):($2/$4) with linespoints ls 5 lc j title mol(word(mols,j))

set output prefix.plot_dir.'t2.ts'.ext
set ylabel '{/Symbol t}_2/{/Symbol t}_s'
plot for [j=1:words(mols)] word(mols,j) using (1/$1):($3/$4) with linespoints ls 5 lc j title mol(word(mols,j))


set output prefix.plot_dir.'D.t1.T'.ext
set ylabel 'D.{/Symbol t}_1/T'
plot for [j=1:words(mols)] word(mols,j) using (1/$1):($5*$3/$1) with linespoints ls 5 lc j title mol(word(mols,j))

set output prefix.plot_dir.'D.t1'.ext
set ylabel'D.{/Symbol t}_1'
plot for [j=1:words(mols)] word(mols,j) using (1/$1):($2*$5) with linespoints ls 5 lc j title mol(word(mols,j))

set output prefix.plot_dir.'D.ts.T'.ext
set ylabel'D.{/Symbol t}_s/T'
plot for [j=1:words(mols)] word(mols,j) using (1/$1):($5*$4/$1) with linespoints ls 5 lc j title mol(word(mols,j))

set format y "%.2f"
set output prefix.plot_dir.'D.ts'.ext
set ylabel'D.{/Symbol t}_s'
plot for [j=1:words(mols)] word(mols,j) using (1/$1):($5*$4) with linespoints ls 5 lc j title mol(word(mols,j))

set xlabel "1/<u^2>"
set ylabel "D"
set logscale y
set xtics 5

set format y "10^{%L}"
set output prefix.plot_dir."DW.D".ext
plot for [j=1:words(mols)] word(mols,j) using (1/$6):($5) with linespoints ls 5 lc j title mol(word(mols,j))


set output prefix.plot_dir."DW.t1".ext
set xlabel "1/<u^2>"
set ylabel "{/Symbol t}_1"
set logscale y
plot for [j=1:words(mols)] word(mols,j) using (1/$6):($2) with linespoints ls 5 lc j title mol(word(mols,j))

set output prefix.plot_dir."DW.ts".ext
set xlabel "1/<u^2>"
set ylabel "{/Symbol t}_s"
set logscale y
plot for [j=1:words(mols)] word(mols,j) using (1/$6):($4) with linespoints ls 5 lc j title mol(word(mols,j))
