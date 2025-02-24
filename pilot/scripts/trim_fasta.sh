#!/bin/bash
#
#SBATCH --job-name=grna_par
#SBATCH --output=grna_par.out
#SBATCH --error=grna_par.err
#SBATCH --mem 20G

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate snakemake_HiCAR

cutadapt -Z -e 0 --no-indels --action trim -a GTTTAAGAG -o /datacommons/ydiaolab/arinze/daichi/gRNA_reference/Mouse_m1Top5_crop28_trimmed.fa /datacommons/ydiaolab/arinze/daichi/gRNA_reference/Mouse_m1Top5_crop28.fa