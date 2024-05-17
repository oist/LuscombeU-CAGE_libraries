#!/bin/bash

ml bioinfo-ugrp-modules Nextflow2 nf-core

nextflow run nf-core/rnaseq -r 3.12.0 \
    --input input_OSA.csv \
    -resume \
    --outdir /flash/LuscombeU/nico/CAGE/AlignWithRNAseqPipelinePE_OSA/result \
    --email johannes.nicolaus@oist.jp \
    --remove_ribo_rna true \
    --ribo_database_manifest rrna-db.txt \
    --fasta /bucket/LuscombeU/common/Oikopleura/Genomes/O10_1.0/O10_1.0.fa \
    --gtf O10_primary.v1.0.gtf \
    --extra_trimgalore_args "--clip_r2 9 --three_prime_clip_r2 30" \
    --aligner hisat2 \
    --seq_center DNAFORM \
    -work-dir /flash/LuscombeU/nico/CAGE_O10_work \
    --skip_markduplicates true \
    --save_unaligned true \
    --skip_dupradar true



