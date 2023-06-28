#!/bin/bash

cd /space/no_backup/merce/mito

#Load data and directories:
O11b2="./assemblies/O11_b2.fasta" #O11 with beta2
a2="./mito_genomes/OR_alpha2.fasta" #NUMT
b2="./mito_genomes/OR_beta2.fasta" #O11 mito

ann="./annotation"
blst="./blast_results"
gen="./genes_and_repeats"
run="./scripts"

mitoa=$(basename "$a2" .fasta)
mitob=$(basename "$b2" .fasta)
foxo="${gen}/FlyBase_IHLGPO.fa"

###################################################################

#BLAST mito genomes to Drosophila genome
makeblastdb -in ${O11} -dbtype nucl -parse_seqids
makeblastdb -in ${O11b2} -dbtype nucl -parse_seqids

#BLASTn sequences FOXO and mitochondria to assemblies
echo "BLASTing ${foxo} in ${O11} and ${O11b2}"
blastn -db ${O11} -query ${foxo} -outfmt 6 -out ${blst}/O11_foxo.out
blastn -db ${O11b2} -query ${foxo} -outfmt 6 -out ${blst}/O11b2_foxo.out

echo "BLASTing ${a2} in ${O11} and ${O11b2}"
blastn -db ${O11} -query ${a2} -outfmt 6 -out ${blst}/O11_a2.out
blastn -db ${O11b2} -query ${a2} -outfmt 6 -out ${blst}/O11b2_a2.out

echo "BLASTing ${b2} in ${O11} and ${O11b2}"
blastn -db ${O11} -query ${b2} -outfmt 6 -out ${blst}/O11_b2.out
blastn -db ${O11b2} -query ${b2} -outfmt 6 -out ${blst}/O11b2_b2.out

#Extract NUMT sequences
awk -F"\t" '{if ($4 >= 500 && $3 >= 90) print}' ${blst}/O11_a2.out > ${blst}/O11_a2_l500_pid90.out

awk -v O11=$O11 -F"\t" '{if ($10 > $9) print "blastdbcmd -db " O11 " -dbtype nucl -entry " $2 " -range " $9 "-" $10 " -strand plus -out ../mito/O11_"$2 "_" $9 "-" $10 "+.out"; else print "blastdbcmd -db " O11 " -dbtype nucl -entry " $2 " -range " $10 "-" $9 " -strand minus -out ../mito/O11_" $2 "_" $9 "-" $10 ".out"}' ${blst}/O11_a2_l500_pid90.out > ${run}/extract_blast_seq.sh

chmod +x ${run}/extract_blast_seq.sh

${run}/extract_blast_seq.sh
 






