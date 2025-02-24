#!/bin/bash
#
#SBATCH --job-name=align_par
#SBATCH --output=align_par.out
#SBATCH --error=align_par.err
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --array=0-7
#SBATCH --mem-per-cpu=30G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=aeo21@duke.edu

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate bedtools

PATH1='/datacommons/ydiaolab/arinze/daichi/trial1_sept2024/selected_InPlasmid_reads/'
samples=($(ls ${PATH1}*_uminamed_R1_001.fastq.gz | perl -p -e "s/\/.*selected_InPlasmid_reads\///g" | perl -p -e "s/_uminamed_R1_001\.fastq\.gz//g"))
sample=${samples[${SLURM_ARRAY_TASK_ID}]}
bowtie2-build grna_daichi_sept2024_short.fa grna_daichi_sept2024_short
bowtie2 -x grna_daichi_sept2024_short -U ${PATH1}${sample}_uminamed_short_R2_001.fastq.gz > /datacommons/ydiaolab/arinze/daichi/trial1_sept2024/sam/${sample}_bowtie_short.sam
