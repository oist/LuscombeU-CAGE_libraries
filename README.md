# LuscombeU-CAGE_libraries

## Libraries available

 - [Okinawan species libraries](2021-12-17_Okinawa_Oik/README.md)
 - [Osaka_lab_strain_libraries](2022-02-09_Osaka_Oik/README.md)

## Processing in brief

### Splice leader sequences

mRNAs starting with _splice leader sequences_
[(`ACTCATCCCATTTTTGAGTCCGATTTCGATTGTCTAACAG`)](https://doi.org/10.1128/MCB.24.17.7795-7805.2004)
provide information on the position of _trans-splicing sites_
in the genome.  mRNAs that do not start with splice leader sequences
provide information on _transcription start sites_ (and therefore
promoters).  These two informations need to be processed separately.

Reads pairs where Read 1 is starting with splice leader sequences 
are moved to different files.  The splice leader sequences are then
trimmed.  At the moment this is done with the [TagDust](https://doi.org/10.1186/s12859-015-0454-y)
program, but it may be better to replace it with a program with a larger
user base.

### Sequence alignment

The HiSat aligner used in the [_nf-core_ RNA-seq pipeline](https://nf-co.re/rnaseq)
is able to process paired-end CAGE data and output BAM
files that can be handled correctly by downstream tools.  In
addition, most of its quality control analyses are relevant
to CAGE.  Therefore, we use this RNA-seq pipeline to align
the CAGE libraries.

### Ribosomal RNA sequences

CAGE libraries should not contain ribosomal RNA sequences, since
the rRNAs are not capped.  However, the libraries are never
perfect, and a fraction of rRNA remains.  This is problematic
because the genome contains a lot of repeats that have a strong
sequence similarity with the rRNAs, which would lead to spurious
CAGE signal if the reads were not filtered.

The RNA-seq pipeline removes sequences matching the ribosomal DNA using
[sortmerna](https://doi.org/10.1093/bioinformatics/bts611) tool.
[The reference rDNA regions](https://www.ncbi.nlm.nih.gov/nuccore/?term=Oikopleura+dioica+isolate+ribosomal+RNA+complete+sequence)
for the main populations of _O. dioica_ are now available in GenBank.

### Peak clustering

The transcription start sites found in the CAGE alignments are at
single-nucleotide resolution.  This data is easier to analyse after
clustering the TSS into peaks that represent individual promoters.

The trans-splicing sites are by definition a single-nucleotide
resolution feature, but processing the data through the same
clustering algorithm removes noise caused by sequencing errors

Alignments in BAM format are clustered with the Bioconductor package
[CAGEr](https://bioconductor.org/packages/CAGEr).

### Visualisation

The computed peaks are exported to BED and BED12 formats for upload
in the [ZENBU genome browser](https://fantom.gsc.riken.jp/zenbu)
using the [zenbu_upload](https://github.com/jessica-severin/ZENBU)
command-line tool.

At the moment the raw data is uploaded in BAM format too.  In principle
the BED12 format should be preferred because it saves a lot of space,
but I could not convert the BAM files to BED12 format because the
[pairedBAMtoBED12](https://github.com/Population-Transcriptomics/pairedBamToBed12)
tool does not handle the case when R1 and R2 overlap
and both align to the same splice junction (long paired-end CAGE reads
did not exist when the tool was developed).

### Reproducibility

More technical details are given on the _README_ page of each library.
