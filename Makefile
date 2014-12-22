

PRE=files data lammps
TARGETS=contact plot density clean-all clean-contact clean-plot clean-lammps clean-files clean-density touch-lammps plot-props clean-present 
PRESENT=grouped individual

include settings
include config

MODULES:=$(wildcard $(LIB)/*.cpp)
MODULES:=$(MODULES:.cpp=.o)
MODULES:=$(notdir $(MODULES))
HEADERS:=$(wildcard $(LIB)/*.h)
HEADERS:=$(notdir $(HEADERS))

ifeq ($(SYS_NAME), unix)
	CXXFLAGS := $(CXXFLAGS) -pthread -Wl,--no-as-needed
endif

empty=
space=$(empty) $(empty)

reverse = $(if $(wordlist 2,2,$(1)),$(call reverse,$(wordlist 2,$(words $(1)),$(1))) $(firstword $(1)),$(1))
t_shape = $(word 1, $(subst -,$(space),$(1)) )
t_rad = $(word 2, $(subst -,$(space),$(1)) )
t_dist = $(word 3, $(subst -,$(space),$(1)) )
t_theta = $(word 4, $(subst -,$(space),$(1)) )

GOAL=Makefile.run
LOOP=Makefile.loop

export

comp_dist = $(shell echo $(1:radius=$2) |bc)

# Shape
mol := $(shape)
# Radius
mol := $(if $(radius), $(foreach rad, $(radius), $(addsuffix -$(rad), $(mol))), $(mol)) 
# Distance
mol := $(if $(dist), $(foreach rad, $(dist), $(addsuffix -$(rad), $(mol))), $(mol)) 
# Computing Distance
mol := $(foreach m, $(mol), $(m:$(call t_dist, $m)=$(call comp_dist, $(call t_dist, $m), $(call t_rad, $m))))
# Theta
mol_s := $(filter Snowman%, $(mol))
mol_t := $(filter Trimer%, $(mol))
mol_t := $(foreach rad, $(theta), $(addsuffix -$(rad), $(mol_t)))

mol := $(mol_s) $(mol_t)

ifneq ($(strip crys),)
	mol := $(foreach c, $(crys), $(addsuffix -$(c), $(mol)))
	mol := $(foreach m, $(mol), $(if $(wildcard crystals/$m.svg), $m))
endif

SAVE = $(subst $(space),-,$(strip $(call t_shape, $1) $t $(call t_rad, $1) $(call t_dist, $1) $(call t_theta, $1)))

VPATH=.:$(BIN_PATH):$(LIB)

distances = $(foreach m, $(mol), $(call t_dist, $m))
export $(addprefix temp_, $(distances))

##########################################################################################

all: program
	echo $(addprefix temp_, $(distances))

collate:
	python pylib/collate.py $(PREFIX)/$(strip $(mol))
	$(eval fs = $(basename $(shell ls plots/*.csv)))
	$(foreach f, $(fs), gnuplot -e 'filename="$f"' gnuplot/temp_dep.plot;)

$(mol): always | $(PREFIX)
	$(MAKE) -f $(LOOP) $(MAKECMDGOALS) mol=$@

$(TARGETS): program $(mol)

$(PRE): $(mol)

$(PRESENT): collate
	python output/$@.py $(PREFIX) > output/$@.out
	pdflatex --output-dir=output/.output output/$@.tex #> $(LOG)
	pdflatex --output-dir=output/.output output/$@.tex #> $(LOG)
	mv output/.output/$@.pdf .

present: program $(mol) $(PRESENT)

%.o : %.cpp | $(BIN_PATH)
	$(CXX) $(CXXFLAGS) -c $< -o $(BIN_PATH)/$@

program: $(MODULES) $(HEADERS)
	$(CXX) -o $(BIN_PATH)/program $(addprefix $(BIN_PATH)/, $(MODULES)) $(CXXFLAGS) $(LDFLAGS)
	ln -sf $(BIN_PATH)/program test/program

$(BIN_PATH):
	mkdir -p $(BIN_PATH)

$(PREFIX):
	-mkdir $(PREFIX)

.PHONY: always
always:

.PHONY: test
test: $(mol) 

.PHONY:clean
clean:
	-rm -r bin/*

.PHONY: delete
delete:
	-rm -r $(PREFIX)/*

