#!/bin/bash

for mito in "APA8" "C2" "EQU" "FG168" "FG295" "INS" "L1" "NEB" "SM" "TRO" "beta2" "A28"
do

        all="../CDS_${mito}.fasta"

        seqkit grep -r -p CDS01 $all >> ./CDS_others/CDS01.fasta
        seqkit grep -r -p CDS02 $all >> ./CDS_others/CDS02.fasta
         seqkit grep -r -p CDS03 $all >> ./CDS_others/CDS03.fasta
         seqkit grep -r -p CDS04 $all >> ./CDS_others/CDS04.fasta
         seqkit grep -r -p CDS05 $all >> ./CDS_others/CDS05.fasta
         seqkit grep -r -p CDS06 $all >> ./CDS_others/CDS06.fasta
         seqkit grep -r -p CDS07 $all >> ./CDS_others/CDS07.fasta
         seqkit grep -r -p CDS08 $all >> ./CDS_others/CDS08.fasta
         seqkit grep -r -p CDS09 $all >> ./CDS_others/CDS09.fasta
         seqkit grep -r -p CDS10 $all >> ./CDS_others/CDS10.fasta
         seqkit grep -r -p CDS11 $all >> ./CDS_others/CDS11.fasta
         seqkit grep -r -p CDS12 $all >> ./CDS_others/CDS12.fasta
         seqkit grep -r -p CDS13 $all >> ./CDS_others/CDS13.fasta       

done
