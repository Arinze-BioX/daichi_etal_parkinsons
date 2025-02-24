#!/bin/bash
#
#SBATCH --job-name=daichi_pre
#SBATCH --output=daichi_pre.out
#SBATCH --error=daichi_pre.err
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --array=0-23
#SBATCH --mem-per-cpu=30G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=aeo21@duke.edu

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate snakemake_3dstarrseq

PATH1='/cwork/aeo21/3D-STARRseq/daichi_demultiplex_sept2024/'
samples=($(ls ${PATH1}*_R1_001.fastq.gz | perl -p -e "s/\/.*daichi_demultiplex_sept2024\///g" | perl -p -e "s/_R1_001\.fastq\.gz//g"))
sample=${samples[${SLURM_ARRAY_TASK_ID}]}
PATH2='/datacommons/ydiaolab/arinze/daichi/trial1_sept2024/selected_InPlasmid_reads/'

cutadapt -Z -e 0.2 --no-indels --action none --discard-untrimmed -g ^NNNNNNNNNNTGACTGGTACTGACACGTCGCATGC -G ^TGAGACTATAAATATCCCTTGGAGACCACCCTTGTTTGNNNNNNNNNNNNNNNNNNNNGTTTAAGAGCTAAGCTGGAAACAGC -o ${PATH2}${sample}_post_R1_001.fastq.gz -p ${PATH2}${sample}_post_R2_001.fastq.gz ${PATH1}${sample}_R1_001.fastq.gz ${PATH1}${sample}_R2_001.fastq.gz