#!/bin/bash
#
#SBATCH --job-name=count_Del
#SBATCH --output=count_Del.out
#SBATCH --error=count_Del.err
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --array=0-7
#SBATCH --mem-per-cpu=30G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=aeo21@duke.edu

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate snakemake_3dstarrseq

PATH1='/datacommons/ydiaolab/arinze/daichi/trial2_Oct2024/sam/'
samples=($(ls ${PATH1}*_Del.sam | perl -p -e "s/\/.*sam\///g" | perl -p -e "s/_bwa_Del\.sam//g"))
sample=${samples[${SLURM_ARRAY_TASK_ID}]}

samtools view -F 260 ${PATH1}${sample}_bwa_Del.sam | awk '!/^@/ {{ print $0 }}'  | cut -d$'\t' -f3 | sort | uniq -c > ../counts/${sample}_counts.txt