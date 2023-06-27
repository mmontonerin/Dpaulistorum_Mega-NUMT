#!/bin/bash

#Filter VCFs
for i in ./*vcf.gz
do
        j=$(basename $i .vcf.gz)
        bcftools view -i 'QUAL>=30 && FMT/DP>=10 && FMT/GQ>=30 && FMT/VAF>=0.8' $i -o "$j"_filtered_Q30_DP10_GQ30_VAF_08.vcf --threads 5
done

#Gzip all new VCFs
for i in *filtered_Q30_DP10_GQ30_VAF_08.vcf
do
        bcftools view $i -Oz -o "$i".gz
done

#Index new VCFs
for i in *filtered_Q30_DP10_GQ30_VAF_08.vcf.gz
do
        bcftools index $i
done


#Correct FASTA file
for flyline in "O11" "others"
do
        filter_vcf=$(find ./ -name "${flyline}_filtered*.vcf.gz" -type f)
        assembly="../${flyline}_nextdenovo.fasta"

        echo "Correcting assembly:"
        echo $assembly
        echo "with VCF:"
        echo $filter_vcf
        cat $assembly | bcftools consensus $filter_vcf > ${flyline}_pepper_cor.fasta
done