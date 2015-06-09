load '~/make/gnuplot/config.plot'

set terminal term_type size term_size,term_y font ",12"

set output prefix.plot_dir."crys_growth".ext

unset title
#set key top left
unset key
set xlabel "Time"
set ylabel "Crystalline Molecules"
set rmargin 5

collate = "< for f in $(ls trj_contact/*.dat); do echo $(basename ${f%.*}) $(awk '($5>0.80){count++} !/^$/{mols++} END {print count/2}' $f);done"

f(x) = a*x + b
g(x) = c*x + d
FIT_LIMIT=1e-10
fit [4000000:] f(x) collate using ($1*0.005):2 via a,b
fit [3500000:4000000] g(x)  collate using ($1*0.005):2 via c,d

plot collate  using ($1*0.005):2 notitle, \
    [4000000:] f(x) lw 4 title sprintf("%.2e",a)
    #[3500000:4000000] g(x) lw 4 title sprintf("%.2e",c)
