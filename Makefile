TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
include $(TOP_DIR)/openram.mk

.DEFAULT_GOAL := install

# Set the shell here
SHELL := /bin/bash

# Skywater PDK SRAM library
SRAM_LIB_DIR ?= $(PDK_ROOT)/sky130_fd_bd_sram
# Use this for release
SRAM_LIB_GIT_REPO ?= https://github.com/vlsida/sky130_fd_bd_sram.git
# Use this for development
#SRAM_LIB_GIT_REPO ?= git@github.com:VLSIDA/sky130_fd_bd_sram.git
#SRAM_LIB_GIT_REPO ?= https://github.com/google/skywater-pdk-libs-sky130_fd_bd_sram.git
SRAM_LIB_GIT_COMMIT ?= dd64256961317205343a3fd446908b42bafba388

SKY130_PDK ?= $(PDK_ROOT)/sky130A
GF180_PDK ?= $(PDK_ROOT)/gf180mcuD

# Volare SKY130 PDK
SKY130_VOLARE = e8294524e5f67c533c5d0c3afa0bcc5b2a5fa066 # 2022.07.29

# Volare GF180 PDK
GF180_VOLARE = cd1748bb197f9b7af62a54507de6624e30363943 # 2023.12.04

# Skywater PDK
SKY130_PDKS_DIR ?= $(PDK_ROOT)/skywater-pdk
SKY130_PDKS_GIT_REPO ?= https://github.com/google/skywater-pdk.git
SKY130_PDKS_GIT_COMMIT ?= f70d8ca46961ff92719d8870a18a076370b85f6c

# GF180 PDK
GF180_PDKS_DIR ?= $(PDK_ROOT)/gf180mcu-pdk
GF180_PDKS_GIT_REPO ?= https://github.com/google/gf180mcu-pdk.git
GF180_PDKS_GIT_COMMIT ?= main

# Create lists of all the files to copy/link
GDS_FILES := $(sort $(wildcard $(SRAM_LIB_DIR)/cells/*/*.gds))
GDS_FILES := $(GDS_FILES) $(PDK_ROOT)/skywater-pdk/libraries/sky130_fd_sc_hd/latest/cells/dlxtn/sky130_fd_sc_hd__dlxtn_1.gds
MAG_FILES := $(sort $(wildcard $(SRAM_LIB_DIR)/cells/*/*.mag))

SPICE_SUFFIX := spice
SPICE_LVS_SUFFIX := lvs.$(SPICE_SUFFIX)
SPICE_CALIBRE_SUFFIX := lvs.calibre.$(SPICE_SUFFIX)
SPICE_KLAYOUT_SUFFIX := lvs.klayout.$(SPICE_SUFFIX)
SPICE_BASE_SUFFIX := base.$(SPICE_SUFFIX)
ALL_SPICE_FILES := $(sort $(wildcard $(SRAM_LIB_DIR)/cells/*/*.$(SPICE_SUFFIX)))
ALL_SPICE_FILES := $(ALL_SPICE_FILES) $(PDK_ROOT)/skywater-pdk/libraries/sky130_fd_sc_hd/latest/cells/dlxtn/sky130_fd_sc_hd__dlxtn_1.spice

MAGLEF_SUFFIX := maglef
MAGLEF_FILES := $(sort $(wildcard $(SRAM_LIB_DIR)/cells/*/*.$(MAGLEF_SUFFIX)))

MAGICRC_FILE := $(SKY130_PDK)/libs.tech/magic/sky130A.magicrc

ALL_FILES := $(ALL_SPICE_FILES) $(GDS_FILES) $(MAG_FILES) $(MAGLEF_FILES)

INSTALL_BASE_DIRS := gds_lib mag_lib sp_lib lvs_lib calibre_lvs_lib klayout_lvs_lib maglef_lib
INSTALL_BASE := $(OPENRAM_HOME)/../technology/sky130
INSTALL_DIRS := $(addprefix $(INSTALL_BASE)/,$(INSTALL_BASE_DIRS))

# If conda is installed, we will use volare from there
CONDA_DIR := $(wildcard $(TOP_DIR)/miniconda)

check-pdk-root:
ifndef PDK_ROOT
	$(error PDK_ROOT is undefined, please export it before running make)
