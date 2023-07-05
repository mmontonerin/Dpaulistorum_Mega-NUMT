#!/bin/bash

awk '{if ($9 == "+") print $5, $6, $7, $11 "-" $10, $2, "+"; else print $5, $6, $7, $11 "-" $10, $2, "-";}' O11.upper.fasta.out | grep -e "ctg" > O11_all_repeats.bed

grep -e "ctg000940" O11_all_repeats.bed > O11_940_all_rep.bed

grep -e "Unknown" O11_940_all_rep.bed > O11_940_unknown_rep.bed

grep -e "RC/Helitron" O11_940_all_rep.bed > O11_940_helitron_rep.bed

grep -e "LTR/Gypsy" O11_940_all_rep.bed > O11_940_gypsy_rep.bed

grep -e "DNA/hAT" O11_940_all_rep.bed > O11_940_hAT_rep.bed

grep -e "Simple_repeat" O11_940_all_rep.bed > O11_940_simple_rep.bed

#To check what is left (repeats not relevant for the region in study (730kb-end))
grep -v -E "RC/Helitron|Unknown|LTR/Gypsy|DNA/hAT|Simple_repeat" O11_940_all_rep.bed > O11_940_without_specials.bed

