#!/bin/bash
#
#SBATCH --job-name=daichi_post
#SBATCH --output=daichi_post.out
#SBATCH --error=daichi_post.err
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --array=0-2
#SBATCH --mem-per-cpu=20G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=aeo21@duke.edu

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate snakemake_HiCAR

PATH1='/datacommons/ydiaolab/bgi_data/demutiplex/YD166/'
READ1s=($(ls ${PATH1}AO{46,47,48}_R1_001.fastq.gz))
READ2s=($(ls ${PATH1}AO{46,47,48}_R2_001.fastq.gz))
READ1=${READ1s[${SLURM_ARRAY_TASK_ID}]}
READ2=${READ2s[${SLURM_ARRAY_TASK_ID}]}
READ1_NAMES=($(ls ${PATH1}AO{46,47,48}_R1_001.fastq.gz | perl -p -e "s/\/.*YD166\///g" | perl -p -e "s/_R1_001\.fastq\.gz//g"))
READ2_NAMES=($(ls ${PATH1}AO{46,47,48}_R2_001.fastq.gz | perl -p -e "s/\/.*YD166\///g" | perl -p -e "s/_R2_001\.fastq\.gz//g"))
READ1_NAME=${READ1_NAMES[${SLURM_ARRAY_TASK_ID}]}
READ2_NAME=${READ2_NAMES[${SLURM_ARRAY_TASK_ID}]}

cutadapt -Z -e 0.1 --no-indels --action trim --discard-untrimmed \
-g gtttaagagctaagctggaaacagcatagcaagtttaaataaggctagtccgttatcaacttgaaaaagtggcaccgagtcg \
-o ${READ1_NAME}_trimmed_R1_001.fastq.gz -p ${READ2_NAME}_trimmed_R2_001.fastq.gz ${READ1} ${READ2}