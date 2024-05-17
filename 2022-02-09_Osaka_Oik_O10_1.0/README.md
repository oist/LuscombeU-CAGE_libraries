CAGE libraries from Oikopleura dioica (Osaka lab strain)
========================================================

Samples were taked from three different time points: embryonic (EB), juvenile day2 (D2)
or adult (DE).  Biological replicates are indicated with different numbers (DE1/DE2, …).
Biological replicates were loosely staged in order to screen a broader set of
transcriptional states.

The libraries were processed the same as for
[2021-12-17_Okinawa_Oik](../2021-12-17_Okinawa_Oik/README.md), with the
following differences.

The rRNA sequences were regions 5543-3728 and 10911-7289 from contig 153
of an assembly of the O9 genome.  The preferred reference sequence for O9
is now [`OP113806`](https://www.ncbi.nlm.nih.gov/nucleotide/OP113806.1).

The GTF annotation neede to run the quality controls with the RNA-seq
pipeline was generated from our GFF reference with the following command:

    gffread --force-exons --gene2exon --keep-comments --keep-genes -F -E -T /bucket/LuscombeU/common/Breakpoints/Annotations/OSKA2016v1.9/OSKA2016v1.9.gm.gff
