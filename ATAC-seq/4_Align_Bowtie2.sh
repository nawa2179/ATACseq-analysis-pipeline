#!/bin/bash
#SBATCH  -e errot.txt
#SBATCH  -o output.txt
#SBATCH  -p workq
#SBATCH --cpus-per-task=8
#SBATCH --mem=50G

#Load binaries
module load bioinfo/bowtie2-2.2.9
module load bioinfo/samtools-1.4

# dire
dir_data_trimmed=(/work/nhakim/3_Trimming/)

index_mm10=(/home/nhakim/work/4_Bowtie2_align/index_mm10/mm10/mm10)

dir_Sam_file=(/home/nhakim/work/4_Bowtie2_align/Sam_file/)

dir_Bam_file=(/home/nhakim/work/4_Bowtie2_align/Bam_file/)

dir_sorted_bam_file=(/home/nhakim/work/4_Bowtie2_align/sorted_bam_file/)

ext_sam_file=".sam"

ext_bam_file=".bam"

ext_sorted_bam_file=".sorted.bam"

R1="_R1_001_val_1.fq.gz"

R2="_R2_001_val_2.fq.gz"

date

for i in GFP1_S3 GFP2_S4 GFP3_S5 KO2_S1 KO3_S2

do

bowtie2 -x $index_mm10 \
		-p 20 \
		-1 $dir_data_trimmed$i$R1 \
		-2 $dir_data_trimmed$i$R2 \
		-S $dir_Sam_file$i$ext_sam_file

# -x : directory of index
# -p: number of mismatches allowed
# if wa have single-end data (-1), if paired-end -1 & -2 
# -S: directory for Sam files

# Convert Sam files to bam files
samtools view -bh $dir_Sam_file$i$ext_sam_file \
              -o  $dir_Bam_file$i$ext_bam_file

#-b: Output in the BAM format
#-h: Include the header in the output
#-o: output directory 

# Sort the bam files
samtools sort $dir_Bam_file$i$ext_bam_file \
			  -o $dir_sorted_bam_file$i$ext_sorted_bam_file 
				 
done

date