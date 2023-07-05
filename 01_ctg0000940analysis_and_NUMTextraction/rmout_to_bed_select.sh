#!/bin/bash


#awk '{if ($9 == "+") print $5, $6, $7, $11 "-" $10, $2, "+"; else print $5, $6, $7, $11 "-" $10, $2, "-";}' O11.upper.fasta.out | grep -e "ctg" > O11_all_repeats.bed

#grep -e "rnd-5_family-2487" O11_all_repeats.bed > O11_mito_rep.bed

#grep -e "RC/Helitron" O11_all_repeats.bed > O11_helitron_rep.bed

#grep -v "rnd-5_family-2487" O11_all_repeats.bed > O11_repeats_without_mito.bed

#grep -v "RC/Helitron" O11_repeats_without_mito.bed > O11_repeats_without_mitoANDheli.bed

#grep -e "rnd-6_family-6103" O11_all_repeats.bed > O11_mito_rep2.bed

grep -e "LTR/Gypsy" O11_all_repeats.bed > O11_gypsy_rep.bed

grep -e "DNA/hAT" O11_all_repeats.bed > O11_hAT_rep.bed

grep -v -E "RC/Helitron|rnd-5_family-2487|rnd-6_family-6103|LTR/Gypsy|DNA/hAT" O11_all_repeats.bed > O11_all_without_specials.bed