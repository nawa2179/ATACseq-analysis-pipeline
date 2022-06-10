#!/bin/bash
#BATCH -J trim_galore_iTreg-S10
#SBATCH -o trim_galore_iTreg-S10.out
#SBATCH -e trim_galore_iTreg-S10.error
#SBATCH --cpus-per-task=4
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mem=32GO

#Load binaries
module load bioinfo/TrimGalore-0.6.5
module load bioinfo/cutadapt-3.4
module load bioinfo/FastQC_v0.11.7


dir_raw_datas=("/home/nhakim/work/1_Raw_datas/")

dir_out=("/home/nhakim/work/3_Trimming/")

R1="_R1_001.fastq.gz"

R2="_R2_001.fastq.gz"


for i in GFP1_S3 GFP2_S4 GFP3_S5 KO2_S1 KO3_S2

do

trim_galore --core 4  --fastqc --paired  $dir_raw_datas$i$R1 $dir_raw_datas$i$R2 -o $dir_out

 
done

date
