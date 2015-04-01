# Default values for collating plots

if (!exists("term_type")) term_type = 'pdf'
if (term_type eq 'pdf'){
    term_size = 5
    scaling = 1
else if (term_type eq 'png'){
    term_size = 640
    scaling = 4
}
ext = ".".term_type

if (!exists("plot_dir")) plot_dir = 'plots/'
if (!exists("prefix")) prefix = './'
if (!exists("molecule")) molecule = 'Snowman-0.637556-1.0'

# Put wildcard in the position of the temperature
glob = system('echo '.molecule.' | sed s/-/-*-/')
files = system('ls -d '.prefix.glob)

temp(mol) = system( 'echo '.mol.' | cut -d- -f2')
