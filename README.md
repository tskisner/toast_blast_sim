# Synthetic TOAST Simulations of BLAST

This repository has some simple examples using generic TOAST tools to simulate
BLAST-like observations.

## Install TOAST

The documentation is in-progress, so we summarize the current state. This
documentation should be considered obsolete once the toast-3.0 release happens
(I will try to put a notice here at that time).

There are two supported ways to install this software and all dependencies:

1. Use a virtualenv. This is acceptable if you will be installing a released
version (or pre-release) of TOAST.

2. Use a conda environment. This approach is more flexible and can be used to
install either a released version of TOAST or installation of TOAST from a git
checkout.

### Using a Virtualenv

First, make sure that you have a recent (>=3.7) version of Python3. This might
come from your operating system or a package manager. You can check your python
version with:

    python3 --version

Next create a virtualenv (name it whatever you like):

    python3 -m venv ${HOME}/blast

Now activate this environment:

    source ${HOME}/blast/bin/activate

Within this virtualenv, update pip to the latest version:

    python3 -m pip install --upgrade pip

Install toast into this virtualenv:

    python3 -m pip install toast

**Important**: The previous line should not be used until toast-3.0 is
released. Until then, there is a pre-release available:

    python3 -m pip install --pre toast

In order to use MPI with toast installed in a virtualenv, you will need the
mpi4py package. This in turn requires an MPI installation on your local system
(for example from your linux package manager or homebrew). If you have a
working MPI installation, then do:

    pip install --force-reinstall --no-cache-dir --no-binary=mpi4py mpi4py

### Using Conda with Released TOAST Version

**Important**: Until toast-3.0 is released, you should use the instructions in
the next section when installing toast into a conda environment.

If you are using conda, you should start with a recent "base" environment. This
can be installed with the Anaconda installer, or the miniforge / miniconda
installer. Make sure that the base environment is activated before continuing.

The first step is to create a new conda environment and activate it. We call the
environment "blast" here:

    conda create -n blast
    conda activate blast

Now install toast:

    conda install toast

If you are using jupyter notebooks with toast, install some additional packages
for visualization:

    conda install ipykernel wurlitzer ipywidgets plotly
    pip install plotly_resampler

In order to use MPI with toast, you can either install the conda package of
mpi4py (if you are running on a laptop or workstation), or you can build mpi4py
using any custom MPI installation on your system (needed if you are running on
a cluster for example):

    conda install mpi4py

**OR** (assuming "mpicc" is your MPI compiler):

    MPICC="mpicc" pip install --force-reinstall --no-cache-dir --no-binary=mpi4py mpi4py

### Using Conda with TOAST Git Checkout

If you are using conda, you should start with a recent "base" environment. This
can be installed with the Anaconda installer, or the miniforge / miniconda
installer. Make sure that the base environment is activated before continuing.

The toast git repository includes helper scripts for creating a conda
environment that can be used for building toast from source. Decide on the name
you want to use for this environment (here we use "blast"). Then go into the
toast git checkout and run:

    cd toast
    ./platforms/conda_dev_setup.sh blast

This will create a conda environment and install all the toast dependencies.
Now we can activate this environment and install toast:

    conda activate blast
    ./platforms/conda.sh

If you are using jupyter notebooks with toast, install some additional packages
for visualization:

    conda install ipykernel wurlitzer ipywidgets plotly
    pip install plotly_resampler

In order to use MPI with toast, you can either install the conda package of
mpi4py (if you are running on a laptop or workstation), or you can build mpi4py
using any custom MPI installation on your system (needed if you are running on
a cluster for example):

    conda install mpi4py

**OR** (assuming "mpicc" is your MPI compiler):

    MPICC="mpicc" pip install --force-reinstall --no-cache-dir --no-binary=mpi4py mpi4py

## Using the Scripts

**Important**: While setting this up, I noticed a couple features that should
be added to the ground example script in TOAST. Will remove this notice when
that is merged.

### Fake Focalplane

Use the `create_focalplane.sh` script to generate an HDF5 file with the generic
toast focalplane format. Adjust pixel count to be the minimum required and a
full hex-packed layout (with at least that many pixels) will be created. Adjust
the noise spectral properties as needed.

### Fake Schedule

Use the `create_schedule.sh` script to generate a schedule file. The patch
specification used can be either center / width or all 4 corners in RA/DEC.

### Running the Workflow

This uses the "example" ground workflow from the toast package. That workflow
has many operations that we don't need for this exercise and which we can
enable / disable from the command line. This script assumes running on a
generic system with MPI. If you are using a cluster or HPC machine that has a
scheduler (e.g. slurm), then you will need to set up a batch job script.

There are further changes needed if you are scanning a map for sky signal in
the sim. Will add more notes here...
