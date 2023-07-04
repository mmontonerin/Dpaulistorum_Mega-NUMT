#!/bin/bash

for cds in CDS*.fasta
do
	mafft $cds > ${cds}_mafft.out
done


