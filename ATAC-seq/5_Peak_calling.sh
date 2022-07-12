#!/bin/bash
#SBATCH -p workq
#SBATCH -t
#Load binaries
module load bioinfo/macs-v2.2.7.1

dir_bam_sorted=(/work/nhakim/4_Bowtie2_align/sorted_bam_file/)

dir_out=(/home/nhakim/work/peaks-calling-pval0.01/)

ext_sorted_bam_file=".sorted.bam"

date

for i in GFP1_S3 GFP2_S4 GFP3_S5 KO2_S1 KO3_S2
do

macs2 callpeak -t $dir_bam_sorted$i$ext_sorted_bam_file \
 			   -f BAMPE \
 			   -n $i \
 			   -g 1.87e9 \
 			   -q 0.01 \
 			   --outdir $dir_out

#-f format ->  bam pairend
#-n sample's name
#-g: genome's length.  We can use "mm10" or 1.87e9
#-q: qvalue

done