endif

$(SKY130_PDKS_DIR): check-pdk-root
	@echo "Cloning skywater PDK..."
	@[ -d $(PDK_ROOT)/skywater-pdk ] || \
		git clone https://github.com/google/skywater-pdk.git $(PDK_ROOT)/skywater-pdk
	@git -C $(SKY130_PDKS_DIR) checkout $(SKY130_PDKS_GIT_COMMIT) && \
		git -C $(SKY130_PDKS_DIR) submodule update --init libraries/sky130_fd_pr/latest libraries/sky130_fd_sc_hd/latest

$(GF180_PDKS_DIR): check-pdk-root
	@echo "Cloning gf PDK..."
	@[ -d $(PDK_ROOT)/gf180mcu-pdk ] || \
		git clone https://github.com/google/gf180mcu-pdk.git $(PDK_ROOT)/gf180mcu-pdk
	@cd $(GF180_PDKS_DIR) && \
		git checkout main && git pull && \
		git checkout -qf $(GF180_PDKS_GIT_COMMIT) && \
		git submodule update --init libraries/gf180mcu_fd_pr/latest libraries/gf180mcu_fd_sc_mcu7t5v0/latest libraries/gf180mcu_fd_sc_mcu9t5v0/latest

$(SRAM_LIB_DIR): check-pdk-root
	@echo "Cloning SRAM library..."
	@[ -d $(SRAM_LIB_DIR) ] || \
		git clone $(SRAM_LIB_GIT_REPO) $(SRAM_LIB_DIR)
	@git -C $(SRAM_LIB_DIR) fetch
	@git -C $(SRAM_LIB_DIR) checkout $(SRAM_LIB_GIT_COMMIT)

sky130-install: $(SRAM_LIB_DIR)
	@[ -d $(PDK_ROOT)/sky130A ] || \
		(echo "Warning: $(PDK_ROOT)/sky130A not found!! Run make sky130-pdk first." &&  false)
	@[ -d $(PDK_ROOT)/skywater-pdk ] || \
		(echo "Warning: $(PDK_ROOT)/skywater-pdk not found!! Run make sky130-pdk first." && false)
	@echo "Installing sky130 SRAM PDK..."
	@echo "PDK_ROOT='$(PDK_ROOT)'"
	@echo "SRAM_LIB_DIR='$(SRAM_LIB_DIR)'"
	@echo "SKY130_PDK='$(SKY130_PDK)'"
	@make $(INSTALL_DIRS)
.PHONY: sky130-install

sky130-pdk: $(SKY130_PDKS_DIR)
	@echo "Installing SKY130 via volare..."
ifeq ($(CONDA_DIR),)
	volare enable --pdk sky130 $(SKY130_VOLARE)
else
	source $(TOP_DIR)/miniconda/bin/activate && \
		volare enable --pdk sky130 $(SKY130_VOLARE) && \
		conda deactivate
endif
.PHONY: sky130-pdk

gf180mcu-pdk:
	@echo "Installing GF180 via volare..."
ifeq ($(CONDA_DIR),)
	volare enable --pdk gf180mcu $(GF180_VOLARE)
else
	source $(TOP_DIR)/miniconda/bin/activate && \
		volare enable --pdk gf180mcu $(GF180_VOLARE) && \
		conda deactivate
endif
.PHONY: gf180mcu-pdk

$(INSTALL_BASE)/gds_lib: $(GDS_FILES)
	@echo
	@echo "Setting up GDS cell library for OpenRAM."
	@echo "=================================================================="
	mkdir -p $@
	cp -va $? $@
	@echo "=================================================================="
	@echo

$(INSTALL_BASE)/mag_lib: $(MAG_FILES)
	@echo
	@echo "Setting up MAG files for OpenRAM."
	@echo "=================================================================="
	mkdir -p $@
	@cp -va $? $@
	@echo
	cp -f $(MAGICRC_FILE) $(INSTALL_BASE)/tech/.magicrc
	cp -f $(MAGICRC_FILE) $(INSTALL_BASE)/mag_lib/.magicrc
	@echo "=================================================================="
	@echo

