CAGE libraries from Oikopleura dioica (Barcelona lab strain)
============================================================

Samples were taked from TO BE COMPLETED

The libraries were processed the same as for
[2021-12-17_Okinawa_Oik](../2021-12-17_Okinawa_Oik/README.md), with the
following differences.

The reference rRNA sequence used was [`OP113814`](https://www.ncbi.nlm.nih.gov/nucleotide/OP113814.1).

The GTF annotation neede to run the quality controls with the RNA-seq
pipeline was generated from our GFF reference with the following command:

    gffread --force-exons --gene2exon --keep-comments --keep-genes -F -E -T /bucket/LuscombeU/common/Breakpoints/Annotations/Bar2_p4.Flye/Bar2_p4.Flye.gm.gff  > Bar2_p4.gm.gtf

The `nf-core/rnaseq` pipeline version [3.4](https://nf-co.re/rnaseq/3.4) was
started with the following command:

    nextflow run nf-core/rnaseq -r 3.4 -name CAGE_Bar_nf_PE_resume0 -profile oist -work-dir /flash/LuscombeU/deletemeCharlesPlessy/nf_CAGE_Bar_PE_2023 -params-file nf-params.json

