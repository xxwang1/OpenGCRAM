#!/bin/bash
CONDA_INSTALLER_URL="https://repo.anaconda.com/miniconda/Miniconda3-py38_23.11.0-2-Linux-x86_64.sh"
CONDA_INSTALLER_FILE="miniconda_installer_py38.sh"
CONDA_HOME="${CONDA_HOME:-miniconda}"

# The tool name format is "<tool>=<version>".
# If you want to use the latest version, just use "<tool>".
TOOLS=""
TOOLS+="klayout=0.28.3 "
TOOLS+="magic=8.3.363 "
TOOLS+="netgen=1.5.253 "
TOOLS+="ngspice=26 "
TOOLS+="trilinos=12.12.1=1 "
TOOLS+="xyce=7.4=3"

# Install miniconda if not already installed
if [[ ! -d "${CONDA_HOME}/bin" ]]
then
    curl -s -o ${CONDA_INSTALLER_FILE} ${CONDA_INSTALLER_URL}
    /bin/bash ${CONDA_INSTALLER_FILE} -b -p ${CONDA_HOME}
    rm ${CONDA_INSTALLER_FILE}
    source ${CONDA_HOME}/bin/activate

    # Prioritize channels to prevent version conflicts
    conda config --add channels conda-forge
    conda config --add channels vlsida-eda

    # Install iverilog from conda-eda
    conda install -q -y -c litex-hub iverilog

    # Install rest of the tools from vlsida-eda
    for tool in ${TOOLS}
    do
        conda install -q -y -c vlsida-eda ${tool}
    done

    # Install required Python packages
    # (This step isn't required but used to prevent possible issues)
    python3 -m pip install -r requirements.txt --ignore-installed

    conda deactivate
fi