$(INSTALL_BASE)/maglef_lib: $(MAGLEF_FILES)
	@echo
	@echo "Setting up MAGLEF cell library for OpenRAM."
	@echo "=================================================================="
	mkdir -p $@
	@for SP in $?; do \
		cp -va $$SP $@/$$(basename $$SP .$(MAGLEF_SUFFIX)).mag; \
	done
	@echo
	cp -f $(MAGICRC_FILE) $(INSTALL_BASE)/maglef_lib/.magicrc
	@echo "=================================================================="
	@echo


$(INSTALL_BASE)/lvs_lib: $(filter %.$(SPICE_LVS_SUFFIX),$(ALL_SPICE_FILES))
	@echo
	@echo "Setting up LVS cell library for OpenRAM."
	@echo "=================================================================="
	mkdir -p $@
	@for SP in $?; do \
		cp -va $$SP $@/$$(basename $$SP .$(SPICE_LVS_SUFFIX)).sp; \
	done
	@echo "=================================================================="
	@echo

$(INSTALL_BASE)/calibre_lvs_lib: $(filter %.$(SPICE_CALIBRE_SUFFIX),$(ALL_SPICE_FILES))
	@echo
	@echo "Setting up Calibre LVS library for OpenRAM."
	@echo "=================================================================="
	mkdir -p $@
	@for SP in $?; do \
		cp -va $$SP $@/$$(basename $$SP .$(SPICE_CALIBRE_SUFFIX)).sp; \
	done
	@echo "=================================================================="
	@echo

$(INSTALL_BASE)/klayout_lvs_lib: $(filter %.$(SPICE_KLAYOUT_SUFFIX),$(ALL_SPICE_FILES))
	@echo
	@echo "Setting up klayout LVS library for OpenRAM."
	@echo "=================================================================="
	mkdir -p $@
	@for SP in $?; do \
		cp -va $$SP $@/$$(basename $$SP .$(SPICE_KLAYOUT_SUFFIX)).sp; \
	done
	@echo "=================================================================="
	@echo


$(INSTALL_BASE)/sp_lib: $(filter-out %.$(SPICE_LVS_SUFFIX) %.$(SPICE_CALIBRE_SUFFIX),$(ALL_SPICE_FILES))
	@echo
	@echo "Setting up spice simulation library for OpenRAM."
	@echo "=================================================================="
	mkdir -p $@
	@for SP in $(filter-out %.$(SPICE_BASE_SUFFIX),$?); do \
		cp -va $$SP $@/$$(basename $$SP .$(SPICE_SUFFIX)).sp; \
	done
	@echo
	@echo "Overwriting some cells with base version."
	@for SP in $(filter %.$(SPICE_BASE_SUFFIX),$?); do \
		cp -va $$SP $@/$$(basename $$SP .$(SPICE_BASE_SUFFIX)).sp; \
	done
	@echo "=================================================================="
	@echo

macros:
	cd macros && make

.PHONY: macros

clean:
	@rm -f *.zip
.PHONE: clean

uninstall: clean
	@rm -f $(INSTALL_BASE)/tech/.magicrc
	@rm -f $(INSTALL_BASE)/mag_lib/.magicrc
	@rm -f $(INSTALL_BASE)/lef_lib/.magicrc
	@rm -f $(INSTALL_BASE)/maglef_lib/.magicrc
	@rm -rf $(INSTALL_DIRS)
.PHONY: uninstall

# wipe the entire repos
wipe: uninstall
	@echo $(SKY130_PDK)
	@echo $(SRAM_LIB_DIR)
	@echo $(OPEN_PDKS_DIR)
	@echo  $(SKY130_PDKS_DIR)
	@echo "Wiping above PDK repos in 5 sec... (ctrl-c to quit)"
	@sleep 5
	@rm -rf $(SKY130_PDK)
	@rm -rf $(SRAM_LIB_DIR)
	@rm -rf $(OPEN_PDKS_DIR)
	@rm -rf $(SKY130_PDKS_DIR)
.PHONY: wipe

# Build the openram library
build_library:
	@rm -rf dist
	@rm -rf openram.egg-info
	@python3 -m pip install --upgrade build
	@python3 -m build
.PHONY: build_library

# Build and install the openram library
library: build_library
	@python3 -m pip install --force dist/openram*.whl
.PHONY: library
