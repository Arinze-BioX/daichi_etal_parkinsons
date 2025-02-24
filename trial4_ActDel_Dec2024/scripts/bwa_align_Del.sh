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

PATH1='/datacommons/ydiaolab/arinze/daichi/trial4_ActDel_Dec2024/'
samples=( "D5" "D6" "D7" "D8" "D13" "D14" "D15" "D16" )
sample=${samples[${SLURM_ARRAY_TASK_ID}]}
outputs=( "D5_Del_pre_rep1" "D6_Del_pre_rep2" "D7_Del_pre_rep3" "D8_Del_pre_rep4" 
"D13_Del_post_rep1" "D14_Del_post_rep2" "D15_Del_post_rep3" "D16_Del_post_rep4" )
output=${outputs[${SLURM_ARRAY_TASK_ID}]}

bwa mem gRNA_del_sept2024.fa ${PATH1}selected_InPlasmid_reads/${sample}_uminamed_R1_001.fastq.gz \
${PATH1}selected_InPlasmid_reads/${sample}_uminamed_R2_001.fastq.gz | samtools view -o ${PATH1}/bam/${output}.bam