#!/bin/bash
#gunzip TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta.gz

#bowtie2-build TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta Index

mapfile -t End1 < "group1-1"
mapfile -t End2 < "group1-2"

cd /home/s2558632/ICA1/fastqc

for i in "${!End1[@]}"
do
	
	file1="${End1[$i]}"
	file2="${End2[$i]}"
	bowtie2 -x /home/s2558632/ICA1/Tcongo_genome/Index -1 "$file1" -2 "$file2" -S /home/s2558632/ICA1/Tcongo_genome/2sets_1.sam -p 1
done

mapfile -t End1_2 < "group2-1"
mapfile -t End2_2 < "group2-2"

for i in "${!End1_2[@]}"
do

        file1_2="${End1_2[$i]}"
        file2_2="${End2_2[$i]}"
        bowtie2 -x /home/s2558632/ICA1/Tcongo_genome/Index -1 "$file1_2" -2 "$file2_2" -S /home/s2558632/ICA1/Tcongo_genome/2sets_2.sam -p 1
done

mapfile -t End1_wt < "groupWT-1"
mapfile -t End2_wt < "groupWT-2"

for i in "${!End1_wt[@]}"
do

        file1_wt="${End1_wt[$i]}"
        file2_wt="${End2_wt[$i]}"
        bowtie2 -x /home/s2558632/ICA1/Tcongo_genome/Index -1 "$file1_wt" -2 "$file2_wt" -S /home/s2558632/ICA1/Tcongo_genome/2sets_wt.sam -p 1
done

#bowtie2 -x ./Index -1 {data*_1} -2 {data*_2} -S ./2sets.sam -p 1
