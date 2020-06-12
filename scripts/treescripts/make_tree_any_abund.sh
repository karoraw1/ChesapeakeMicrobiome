#!/bin/bash

#SBATCH --job-name=at
#SBATCH --time=48:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=99G
#SBATCH --partition=parallel,shared
#SBATCH --mail-type=END 
#SBATCH --mail-user=karoraw1@jhu.edu
#SBATCH --error=alltree.err
#SBATCH --output=alltree.out

LOC_DIR=~/scratch/treescripts
QUERY=query_all_abund.2
INF=${QUERY}.fasta
OUTF1=${QUERY}.cm_scores.txt
OUTF2=${QUERY}.align.sto
OUTF3=${QUERY}.align.fasta
OUTF4=${QUERY}.ref.tre
OUTF5=RAxML_bestTree.${QUERY}.ref.tre
OUTF6=root.${QUERY}.ref.tre
OUTF7=RAxML_rootedTree.root.${QUERY}.ref.tre
OUTF8=${QUERY}.distmat

source ~/.bash_profile
ml python/3.7-anaconda-2019.03
source activate anvio5

cmalign --cpu 24 --dna -o $OUTF2 --sfile $OUTF1 --outformat Pfam 16S_bacteria.cm $INF
seqmagick convert $OUTF2 $OUTF3
raxmlHPC-PTHREADS-AVX -T 24 -m GTRGAMMA -s $OUTF3 -n $OUTF4 -f d -p 42 
raxmlHPC-PTHREADS-AVX -T 24 -m GTRGAMMA -f I -t $OUTF5 -n $OUTF6
raxmlHPC-PTHREADS-AVX -T 24 -f x -p 12345 -t $OUTF7 -s $OUTF3 -m GTRGAMMA -n $OUTF8







