
PRE=files data lammps touch-lammps test $(all_clean)
TARGETS=contact plot density movie
PRESENT=grouped individual

latex-flags= --output-dir=output/.output -interaction=batchmode

include settings
include config

export
# Generating all shapes {{{
mol := $(shape)
mol_d := $(filter Disc%, $(mol))
# Radius
mol := $(if $(radius), $(foreach rad, $(radius), $(addsuffix -$(rad), $(mol))), $(mol)) 

mol_1 := $(mol)

# Distance
ifneq ($(dist_tri),)
	mol_s := $(filter Snowman%, $(mol))
	mol_t := $(filter Trimer%, $(mol))
	mol_s := $(if $(dist), $(foreach d, $(dist), $(addsuffix -$(d), $(mol_s))), $(mol_s)) 
	mol_t := $(if $(dist), $(foreach d, $(dist_tri), $(addsuffix -$(d), $(mol_t))), $(mol_t)) 
	mol := $(mol_s) $(mol_t)
else
	mol := $(if $(dist), $(foreach d, $(dist), $(addsuffix -$(d), $(mol))), $(mol)) 
endif

mol_2 := $(mol)

# Computing Distance
mol := $(foreach m, $(mol), $(m:$(call p_dist, $m)=$(call comp_dist, $(call p_dist, $m), $(call p_rad, $m))))

# Theta
mol_s := $(filter Snowman%, $(mol))
mol_t := $(filter Trimer%, $(mol))
mol_t := $(foreach rad, $(theta), $(addsuffix -$(rad), $(mol_t)))

mol := $(mol_d) $(mol_s) $(mol_t)

mol_3 := $(mol)

ifneq ($(crys_dir),)
	crys_dir = $(HOME)/scratch/pack_iso/$(subst $(space),-,$(strip $(call p_shape,$1) $(call p_rad,$1) $(call p_dist,$1) $(call p_theta, $1)))
else
	crys_dir = $(my_dir)/crystals
endif

mol_4 := $(mol)

# Adding crystals for which there are unit cells
ifneq ($(strip $(crys)),)
    mol := $(foreach c, $(crys), $(addsuffix -$(c), $(mol)))
	mol_5 := $(mol)
    mol := $(foreach m, $(mol), $(if $(wildcard $(call crys_dir,$m)/$m.svg), $m))
endif


# Iterating through having a crystal liquid boundary
ifneq ($(strip $(boundary)),)
    mol := $(if $(boundary), $(foreach b, $(boundary), $(addsuffix -$(b), $(mol))), $(mol))
    CREATE_VARS += -v boundary $(bound)
else
    CREATE_VARS += -v boundary 0
endif

#}}}

ifeq ($(findstring dynamics, $(collate_plots)),dynamics)
	dynamics=true
endif

VPATH=.:$(BIN_PATH):$(LIB):gnuplot

distances = $(foreach m, $(mol), $(call p_dist, $m))
export $(addprefix temp_, $(distances))

glob_temps = $(subst $(space),-,$(strip $(call p_shape, $1) * $(call p_radius, $1) $(call p_dist, $1) $(call p_theta, $1) $(call p_bound, $1)))

get_mol = $(call wo_temp, $(word 5, $(subst /,$(space),$m)))

##########################################################################################

all: program

test:
	@echo $(mol)
	@echo $(mol_1)
	@echo $(mol_2)
	@echo $(mol_3)
	@echo $(mol_4)
	@echo $(mol_5)
	@echo $(theta)
	@echo $(crys_dir)
	@echo $(call crys_dir, $(word 1, $(mol_5)))/$(word 1, $(mol_5)).svg
	@echo $(wildcard $(call crys_dir,$(word 1, $(mol_5)))/$(word 1, $(mol_5)).svg)

