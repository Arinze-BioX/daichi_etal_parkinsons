#!/bin/bash
#
#SBATCH --job-name=umi_name
#SBATCH --output=umi_name.out
#SBATCH --error=umi_name.err
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --array=0-7
#SBATCH --mem-per-cpu=30G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=aeo21@duke.edu

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate snakemake_3dstarrseq

PATH1='/datacommons/ydiaolab/arinze/daichi/trial4_ActDel_Dec2024/selected_InPlasmid_reads/'
samples=( "D9" "D10" "D11" "D12" "D13" "D14" "D15" "D16" )
sample=${samples[${SLURM_ARRAY_TASK_ID}]}

umi_tools extract --extract-method=regex --ignore-read-pair-suffixes --bc-pattern='^(?P<umi_1>.{10})(?P<discard_2>.{47})' \
--bc-pattern2='^(?P<discard_1>.{38}).+(?P<discard_2>.{15})$' \
--log=log1.txt -I ${PATH1}${sample}_R1_001.fastq.gz -S ${PATH1}${sample}_uminamed_R1_001.fastq.gz \
--read2-in=${PATH1}${sample}_R2_001.fastq.gz --read2-out=${PATH1}${sample}_uminamed_R2_001.fastq.gz > log2.txt