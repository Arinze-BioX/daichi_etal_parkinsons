#!/bin/bash
#
#SBATCH --job-name=count
#SBATCH --output=count.out
#SBATCH --error=count.err
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --array=0-7
#SBATCH --mem-per-cpu=20G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=aeo21@duke.edu

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate snakemake_3dstarrseq

PATH1='/datacommons/ydiaolab/arinze/daichi/trial1_sept2024/sam/'
samples=($(ls ${PATH1}*_long.sam | perl -p -e "s/\/.*sam\///g" | perl -p -e "s/_long\.sam//g"))
sample=${samples[${SLURM_ARRAY_TASK_ID}]}

samtools view -F 260 ${PATH1}${sample}_long.sam | awk '!/^@/ {{ print $0 }}'  | cut -d$'\t' -f3 | sort | uniq -c > /datacommons/ydiaolab/arinze/daichi/trial1_sept2024/counts/${sample}_counts.txt