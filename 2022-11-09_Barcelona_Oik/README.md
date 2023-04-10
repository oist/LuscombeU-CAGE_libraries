CAGE libraries from Oikopleura dioica (Barcelona lab strain)
============================================================

## Sample preparation

Samples were prepared in Barcelona by the Cañestro laboratory.

 - `29FE`: 29 females, 205.2 ng/µL × 14 µL = 2872.8 ng = 2.87 µg 
 - `14FE`: 14 females, 164.1 ng/µL × 14 µL = 2297.4 ng = 2.3 µg
 - `41MA`: 41 males, 472.3 ng/µL × 14 µL = 6612.2 ng = 6.61 µg
 - `D4D5`: D1–D4 adults (no swollen gonad), 431.1 ng/µL × 14 µL = 6035.4 ng = 6.04 µg
 - `D4D5`: D4–D5 adults (maturing gonads), 572 ng/µL × 14 = 7.8 µg
 - `Rep1`: embryos replica 1, 380.7 ng/µL × 14 µL= 5.33 µg 
 - `Rep2`: embryos replica 2, 304.2 ng/µL × 13 µL = 3.95 µg
 - `Rep3`: embryos replica 3: 266.6 ng/µL × 14 µL = 3.73 µg
 - `Rep4`: embryos replica 4: 414.6 ng/µL × 14 µL = 5.8 µg

Sample names do not sort well (sorry) and were chosen so that
they all fit in 4 characters.  Unfortunately, in parts of the
analysis, sample names are prefixed by `X` if they started by
a number…

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

