#!/bin/bash

sed -E 's/>([a-zA-Z0-9]*)\ .*/>mito1_\1/g' bases_mito1.fasta > genes_mito1.fasta
sed -E 's/>([a-zA-Z0-9]*)\ .*/>mito2_\1/g' bases_mito2.fasta > genes_mito2.fasta
sed -E 's/>([a-zA-Z0-9]*)\ .*/>mito3_\1/g' bases_mito3.fasta > genes_mito3.fasta
sed -E 's/>([a-zA-Z0-9]*)\ .*/>mito4_\1/g' bases_mito4.fasta > genes_mito4.fasta
sed -E 's/>([a-zA-Z0-9]*)\ .*/>mito5_\1/g' bases_mito5.fasta > genes_mito5.fasta
sed -E 's/>([a-zA-Z0-9]*)\ .*/>mito6_\1/g' bases_mito6.fasta > genes_mito6.fasta
sed -E 's/>([a-zA-Z0-9]*)\ .*/>mito7_\1/g' bases_mito7.fasta > genes_mito7.fasta
sed -E 's/>([a-zA-Z0-9]*)\ .*/>mito8_\1/g' bases_mito8.fasta > genes_mito8.fasta
sed -E 's/>([a-zA-Z0-9]*)\ .*/>mito9_\1/g' bases_mito9.fasta > genes_mito9.fasta
sed -E 's/>([a-zA-Z0-9]*)\ .*/>mito10_\1/g' bases_mito10.fasta > genes_mito10.fasta
sed -E 's/>([a-zA-Z0-9]*)\ .*/>mito11_\1/g' bases_mito11.fasta > genes_mito11.fasta
sed -E 's/>([a-zA-Z0-9]*)\ .*/>mito12_\1/g' bases_mito12.fasta > genes_mito12.fasta

