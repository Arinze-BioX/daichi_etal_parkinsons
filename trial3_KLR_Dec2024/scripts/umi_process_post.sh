#!/bin/bash
#
#SBATCH --job-name=umi_name
#SBATCH --output=umi_name.out
#SBATCH --error=umi_name.err
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --array=0-3
#SBATCH --mem-per-cpu=30G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=aeo21@duke.edu

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate snakemake_3dstarrseq

PATH1='/datacommons/ydiaolab/arinze/daichi/trial3_KLR_Dec2024/selected_InPlasmid_reads/'
samples=($(ls ${PATH1}Post*_R1_001.fastq.gz | perl -p -e "s/\/.*selected_InPlasmid_reads\///g" | perl -p -e "s/_R1_001\.fastq\.gz//g"))
sample=${samples[${SLURM_ARRAY_TASK_ID}]}

umi_tools extract --extract-method=regex --ignore-read-pair-suffixes --bc-pattern='^(?P<umi_1>.{10})(?P<discard_2>.{47})' \
--bc-pattern2='^(?P<discard_1>.{38}).+(?P<discard_2>.{15})$' \
--log=log1.txt -I ${PATH1}${sample}_R1_001.fastq.gz -S ${PATH1}${sample}_uminamed_R1_001.fastq.gz \
--read2-in=${PATH1}${sample}_R2_001.fastq.gz --read2-out=${PATH1}${sample}_uminamed_R2_001.fastq.gz > log2.txt