set terminal png enhanced truecolor

ext = '.png'
prefix = './'
plot_dir = 'myplot/'

set polar
set angles degrees
set size square
set rrange[-0.1:0.6]
set grid polar 10
set datafile separator ","

set style line 5 pt 7 lw 3

files = system('ls '.prefix.'trj_contact/*.csv')

do for [i = 1:words(files)] {

    f = word(files,i)
    set output plot_dir."angle-".system("basename ".f." csv")

    # Labels
    set_label(x, text) = sprintf("set label '%s' at (0.55*cos(%f)), (0.55*sin(%f))     center", text, x, x)
    eval set_label(0, "0")
    eval set_label(60, "60")
    eval set_label(120, "120")
    eval set_label(180, "180")
    eval set_label(240, "240")
    eval set_label(300, "300")

    plot f using 1:2 with linespoints ls 5 lc 1 title 'absolute',\
        f using 1:3 with linespoints ls 5 lc 2 title 'relative'

}
