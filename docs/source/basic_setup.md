### [Go Back](./index.md#table-of-contents)

# Basic Setup
This page shows the basic setup for using OpenGCRAM with customized process design kit (PDK) to generate a gain-cell memory (GCRAM) using the command-line flow.


## Table of Contents
1. [Dependencies](#dependencies)
1. [Anaconda](#anaconda)
1. [Environment](#environment)
1. [Customized PDK Setup](#customized-pdk-setup)
1. [Launching Virtuoso](#launching-virtuoso)
1. [Running the compiler](#running-the-compiler)
1. [Commands Summary](#commands-summary)


## Dependencies
In general, the OpenGCRAM compiler has very few dependencies:
+ Git
+ Make
+ Python 3.6 or higher
+ Various Python packages (pip install -r requirements.txt)
+ Cadence Virtuoso
+ Calibre DRC/LVS/PEX
+ PDK
+ Anaconda



## Anaconda
We use Anaconda package manager to install the tools used by OpenGCRAM. This way,
you don't have to worry about updating/installing these tools. OpenGCRAM installs
Anaconda silently in the background (without affecting any existing Anaconda
setup you have).

You don't have to manually activate/deactivate the Anaconda environment. OpenGCRAM
automatically manages this before and after running the tools.

OpenGCRAM uses Anaconda by default.

You can also tell OpenGCRAM where Anaconda should be installed or which Anaconda
setup it should use. You can set the `$CONDA_HOME` variable like this:
```
export CONDA_HOME="/path/to/conda/setup"
```

> **Note**: If you want to install Anaconda without running OpenGCRAM (for example
> to run unit tests, which do not install Anaconda), you can run:
> ```
> ./install_conda.sh
> ```

> **Note**: You can uninstall OpenGCRAM's Anaconda installation by simply deleting
> the folder Anaconda is installed to. You can run:
> ```
> rm -rf miniconda
> ```

> **Note**: You can change a tool's version with the following commands:
> ```
> source ./miniconda/bin/activate
> conda uninstall <tool>
> conda install -y -c vlsida-eda <tool>=<version>
> ```

After setting the `$CONDA_HOME` variable, you can activate the environment with 
```
conda activate your_OpenGCRAM_env_name
```

## Environment

To use your custom OpenGCRAM setup, configure the following environment variables:
+ `OPENRAM_HOME` should point to the compiler source directory.
+ `OPENRAM_TECH` should point to one or more root technology directories (colon
  separated).
+ `OPENRAM_TMP` should point to a writable directory used for intermediate files and temporary storage during compilation. This helps separate large temporary files (e.g., generated SPICE netlists, layout views) from the main source tree.

You should also add `OPENRAM_HOME` to your
`PYTHONPATH`.
```
export PYTHONPATH=$OPENRAM_HOME
```

You can add these environment variables to your `.bashrc` or `~/.bash_profile` for convenience:
```
export OPENRAM_HOME="$HOME/OpenGCRAM/compiler"
export OPENRAM_TECH="$HOME/OpenGCRAM/technology"
export OPENRAM_TMP="$HOME/OpenGCRAM/tmp"
export PYTHONPATH=$OPENRAM_HOME
```

Note that if you want symbols to resolve in your editor, you may also want to
add the specific technology directory that you use and any custom technology
modules as well. For example:
```
export PYTHONPATH="$OPENRAM_HOME:$OPENRAM_TECH/sky130:$OPENRAM_TECH/sky130/custom"
```

## Customized PDK Setup
To set up OpenGCRAM with the customized PDK of your choice, set the following environment variable to point to your PDK’s Calibre rule directory:
```
export TSMC_CAL_DFM_PATH="/path/to/your/customized/pdk/Calibre/rcx/DFM/"
```
This is required for loading the Calibre decks (DRC/LVS/RCX) during physical verification.

A sample PDK folder used by OpenGCRAM should be organized as follows:

```
sample_PDK
├── gds_lib/               # Standard cell GDSII files
│   └── *.gds
├── sp_lib/                # SPICE netlists for simulations
│   └── *.sp
├── tech/                  # Technology files for layout and verification
│   ├── calibre.drc        # Calibre DRC rule deck
│   ├── calibre.lvs        # Calibre LVS rule deck
│   ├── calibre.rcx        # Calibre RCX rule deck
│   └── sample_PDK.tech.py # Technology file
├── tf/                    # Technology file for layout and layer mapping
│   ├── sample_PDK.tf
│   └── virtuoso_sample_PDK.map
└── __init__.py            # Python module init file
```
Ensure that the required rule decks and layer map files exist and are compatible with your OpenGCRAM build environment.

Several changes required to made in the technology file sample_PDK.tech.py. 
To customize DRC/LVS/RCX settings for the customized PDK of your choice:
```python
# DRC/LVS/RCX test setup
drc["drc_rules"] = "/path/to/OpenGCRAM/technology/sample_PDK/tech/calibre.drc"
drc["lvs_rules"] = "/path/to/OpenGCRAM/technology/sample_PDK/tech/calibre.lvs"
drc["xrc_rules"] = "/path/to/OpenGCRAM/technology/sample_PDK/tech/calibre.rcx"
drc["layer_map"] = os.environ.get("OPENRAM_TECH") + "/sample_PDK/tf/virtuoso_sample_PDK.map"
```
> **Important:** You need to update the paths above to match your local directory structure. If you install the PDK in a different location, you **must** change these paths accordingly.

> **Note**: **DRC errors:** Check `calibre.drc` path and ensure Calibre is using the correct layer map.
> **LVS mismatch:** Verify the SPICE netlist and GDS layers are aligned. Look at `calibre.lvs` and ensure net/label layers are correctly defined.
> **Missing parasitics:** Confirm `calibre.rcx` exists and includes appropriate extraction commands.

To configure SPICE models for GCRAM design simulation using OpenGCRAM:
Set the SPICE model directory using:

```bash
export SPICE_MODEL_DIR="/path/to/your/spice/models"
```

Update __init__.py as follows:
```python
os.environ["SPICE_MODEL_DIR"] = "/cad/tsmc/PDK_N40_2022/1p6m_4x1z/models/hspice"
```

Update sample_PDK.tech.py as follows:

```python
SPICE_MODEL_DIR = os.environ.get("SPICE_MODEL_DIR")

spice["fet_libraries"] = {
    "TT": [[SPICE_MODEL_DIR + "/toplevel.l", "top_tt"]]
}

spice["osfet_models"] = {
    "TT": ["/path/to/your/osfet/models/OSFET/osfet/veriloga/veriloga.oa"]
}
```

> **Note:** 
> - `toplevel.l` should contain transistor model definitions (e.g., NMOS/PMOS) for typical (TT) corner.
> - The OSFET Verilog-A model path must point to a valid `.oa` file that is accessible during simulation. You need to update the absolute path.

Ensure these files are compatible with your SPICE simulator. 

> **Important:** Make sure you load the required EDA tools with the appropriate module versions
```
module load hspice/latest
module load calibre/2023.1_34
```

## Launching Virtuoso
If you want to use Cadence Virtuoso to inspect or modify layouts, you can start it with the appropriate environment:
```
source hli_cshrc
virtuoso &

```

## Running the Compiler
Once your environment is ready, you can run this GCRAM compiler with:
```
cd /path/to/OpenGCRAM
python3 gain_cell_compiler.py myconfig > log.txt
```

## Commands Summary
This section includes all commands neceassry for setting up and runnning OpenGCRAM for your convenience. 
```
export CONDA_HOME="/path/to/conda/setup"
export OPENRAM_HOME="$HOME/OpenGCRAM/compiler"
export OPENRAM_TECH="$HOME/OpenGCRAM/technology"
export OPENRAM_TMP="$HOME/OpenGCRAM/tmp"
export PYTHONPATH=$OPENRAM_HOME
export TSMC_CAL_DFM_PATH="/path/to/your/customized/pdk/Calibre/rcx/DFM/"
conda activate your_OpenGCRAM_env_name
cd /path/to/OpenGCRAM
python3 gain_cell_compiler.py myconfig > log.txt
```