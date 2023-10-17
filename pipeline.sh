#!/bin/bash
cd /home/s2558632/ICA1
cp -r /localdisk/data/BPSM/ICA1/fastq .
cp -r /home/s2558632/ICA1/fastq fastqc

cd fastqc
mv Tco2.fqfiles ../
bash gunzip.sh

cd ../

sh code.sh
git add fastqc_out
git commit -m ‘fastqc_out’
git push -u origin main

mkdir Tcongo_genome
cd Tcongo_genome
cp -r /localdisk/data/BPSM/ICA1/Tcongo_genome .
gunzip TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta.gz
bowtie2-build TriTrypDB-46_TcongolenseIL3000_2019_Genome.fasta Index

grep Clone1 Tco2.fqfiles|awk -F '\t' '{print $1}'|sed -e 's/Tco/Tco-/' -e 's/$/_1.fq/' > group1-1
grep Clone1 Tco2.fqfiles|awk -F '\t' '{print $1}'|sed -e 's/Tco/Tco-/' -e 's/$/_2.fq/' > group1-2

grep Clone2 Tco2.fqfiles|awk -F '\t' '{print $1}'|sed -e 's/Tco/Tco-/' -e 's/$/_1.fq/' > group2-1
grep Clone2 Tco2.fqfiles|awk -F '\t' '{print $1}'|sed -e 's/Tco/Tco-/' -e 's/$/_2.fq/' > group2-2

grep WT Tco2.fqfiles|awk -F '\t' '{print $1}'|sed -e 's/Tco/Tco-/' -e 's/$/_1.fq/' > groupWT-1
grep WT Tco2.fqfiles|awk -F '\t' '{print $1}'|sed -e 's/Tco/Tco-/' -e 's/$/_2.fq/' > groupWT-2


nohup bash bowtie2_1.sh > group1.log &
nohup bash bowtie2_2.sh > group2.log &
nohup bash bowtie2_wt.sh > groupWT.log &

#格式转换sam->bam
samtools view -b 2sets_1.sam > 2sets_1.bam
samtools view -b 2sets_2.sam > 2sets_2.bam
samtools view -b 2sets_wt.sam > 2sets_wt.bam

#排序sort
samtools sort -o 2sets_sorted_1.bam 2sets_1.bam
samtools sort -o 2sets_sorted_2.bam 2sets_2.bam
samtools sort -o 2sets_sorted_wt.bam 2sets_wt.bam
cd ../

mkdir bedtools
cd bedtools
cp /localdisk/data/BPSM/ICA1/TriTrypDB-46_TcongolenseIL3000_2019.bed .
sortBed -i TriTrypDB-46_TcongolenseIL3000_2019.bed > sorted.bed
cp /home/s2558632/ICA1/Tcongo_genome/2sets_sorted_1.bam .
cp /home/s2558632/ICA1/Tcongo_genome/2sets_sorted_2.bam .
cp /home/s2558632/ICA1/Tcongo_genome/2sets_sorted_wt.bam .

bedtools coverage -a sorted.bed -b 2sets_sorted_1.bam -counts > counts_1.txt
bedtools coverage -a sorted.bed -b 2sets_sorted_2.bam -counts > counts_2.txt
bedtools coverage -a sorted.bed -b 2sets_sorted_wt.bam -counts > counts_wt.txt


