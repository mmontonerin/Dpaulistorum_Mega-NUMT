#!/bin/bash

for i in *txt
do
        j=$(basename $i .txt)
        awk -F"\t" '{if ($10 > $9) print $2, $9, $10, $1, $3, "+"; else print $2, $9, $10, $1, $3, "-";}' $i > "$j".bed
done