# Step 1: if the package not installed on R

if (!require("BiocManager", quietly = TRUE))
	install.packages("BiocManager")

BiocManager::install("Rsubread")

# Step 2: Load the library
library(Rsubread)

# the annotation file used on "annot.ext" can be obtained by using the following command on bash : 
# awk 'OFS="\t" {print $1"."$2"."$3, $1, $2, $3, "."}' peaks.bed > peaks.saf

count_ATAC= featureCounts(c("GFP1_S3.sorted.bam","GFP2_S4.sorted.bam","GFP3_S5.sorted.bam", "KO2_S1.sorted.bam",
"KO3_S2.sorted.bam"), annot.inbuilt = "mm10", isPairedEnd = T, annot.ext = "merge_peaks.saf")


# Step 3 : write the table
write.csv2(count_ATAC[["counts"]],"count_ATAC.csv")
