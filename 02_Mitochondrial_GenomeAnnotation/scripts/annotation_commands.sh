#!/bin/bash

for mito in ./*.fasta
do
        name=$(basename ${mito} .fasta)

#       makeblastdb -in $mito -dbtype nucl -parse_seqids
        blastn -db $mito -query ./annotation/Dwil_mito_CDS.ffn -out Dwil_mito_CDS_vs_${name}_new.out
        blastn -db $mito -query ./annotation/Dwil_mito_tRNA_rRNA.fasta -out Dwil_mito_RNA_vs_${name}_new.out
        ./annotation/mito_anno_blastn_to_tab.pl Dwil_mito_CDS_vs_${name}_new.out > ${name}_anno_CDS_new.tab
        ./annotation/mito_anno_blastn_to_tab.pl Dwil_mito_RNA_vs_${name}_new.out > ${name}_anno_RNA_new.tab
        cat ${name}_anno_CDS_new.tab ${name}_anno_RNA_new.tab >> ${name}_anno_all_new.tab
done