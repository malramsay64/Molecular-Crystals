# Default values for plotting each at each temperature

if (!exists("term_type")) term_type = 'pdf'

if (term_type eq 'pdf'){
    term_size = 5
    term_y = 3
    scaling = 1
}
else {
    if (term_type eq 'png'){
        term_size = 640
        term_y = 480
        scaling = 4
    }
}
ext = ".".term_type
font_size = 12*scaling

if (!exists("plot_dir")) plot_dir = 'myplot/'
if (!exists("prefix")) prefix = './'
