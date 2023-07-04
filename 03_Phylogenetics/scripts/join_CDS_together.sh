for mito in "MS" "mito1" "mito2" "mito3" "mito4" "mito5" "mito6" "mito7" "mito8" "mito9" "mito10" "mito11" "mito12"
do

        all="./genes_${mito}.fasta"

        seqkit grep -r -p CDS01 $all >> CDS01.fasta
        seqkit grep -r -p CDS02 $all >> CDS02.fasta
        seqkit grep -r -p CDS03 $all >> CDS03.fasta
        seqkit grep -r -p CDS04 $all >> CDS04.fasta
        seqkit grep -r -p CDS05 $all >> CDS05.fasta
        seqkit grep -r -p CDS06 $all >> CDS06.fasta
        seqkit grep -r -p CDS07 $all >> CDS07.fasta
        seqkit grep -r -p CDS08 $all >> CDS08.fasta
        seqkit grep -r -p CDS09 $all >> CDS09.fasta
        seqkit grep -r -p CDS10 $all >> CDS10.fasta
        seqkit grep -r -p CDS11 $all >> CDS11.fasta
        seqkit grep -r -p CDS12 $all >> CDS12.fasta
        seqkit grep -r -p CDS13 $all >> CDS13.fasta   

done
