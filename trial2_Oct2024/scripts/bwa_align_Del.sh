#!/bin/bash
#
#SBATCH --job-name=align_bwa_Del
#SBATCH --output=align_bwa_Del.out
#SBATCH --error=align_bwa_Del.err
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --array=0-7
#SBATCH --mem-per-cpu=30G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=aeo21@duke.edu

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate snakemake_3dstarrseq

PATH1='/datacommons/ydiaolab/arinze/daichi/trial2_Oct2024/'
samples=($(ls ${PATH1}selected_InPlasmid_reads/D*_uminamed_R1_001.fastq.gz | perl -p -e "s/\/.*selected_InPlasmid_reads\///g" | perl -p -e "s/_uminamed_R1_001\.fastq\.gz//g"))
sample=${samples[${SLURM_ARRAY_TASK_ID}]}

bwa mem gRNA_del_sept2024.fa ${PATH1}selected_InPlasmid_reads/${sample}_uminamed_R1_001.fastq.gz ${PATH1}selected_InPlasmid_reads/${sample}_uminamed_R2_001.fastq.gz > ${PATH1}/sam/${sample}_bwa_Del.sam