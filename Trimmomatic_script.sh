#!/bin/bash

#Inspired by:https://wiki.itap.purdue.edu/pages/diffpagesbyversion.action?pageId=69175426&selectedPageVersions=2&selectedPageVersions=3

#Trimming parameters
trimmer="ILLUMINACLIP:/home/lab/Trimmomatic-0.36/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:40 "

cd /mnt/gluster2/Lung_RNA-seq_Analysis/Old_Data/Original/

#SRCDIR = Files/Only need R1
data="76_GTGAAA_L001_R1_001.fastq.gz 78_GCCAAT_L002_R1_001.fastq.gz 79_ATGTCA_L002_R1_001.fastq.gz 80_GCCAAT_L003_R1_001.fastq.gz 81_CTTGTA_L003_R1_001.fastq.gz 83_ACAGTG_L005_R1_001.fastq.gz  84_GTGAAA_L005_R1_001.fastq.gz 86_CGATGT_L006_R1_001.fastq.gz 87_CAGATC_L006_R1_001.fastq.gz 88_GTGAAA_L006_R1_001.fastq.gz 89_ACAGTG_L007_R1_001.fastq.gz 93_GCCAAT_L008_R1_001.fastq.gz 95_CTTGTA_L008_R1_001.fastq.gz 97_CGATGT_L001_R1_001.fastq.gz 98_CAGATC_L001_R1_001.fastq.gz 99_CCGTCC_L005_R1_001.fastq.gz 109_GCCAAT_L007_R1_001.fastq.gz 110_ATGTCA_L007_R1_001.fastq.gz 111_CCGTCC_L003_R1_001.fastq.gz 112_GTGAAA_L008_R1_001.fastq.gz"

#OUTDIR = Where I want the files to be outputed
OUTDIR=/mnt/gluster2/Lung_RNA-seq_Analysis/Old_Data/Trimmed

#Loop over all the file names in $sample
for r1 in $data; do
     #Copy the filename, r1, to a new file name, r2 and substitute R1 in the name with R2
     #This generates the name of the R2 file
     r2=$r1
     r2="${r1/R1/R2}"
     
     #Generate the names for the four output files, R1.unpaired, R1.paired, R2.unpaired, and R2.paired 
     #From the names of the R1 and R2 input files
     r1p="${r1/.fastq.gz/.paired.fastq.gz}"
     r1u="${r1/.fastq.gz/.unpaired.fastq.gz}"
     r2p="${r2/.fastq.gz/.paired.fastq.gz}"
     r2u="${r2/.fastq.gz/.unpaired.fastq.gz}"

#Run the trimmomatic command, note the path to the datafiles, $data
java -jar ~/Trimmomatic-0.36/trimmomatic-0.36.jar PE $r1 $r2 $out/$r1p $out/$r1u $out/$r2p $out/$r2u $trimmer

done
