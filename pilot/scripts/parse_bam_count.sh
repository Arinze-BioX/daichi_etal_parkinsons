#!/bin/bash
#
#SBATCH --job-name=count
#SBATCH --output=count.out
#SBATCH --error=count.err
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --array=0-5
#SBATCH --mem-per-cpu=20G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=aeo21@duke.edu

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate snakemake_HiCAR

PATH1='/datacommons/ydiaolab/arinze/daichi/bam2/'
bams=($(ls ${PATH1}AO*))
bam=${bams[${SLURM_ARRAY_TASK_ID}]}
READ_NAMES=($(ls ${PATH1}AO* | perl -p -e "s/\/.*bam2\///g" | perl -p -e "s/\.bam//g"))
READ_NAME=${READ_NAMES[${SLURM_ARRAY_TASK_ID}]}

samtools view -F 260 ${bam} | cut -d$'\t' -f3 | sort | uniq -c > /datacommons/ydiaolab/arinze/daichi/counts2/${READ_NAME}_counts.txt