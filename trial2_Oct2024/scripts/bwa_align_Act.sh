#!/bin/bash
#
#SBATCH --job-name=align_bwa_Act
#SBATCH --output=align_bwa_Act.out
#SBATCH --error=align_bwa_Act.err
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --array=0-7
#SBATCH --mem-per-cpu=30G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=aeo21@duke.edu

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate snakemake_3dstarrseq

PATH1='/datacommons/ydiaolab/arinze/daichi/trial2_Oct2024/'
samples=($(ls ${PATH1}selected_InPlasmid_reads/A*_uminamed_R1_001.fastq.gz | perl -p -e "s/\/.*selected_InPlasmid_reads\///g" | perl -p -e "s/_uminamed_R1_001\.fastq\.gz//g"))
sample=${samples[${SLURM_ARRAY_TASK_ID}]}

bwa mem grna_daichi_sept2024.fa ${PATH1}selected_InPlasmid_reads/${sample}_uminamed_R1_001.fastq.gz ${PATH1}selected_InPlasmid_reads/${sample}_uminamed_R2_001.fastq.gz > ${PATH1}/sam/${sample}_bwa_Act.sam