collate: $(addsuffix .tex, $(mol)) | $(PREFIX)/plots
	@echo \\input{$(PREFIX)/latex/collate.tex} > output/prefix.out
	@rm -f $(PREFIX)/latex/collate.tex
	@python output/collate.py $(PREFIX) ? $(shape) >> $(PREFIX)/latex/collate.tex
	@$(foreach m, $(mol), cat $(PREFIX)/latex/$m.tex >> $(PREFIX)/latex/collate.tex; )

%.tex: % plot-dynamics
	@echo "\section{$<}" > $(PREFIX)/latex/$@
	@python output/collate.py $(PREFIX) $< >> $(PREFIX)/latex/$<.tex
	@$(foreach p, $(to_plot), cat $(PREFIX)/latex/$<-$(p).tex >> $(PREFIX)/latex/$<.tex; )

ifeq ($(dynamics), true)
plot-dynamics: dynamics.plot $(mol) | $(PREFIX)/plots
	@gnuplot -e 'prefix="$(PREFIX)/"; term_type="$(term_type)"' $<
	@echo plot dynamics
else
plot-dynamics: dynamics.plot
	@echo no plot dynamics
endif

movie: $(mol)
	@$(vmd) -e $(vmd_in) -args $(PREFIX)

iso:
	@$(MAKE) -f Makefile.iso iso

$(mol): program vars.mak | $(PREFIX) $(PREFIX)/plots
ifeq ($(SYS_NAME), silica)
ifneq ($(t_dep), false)
	@qsub -N $@ -o pbsout/$@.out make.pbs -vmol=$@,target=$(MAKECMDGOALS)
else
	@$(MAKE) -f $(LOOP) $(MAKECMDGOALS) mol=$@
endif
else
	$(MAKE) -f $(LOOP) $(MAKECMDGOALS) mol=$@
endif

vars.mak:
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

present: program $(mol) collate | output/.output
	@pdflatex -draftmode $(latex-flags) output/collate.tex
	@pdflatex $(latex-flags) output/collate.tex
	@mv output/.output/collate.pdf $(PREFIX)/collate.pdf
	@rm -f collate.pdf
	@ln -s $(PREFIX)/collate.pdf collate.pdf

contact-all: $(addsuffix /contact.log, $(wildcard $(PREFIX)/*-*))

%/contact.log: program vars.mak
	@if [ -f $(@:%/contact.log=%/trj/out.lammpstrj) ] ;then $(MAKE) -C $(dir $@) -f $(my_dir)/$(GOAL) contact mol=$(@:$(PREFIX)/%/contact.log=%) ; fi

clean-contact-all:
	@$(foreach m, $(wildcard $(PREFIX)/*-* | cut -d/ -f6), \
        $(MAKE) -C $m -f $(my_dir)/$(GOAL) clean-contact mol=$m;)

%.o : %.cpp | $(BIN_PATH)
	@echo CC $<
	@$(CXX) $(CXXFLAGS) -c $< -o $(BIN_PATH)/$@

program: $(MODULES) $(HEADERS)
	@echo CC $@
	@$(CXX) -o $(BIN_PATH)/program $(addprefix $(BIN_PATH)/, $(MODULES)) $(CXXFLAGS) $(LDFLAGS)

$(BIN_PATH):
	@mkdir -p $(BIN_PATH)

$(PREFIX):
	@mkdir -p $(PREFIX)

$(PREFIX)/plots:
	@mkdir -p $@

$(PREFIX)latex:
	@mkdir -p $@

.PHONY: test $(mol) clean delete vars.mak $(TARGETS) $(PRE) clean-plot clean-collate

#test: $(mol)
#	@echo test

clean:
	-rm -rf bin/*

clean-collate: $(mol)
	-rm -f $(PREFIX)/plots/*
	-rm -f $(PREFIX)/latex/*.tex

delete:
	-rm -rf $(PREFIX)/*

output/.output:
	-mkdir -p $@

clean-plot: clean-collate $(mol)
	rm -r $(PREFIX)/plots/*

# vim:foldmethod=marker:foldlevel=0
