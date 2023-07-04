#!/bin/bash


for mito in "MS" "beta2" "alpha2" "mito1" "mito2" "mito3" "mito4" "mito5" "mito6" "mito7" "mito8" "mito9" "mito10" "mito11" "mito12"
do
        ass="../${mito}.fasta"
        #ass="./O11_${mito}.fasta"

        gbk="./${mito}.gbk"

        length=$(bioawk -c fastx '{print length($seq)}' ${ass})
        tab=$'\t'       

        echo ${mito}
        echo ${length}

        echo -e "LOCUS       ${mito}           ${length} bp    DNA     linear   UNK\nDEFINITION  O11_${mito}.fasta\nACCESSION   ${mito} REGION: 1..${length}\nVERSION     ${mito}.1\nSOURCE      Drosophila paulistorum\nFEATURES             Location/Qualifiers\n     source          1..${length}\n" > ${mito}_2.gbk

        cat $gbk >> ${mito}_2.gbk

        sed -e "s/locus_tag=\"C/locus_tag=\"${mito}_C/g" ${mito}_2.gbk > ${mito}_3.gbk
        sed -e "s/note=\"length\ /protein_id=\"${mito}_/g" ${mito}_3.gbk > ${mito}_4.gbk

        grep -v "BASE COUNT" ${mito}_4.gbk > ${mito}_5.gbk
        grep -v "note=" ${mito}_5.gbk > ${mito}_final.gbk

        #sed -e 's/locus_tag/protein_id/g' O11_${mito}_2_final_final.gbk > O11_${mito}_2_final_final_protid.gbk

        rm ${mito}_2.gbk ${mito}_3.gbk ${mito}_4.gbk ${mito}_5.gbk

        grep -v "translation" ${mito}_final.gbk > ${mito}_final_notrans.gbk
done