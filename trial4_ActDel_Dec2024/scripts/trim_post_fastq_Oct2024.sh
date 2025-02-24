#!/bin/bash
#
#SBATCH --job-name=daichi_trimPost
#SBATCH --output=daichi_trimPost.out
#SBATCH --error=daichi_trimPost.err
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --array=0-7
#SBATCH --mem-per-cpu=30G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=aeo21@duke.edu

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate snakemake_3dstarrseq

PATH1='/datacommons/ydiaolab/bgi_data/demutiplex/YD199/'
samples=( "D9" "D10" "D11" "D12" "D13" "D14" "D15" "D16" )
sample=${samples[${SLURM_ARRAY_TASK_ID}]}
PATH2='/datacommons/ydiaolab/arinze/daichi/trial4_ActDel_Dec2024/selected_InPlasmid_reads/'

cutadapt -Z -e 0.2 --no-indels --action none --discard-untrimmed -g ^NNNNNNNNNNTGACTGGTACTGACACGTCGCATG -G ^TGAGACTATAAATATCCCTTGGAGACCACCCTTGTTTGNNNNNNNNNNNNNNNNNNNNGTTTAAGAGCTAAGCTGGAAACAGC -o ${PATH2}${sample}_R1_001.fastq.gz -p ${PATH2}${sample}_R2_001.fastq.gz ${PATH1}${sample}_R1_001.fastq.gz ${PATH1}${sample}_R2_001.fastq.gz