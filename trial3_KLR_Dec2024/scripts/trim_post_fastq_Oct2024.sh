#!/bin/bash
#
#SBATCH --job-name=KLR_post
#SBATCH --output=KLR_post.out
#SBATCH --error=KLR_post.err
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --array=0-3
#SBATCH --mem-per-cpu=30G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=aeo21@duke.edu

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate snakemake_3dstarrseq

PATH1='/datacommons/ydiaolab/arinze/daichi/trial3_KLR_Dec2024/demultiplexed_fastq/'
samples=($(ls ${PATH1}Post*_R1_001.fastq.gz | perl -p -e "s/\/.*demultiplexed_fastq\///g" | perl -p -e "s/_R1_001\.fastq\.gz//g"))
sample=${samples[${SLURM_ARRAY_TASK_ID}]}
PATH2='/datacommons/ydiaolab/arinze/daichi/trial3_KLR_Dec2024/selected_InPlasmid_reads/'

cutadapt -Z -e 0.2 --no-indels --action none --discard-untrimmed -g ^NNNNNNNNNNTGACTGGTACTGACACGTCGCATG -G ^TGAGACTATAAATATCCCTTGGAGACCACCCTTGTTTGNNNNNNNNNNNNNNNNNNNNGTTTAAGAGCTAAGCTGGAAACAGC -o ${PATH2}${sample}_R1_001.fastq.gz -p ${PATH2}${sample}_R2_001.fastq.gz ${PATH1}${sample}_R1_001.fastq.gz ${PATH1}${sample}_R2_001.fastq.gz