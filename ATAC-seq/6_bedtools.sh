#!/bin/bash
#SBATCH  -e errot.txt
#SBATCH  -o output.txt

#Load binaries
module load bioinfo/bedtools-2.26.0

dir_bed_file=(/home/nhakim/work/5_MACS2/)

ext_bed="_peaks.narrowPeak"

dir_out=(/home/nhakim/work/5_MACS2_bis/)

cd /home/nhakim/work/5_MACS2_bis/ 

bedtools  intersect -a KO2_S1$ext_bed -b KO3_S2$ext_bed  > $dir_out"PEAKS-KO.bed" # pics detecté dans les 2 KO

bedtools  intersect -a GFP1_S3$ext_bed -b GFP2_S4$ext_bed  > $dir_out"PEAKS-1-2.bed" # pics detecté dans les GFP1 et GFP2

bedtools  intersect -a PEAKS-1-2.bed -b GFP3_S5$ext_bed  > $dir_out"PEAKS-WT.bed" # pics detecté entre les 3 GFP

bedtools  intersect -a PEAKS-WT.bed  -b PEAKS-KO.bed -v > $dir_out"PeaksSpecificEomes.bed" 

cat  PEAKS-KO.bed PEAKS-WT.bed |sort -k1V -k2,2n | bedtools merge -i - | awk '{OFS="\t"; print($0, "Region_"NR)}' > merge_peaks.bed # Merge de tout les pics 
