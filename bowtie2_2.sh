#!/bin/bash
#gunzip TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta.gz

#bowtie2-build TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta Index

mapfile -t End1 < "group2-1"
mapfile -t End2 < "group2-2"

cd /home/s2558632/ICA1/fastqc

for i in "${!End1[@]}"
do
	
	file1="${End1[$i]}"
	file2="${End2[$i]}"
	bowtie2 -x /home/s2558632/ICA1/Tcongo_genome/Index -1 "$file1" -2 "$file2" -S /home/s2558632/ICA1/Tcongo_genome/2sets_2.sam -p 1
done

#bowtie2 -x ./Index -1 {data*_1} -2 {data*_2} -S ./2sets.sam -p 1
