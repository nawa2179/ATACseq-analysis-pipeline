#!/bin/bash
#SBATCH  -p workq

#load module fastqc
module load bioinfo/FastQC_v0.11.7

dir_raw_data=("/home/nhakim/work/1_Raw_datas/")

R1="_R1_001.fastq.gz"

R2="_R2_001.fastq.gz"

dir_out=("/home/nhakim/work/2_FastQC/")


for i in GFP1_S3 GFP2_S4 GFP3_S5 KO2_S1 KO3_S2

do

fastqc $dir_raw_data$i$R1 -o $dir_out

fastqc $dir_raw_data$i$R2 -o $dir_out

done

