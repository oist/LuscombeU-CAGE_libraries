CAGE libraries from Oikopleura dioica (Kin bay)
===============================================

Samples were taked from two different time points: embryonic (EB) or adult (DE).
Some CAGE libraries are technical replicates of each other (T1/T2) because there
was enough RNA to make two libraries.  Otherwise are biological replicates of each
other (EB1/EB2, DE1/DE2).  Biological replicates were loosely staged in order to
screen a broader set of transcriptional states.

[Splice leader](https://doi.org/10.1128/MCB.24.17.7795-7805.2004)
sequences (`ACTCATCCCATTTTTGAGTCCGATTTCGATTGTCTAACAG`) were recognised with
the [TagDust](https://doi.org/10.1186/s12859-015-0454-y) program embedded
in a [_Nextflow_ pipeline](https://github.com/oist/plessy_splitspliceleaderpe)
(tag `v1.0.0` revision ID `2dd9ca3901`), producing two sets of read pairs per sample.

    nextflow run oist/plessy_splitspliceleaderpe --input input.csv -profile oist -w /flash/LuscombeU/charles-plessy/cache/deletemeInOctober --arch SL.Oikopleura_diocia.arch --rrna OKIrRNA.fa

The `SL.Oikopleura_diocia.arch` file contains:

    tagdust -1 S:ACTCATCCCATTTTTGAGTCCGATTTCGATTGTCTAACAG -2 R:N
    tagdust -1 R:N

Files containing reads where the splice leader was found and removed kept
their original name (such as `DE1_T1_SL_READ1.fq.gz`), and files with the
reads that did not contain the splice leader have `_un` added to their
name (such as `DE1_T1_SL_un_READ1.fq.gz`).

I did not use the rRNA-filtered reads produced by TagDust, as it removed
large numbers of reads that do not match rDNA well...

We used [_nf-core_ RNA-seq pipeline](https://nf-co.re/rnaseq) version `3.12` to
align the CAGE reads.

    nextflow run nf-core/rnaseq -r 3.12 -name CAGE_Oki_nf_PE_resume1 -profile oist -work-dir /flash/LuscombeU/deletemeCharlesPlessy/nf_CAGE_Oki_20220106_PE -params-file nf-params.json -resume

As a control, I aligned Read 1 (R1) and Read 2 (R2) alone in single-end
mode.  It showed that alignment rate was increased by trimming R2, but not R1.
I decided to remove 70 bp from R2.  At this value, multimapping starts to
increase and alignment rate and exon rate stop to increase.  5' bias stops to
decrease.  Error rate does not stop to decrease.

I remove the first 6 bases of Read2 because this is where the primer anneals
and this part of the reads has a different base sequence composition.  This
said, it did not make a practical difference in terms of alignment success in
single-end control mapping of R2 alone.

The CAGE libraries were then aligned paired-end with the following parameters:
```
{
    "input": "input.csv",
    "email": "charles.plessy@oist.jp",
    "fasta": "\/bucket\/LuscombeU\/common\/Oikopleura\/Genomes\/OKI2018_I69_1.0\/OKI2018_I69_1.0.fa",
    "gtf": "Okinawa.genes.gtf",
    "hisat2_build_memory": "50.GB",
    "clip_r2": 9,
    "three_prime_clip_r2": 30,
    "aligner": "hisat2",
    "seq_center": "DNAFORM",
    "save_unaligned": true,
    "skip_preseq": true,
    "skip_dupradar": true,
    "skip_markduplicates": true,
    "remove_ribo_rna": true,
    "ribo_database_manifest": "rrna-db.txt"
}
```

Preseq and duprader were skipped (`--skip_preseq`, `--skip_dupradar`) for
paired-end alignment because they take a lot of time.  Picard markduplicates
was also skipped (`--skip_markduplicates`) because there was no PCR
amplification.

The pipeline removes sequences matching the ribosomal DNA (rDNA)
[sortmerna](https://doi.org/10.1093/bioinformatics/bts611) tool.
The reference rDNA region is beginning of the the pseudo-autosomal region (PAR)
of chromosome 3, which we deposited in Genbank as
[`OP113812`](https://www.ncbi.nlm.nih.gov/nucleotide/OP113812.1).

The pipeline runs [Trimgalore](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/),
which finds few Illumina adapter sequences although a
[MGI sequencer](https://en.mgi-tech.com/products/) was used.  I tolerate these
false positives as we need to trim for length anyway.

I could not convert the resulting alignments to BED12 format because the
pairedBAMtoBED12 does not handle the case when R1 and R2 overlap and both
align to the same splice junction.

Alignments in BAM format were clustered with the Bioconductor package
[CAGEr](https://bioconductor.org/packages/CAGEr) and exported to BED and BED12
formats for upload in the [ZENBU genome browser](https://fantom.gsc.riken.jp/zenbu)
using the [zenbu_upload](https://github.com/jessica-severin/ZENBU) command-line tool.
Some notes can be found in the [CAGEr.Rmd](CAGEr.Rmd) file.

TO Do:

Check the unaligned reads that BLAST well: do they match regions with aligned reads or do they
highlight blind spots ?

Tidy CAGEr.Rmd, and give it a proper Rmarkdown parameter handling.
