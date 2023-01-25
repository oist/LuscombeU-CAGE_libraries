CAGE libraries from Oikopleura dioica (Barcelona lab strain)
============================================================

## Sample preparation

Samples were taked from TO BE COMPLETED

The libraries were processed the same as for
[2021-12-17_Okinawa_Oik](../2021-12-17_Okinawa_Oik/README.md), with the
following differences.

## Extraction of trans-pliced sequences

The command to extract reads starting with the splice leader was:

    nextflow run ./main.nf --input input.csv -profile oist -w /flash/LuscombeU/deletemeCharlesPlessy/nf_tmp_CAGE2023_extractSL --arch SL.arch --rrna OP113814.fa

The files in `plessy_splitspliceleaderpe` were used to run the pipeline or
summarise its results.  The input or output FASTQ files are not saved in this
repository as they are too heavy.  The pipeline itself is available at
<https://github.com/oist/plessy_splitspliceleaderpe> (commit
`1bc56f29108e1c3f3b1297d595716995bc4ea10a`).

## Alignment to the genome

The `nf-core/rnaseq` pipeline version [3.4](https://nf-co.re/rnaseq/3.4) was
started with the following command:

    nextflow run nf-core/rnaseq -r 3.4 -name CAGE_Bar_nf_PE_resume0 -profile oist -work-dir /flash/LuscombeU/deletemeCharlesPlessy/nf_CAGE_Bar_PE_2023 -params-file nf-params.json

The reference rRNA sequence used was [`OP113814`](https://www.ncbi.nlm.nih.gov/nucleotide/OP113814.1).

The GTF annotation neede to run the quality controls with the RNA-seq
pipeline was generated from our GFF reference with the following command:

    gffread --force-exons --gene2exon --keep-comments --keep-genes -F -E -T /bucket/LuscombeU/common/Breakpoints/Annotations/Bar2_p4.Flye/Bar2_p4.Flye.gm.gff  > Bar2_p4.gm.gtf

