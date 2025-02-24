#!/bin/bash
#
#SBATCH --job-name=align_par
#SBATCH --output=align_par.out
#SBATCH --error=align_par.err
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --array=0-5
#SBATCH --mem-per-cpu=40G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=aeo21@duke.edu

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate bedtools

PATH1='/datacommons/ydiaolab/arinze/daichi/scripts/'
READ1_NAMES=($(ls ${PATH1}AO*_R1_001.fastq.gz | perl -p -e "s/\/.*scripts\///g" | perl -p -e "s/_R1_001\.fastq\.gz//g"))
READ1_NAME=${READ1_NAMES[${SLURM_ARRAY_TASK_ID}]}

bowtie2 -x /datacommons/ydiaolab/arinze/daichi/gRNA_reference/bowtie2_m1Top5_crop28 -U ${READ1_NAME}_R1_001.fastq.gz | samtools view -bS - > /datacommons/ydiaolab/arinze/daichi/bam2/${READ1_NAME}.bam
