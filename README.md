<div align="center">

# Recreate paper figures

</div>

# Description
Run simulation, data analysis and create figures of "Axisymmetric diffusion kurtosis imaging with Rician bias correction: a simulation study" paper 
# Installation
## Clone repository
```bash
git clone https://github.com/quantitative-mri-and-in-vivo-histology/axisymmetric_dki_with_rician_bias_correction_simulation_study
```
## Setup python enviroment (using conda)
In a conda environment run:
```bash
conda install pip
pip install -r requirements.txt
```
## Setup Matlab toolboxes
Install spm12 (https://www.fil.ion.ucl.ac.uk/spm/software/spm12/) and ACID toolbox (https://bitbucket.org/siawoosh/acid-artefact-correction-in-diffusion-mri/src/master/) for Matlab

# How to run
- Open Matlab and spm12, add spm12 folder to Matlab path. 
-Run Evaluation_AxDKI_RBC_Paper.m to simulate and analyze paper data and create .csv files of the analysis results (stored in "\Results_And_Figures\Figure_Data").
- Run \python_functions\plot_figures_6_and_S1.py to plot Figures 6 and S1 (Appendix) based on the previously created .csv files.
- Important: Main focus of this repository is to document the code used for the paper, simulating data and analyzing them can take a long time. Folder "\Results_And_Figures\Figure_Data" contains obtained results of a previous run. 
Original seed for noise generation within the code was not stored.

