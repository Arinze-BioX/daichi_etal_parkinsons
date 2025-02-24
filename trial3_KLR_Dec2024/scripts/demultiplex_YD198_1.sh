#!/bin/bash
#SBATCH -J YD198_daichi
#SBATCH -p common
#SBATCH --mem 200GB
#SBATCH -o YD198_daichi_demutiplex.out
#SBATCH -e YD198_daichi_demutiplex.err

source /datacommons/ydiaolab/arinze/apps/miniconda_20220118/etc/profile.d/conda.sh
conda activate snakemake_3dstarrseq

cutadapt -Z -e 0.19 --no-indels --action none --discard-untrimmed -a file:YD198_index -o ../demultiplexed_fastq/{name}_R2_001.fastq.gz -p ../demultiplexed_fastq/{name}_R1_001.fastq.gz /work/yx222/temp/YD198_2.fq.gz /work/yx222/temp/YD198_1.fq.gz