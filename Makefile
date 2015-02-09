
PRE=files data lammps clean-files clean-lammps clean-plot clean-contact clean-all clean-present touch-lammps clean-density
TARGETS=contact plot density movie
PRESENT=grouped individual

latex-flags= --output-dir=output/.output -interaction=batchmode

include settings
include config

export

# Generating all shapes {{{
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

# Adding crystals for which there are unit cells
ifneq ($(strip $(crys)),)
    mol := $(foreach c, $(crys), $(addsuffix -$(c), $(mol)))
    mol := $(foreach m, $(mol), $(if $(wildcard crystals/$m.svg), $m))
endif

# Iterating through having a crystal liquid boundary
ifneq ($(strip $(boundary)),)
    mol := $(if $(boundary), $(foreach b, $(boundary), $(addsuffix -$(b), $(mol))), $(mol))
    CREATE_VARS += -v boundary $$(bound)
else
    CREATE_VARS += -v boundary 0
endif
#}}}

VPATH=.:$(BIN_PATH):$(LIB)

distances = $(foreach m, $(mol), $(call t_dist, $m))
export $(addprefix temp_, $(distances))

##########################################################################################

all: program
	echo $(SYS_NAME)

collate: $(mol)
	@echo Creating T-dependent plots
	@-rm -f plots/*
	@$(foreach m, $(mol), python pylib/collate.py $(PREFIX)/$(strip $(m));)
	$(eval fs = $(basename $(shell ls plots/*.csv)))
	@$(foreach f, $(fs), gnuplot -e 'filename="$f"' gnuplot/temp_dep.plot;)

movie: $(mol)
	@$(vmd) -e $(vmd_in) -args $(PREFIX)

$(mol): program vars.mak always | $(PREFIX)
ifeq ($(SYS_NAME), silica)
ifneq ($(t_dep), false)
	@qsub -N $@ -o pbsout/$@.out make.pbs -vmol=$@,target=$(MAKECMDGOALS)
else
	@$(MAKE) -f $(LOOP) $(MAKECMDGOALS) mol=$@
endif
else
	@$(MAKE) -f $(LOOP) $(MAKECMDGOALS) mol=$@
endif

vars.mak: always
	@rm -f $@
	@$(foreach V,\
    $(sort $(.VARIABLES)),\
    $(if\
        $(filter-out environment% default automatic, $(origin $V)),\
        echo '$V=$(value $V)' >> $@;\
        )\
    )

$(TARGETS): $(mol)

$(PRE): $(mol)

$(PRESENT): program collate
	@echo $@
	@python output/$@.py $(PREFIX) > output/$@.out
	@pdflatex -draftmode $(latex-flags) output/$@.tex
	@pdflatex $(latex-flags) output/$@.tex
	@mv output/.output/$@.pdf .

present: program $(mol) $(PRESENT)

%.o : %.cpp | $(BIN_PATH)
	@echo o $<
	@$(CXX) $(CXXFLAGS) -c $< -o $(BIN_PATH)/$@

program: $(MODULES) $(HEADERS)
	@echo c++ $@
	@$(CXX) -o $(BIN_PATH)/program $(addprefix $(BIN_PATH)/, $(MODULES)) $(CXXFLAGS) $(LDFLAGS)

$(BIN_PATH):
	@mkdir -p $(BIN_PATH)

$(PREFIX):
	@mkdir $(PREFIX)

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


# vim:foldmethod=marker:foldlevel=0
