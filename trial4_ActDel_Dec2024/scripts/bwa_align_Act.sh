#!/bin/bash
#
#SBATCH --job-name=align_bwa_Act
#SBATCH --output=align_bwa_Act.out
#SBATCH --error=align_bwa_Act.err
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --array=0-7
#SBATCH --mem-per-cpu=35G
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=aeo21@duke.edu

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate snakemake_3dstarrseq

PATH1='/datacommons/ydiaolab/arinze/daichi/trial4_ActDel_Dec2024/'
samples=( "D1" "D2" "D3" "D4" "D9" "D10" "D11" "D12" )
sample=${samples[${SLURM_ARRAY_TASK_ID}]}
outputs=( "D1_Act_pre_rep1" "D2_Act_pre_rep2" "D3_Act_pre_rep3" "D4_Act_pre_rep4" 
"D9_Act_post_rep1" "D10_Act_post_rep2" "D11_Act_post_rep3" "D12_Act_post_rep4" )
output=${outputs[${SLURM_ARRAY_TASK_ID}]}

bwa mem grna_daichi_sept2024.fa ${PATH1}selected_InPlasmid_reads/${sample}_uminamed_R1_001.fastq.gz \
${PATH1}selected_InPlasmid_reads/${sample}_uminamed_R2_001.fastq.gz | samtools view -o ${PATH1}/bam/${output}.bam
