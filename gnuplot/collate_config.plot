# Default values for collating plots

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
font_size = sprintf("%i",10*scaling)

if (!exists("plot_dir")) plot_dir = 'plots/'
if (!exists("prefix")) prefix = './'
if (!exists("molecule")) molecule = 'Snowman-0.637556-1.0'

# Put wildcard in the position of the temperature
glob = system('echo '.molecule.' | sed s/-/-*-/')
files = system('ls -d '.prefix.glob)

temp(mol) = system( 'echo '.mol.' | cut -d- -f2')

#colours = "#e41a1c #377eb8 #4daf4a #984ea3 #ff7f00 #ffff33 #a65628 #f781bf"
#"#e41a1c #377eb8 #4daf4a #984ea3 #ff7f00 #ffff33 #a65628 #f781bf #999999"


