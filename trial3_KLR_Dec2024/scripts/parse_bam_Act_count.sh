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

PATH1='/datacommons/ydiaolab/arinze/daichi/trial3_KLR_Dec2024/bam/'
samples=($(ls ${PATH1}*.bam | perl -p -e "s/\/.*bam\///g" | perl -p -e "s/\.bam//g"))
sample=${samples[${SLURM_ARRAY_TASK_ID}]}

samtools view -F 260 ${PATH1}${sample}.bam | awk '!/^@/ {{ print $0 }}'  | cut -d$'\t' -f3 | sort | uniq -c > ../counts/${sample}_counts.txt