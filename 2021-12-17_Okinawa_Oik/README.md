CAGE libraries from Oikopleura dioica (Kin bay)
===============================================

[Splice leader](https://doi.org/10.1128/MCB.24.17.7795-7805.2004)
sequences (`ACTCATCCCATTTTTGAGTCCGATTTCGATTGTCTAACAG`) were recognised with
the [TagDust](https://doi.org/10.1186/s12859-015-0454-y) program embedded
in a _Nextflow_ pipeline, producing two sets of read pairs per sample.

Sequences matching the rDNA region of the PAR of chr3 were removed by the
sortmerna tool in the nf-core rna-seq pipeline.  We did not use TagDust, as it
removed large numbers of reads that do not match rDNA well...

As a control, Read 1 and Read 2 were aligned alone in single-end mode.  It
showed that alignment rate was increased by trimming Read 2, but not Read 1.
We decided to remove 70 bp from R2.  At this value, multimapping starts to
increase and alignment rate and exon rate stop to increase.  5' bias stops to
decrease.  Error rate does not stop to decrease.

We remove the first 6 bases of Read2 because this is where the primer annealed
and this part of the reads has a different base sequence composition.  This
said, it did not make a practical difference in terms of alignment success in
single-end control mapping of R2 alone.

Trimgalore finds few Illumina adapter sequences although we used a MGI
sequencer.  We tolerate these false positives as we need to trim for length
anyway.

The CAGE libraries were then aligned paired-end.

Preseq and duprader were skipped (`--skip_preseq`, `--skip_dupradar`) for
paired-end alignment because they take a lot of time.  Picard markduplicates
was also skipped (`--skip_markduplicates`) because there was no PCR
amplification.

We could not convert the resulting alignments to BED12 format because the
pairedBAMtoBED12 does not handle the case when R1 and R2 overlap and both
align to the same splice junction.

TO Do:

Upload the aligned reads to ZENBU.  Check
the unaligned reads that BLAST well: do they match regions with aligned reads or do they
highlight blind spots ?
