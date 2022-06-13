#!/bin/bash
#SBATCH -p workq
#SBATCH -t 60 
#SBATCH --mem 20G

#Load binaries
module load bioinfo/bcl2fastq-2.20.0

run_directory=(/home/nhakim/save/run_dir/220216_NB551452_0289_AHNYTWBGXK/)

bcl_directory=($run_directory"Data/Intensities/BaseCalls/")

output_directory=(/home/nhakim/work/1_Raw_datas/)

bcl2fastq --runfolder-dir $run_directory \
		  -o $output_directory \
		  --input-dir $bcl_directory \
		  --sample-sheet $run_directory"SampleSheet.csv" \
		  --ignore-missing-bcls \
		  --ignore-missing-filter \
		  --ignore-missing-positions \
		  --ignore-missing-controls \
		  --no-lane-splitting
