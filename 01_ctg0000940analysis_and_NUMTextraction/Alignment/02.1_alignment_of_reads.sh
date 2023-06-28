#!/bin/bash

cd /space/no_backup/merce/mito

#Load data and directories:
O11b2="./assemblies/O11_b2.fasta" #O11 with beta2

ali="./alignments"
run="./scripts"
seq="./reads"

###################################################################

#Map all reads
#Nanopore reads

#Index assembly for minimap2
samtools faidx ${O11b2}

echo "Mapping nanopore reads to ${O11b2}"
/space/Software/minimap2/minimap2 -x map-ont -t 20 -a ${O11b2} ${seq}/O11_nanopore.fastq.gz --secondary=no | samtools sort -@ 20 -o ${ali}/O11b2_nanomap.bam
samtools index ${ali}/O11b2_nanomap.bam

#Illumina reads
i11="${seq}/O11_0-1-2_R1.fastq.gz"
i12="${seq}/O11_0-1-2_R2.fastq.gz"
i21="${seq}/O11_3-4_R1.fastq.gz"
i22="${seq}/O11_3-4_R2.fastq.gz"
i31="${seq}/O11_10-11_R1.fastq.gz"
i32="${seq}/O11_10-11_R2.fastq.gz"
i41="${seq}/O11_18-20_R2.fastq.gz"
i42="${seq}/O11_18-20_R1.fastq.gz"

#Index assembly for BWA
/space/Software/bwa/bwa index ${O11b2}

echo "Mapping illumina reads to ${O11b2}"
/space/Software/bwa/bwa mem -t 20 ${O11b2} ${i11} ${i12} | samtools view -bSu - | samtools sort -@ 20 -o ${ali}/O11b2_ilmap_1.bam
/space/Software/bwa/bwa mem -t 20 ${O11b2} ${i21} ${i22} | samtools view -bSu - | samtools sort -@ 20 -o ${ali}/O11b2_ilmap_2.bam
/space/Software/bwa/bwa mem -t 20 ${O11b2} ${i31} ${i32} | samtools view -bSu - | samtools sort -@ 20 -o ${ali}/O11b2_ilmap_3.bam
/space/Software/bwa/bwa mem -t 20 ${O11b2} ${i41} ${i42} | samtools view -bSu - | samtools sort -@ 20 -o ${ali}/O11b2_ilmap_4.bam

samtools merge -o ${ali}/O11b2_ilmap_all.bam ${ali}/O11b2_ilmap_1.bam ${ali}/O11b2_ilmap_2.bam ${ali}/O11b2_ilmap_3.bam ${ali}/O11b2_ilmap_4.bam
samtools index ${ali}/O11b2_ilmap_1.bam
samtools index ${ali}/O11b2_ilmap_2.bam
samtools index ${ali}/O11b2_ilmap_3.bam
samtools index ${ali}/O11b2_ilmap_4.bam
samtools index ${ali}/O11b2_ilmap_all.bam