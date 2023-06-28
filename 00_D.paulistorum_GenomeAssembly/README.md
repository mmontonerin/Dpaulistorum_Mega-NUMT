# Whole genome assembly of *D. paulistorum* O11

### Data
Long-read data, Oxford Nanopore

`1 376 601 reads`

`19 454 247 303 bp`

## Sub-sample of reads
Using [Filt-long v0.2.1](https://github.com/rrwick/Filtlong)
|Species|Starting number of reads|Starting base pairs|Starting coverage|Subsampling method|Number of reads post-subsample|Base pairs post-subsample|Coverage post-subsample|
|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|D. paulistorum O11|1376601|19454247303|77|[Quality priority, 50X](https://github.com/mmontonerin/Drosophila_wolbachia_infection_related_genes/blob/main/00_Assembly/Scripts/00_D_paulistorum_O11_subsample.sh)|827899|12500020744|50|

## Whole genome assembly
Using [NextDenovo v2.5.0](https://github.com/Nextomics/NextDenovo/releases/tag/v2.5.0)

Create a folder for the assembly to be made

`mkdir O11_nextdenovo`

`cd O11_nextdenovo`

Copy the sub-sampled fastq file to the folder:

`cp /path/read_data.fastq ./O11_qual_filtered_50X.fastq.gz`

Create input.fofn with assembly `location/name` in folder:

`ls *fastq.gz | cat > input.fofn`

Create run.cfg file:

```
[General]
job_type = local
job_prefix = nextDenovo
task = all
rewrite = yes
deltmp = yes
parallel_jobs = 4
input_type = raw
read_type = ont # clr, ont, hifi
input_fofn = /path/to/folder/O11_nextdenovo/input.fofn
workdir = /path/to/folder/O11_nextdenovo/O11_assembly

[correct_option]
read_cutoff = 1k
genome_size = 250m
sort_options = -m 7g -t 2
minimap2_options_raw = -t 3
pa_correction = 17
correction_options = -p 2

[assemble_option]
minimap2_options_cns = -t 3
nextgraph_options = -a 1
```

One must adapt the settings according to the capacity of your own computer/server in which you are running it, check guidelines [here](https://nextdenovo.readthedocs.io/en/latest/OPTION.html) and [here](https://nextdenovo.readthedocs.io/en/latest/FAQ.html#how-to-optimize-parallel-computing-parameters).

After assembly, contigs are renamed with [this script](https://github.com/mmontonerin/Drosophila_wolbachia_infection_related_genes/blob/main/00_Assembly/Scripts/fasta_rename_nextdenovo.pl) to keep them simple and without spaces nor symbols.



## Repeat pipeline

I modified the pipeline made by Verena Kutchera, at the National Bioinformatics Infrastructure Sweden (NBIS), to only run the part involving repeat analysis.

The complete pipeline in Snakemake format can be found [here](https://bitbucket.org/scilifelab-lts/genemark_fungal_annotation/)

The modified Snakefile to run only the repeat analysis pipeline can be found [here](https://github.com/mmontonerin/Drosophila_wolbachia_infection_related_genes/blob/main/01_Gene_prediction/Snakefile_repeatpipeline_only), as well as the [configuration file](https://github.com/mmontonerin/Drosophila_wolbachia_infection_related_genes/blob/main/01_Gene_prediction/config_repeatpipeline_only.yaml), and the [cluster file](https://github.com/mmontonerin/Drosophila_wolbachia_infection_related_genes/blob/main/01_Gene_prediction/cluster_repeatpipeline_only.yaml). The Snakemake environment folders can be retreived from the original pipeline linked above.

##### Pipeline in brief:

* Change all lowercase bases to uppercase so the assembly is even before the repeat pipeline.
* De novo prediction of repeat and transposable elements with [RepeatModeler v1.0.8](https://www.repeatmasker.org/RepeatModeler/)
* Split the UniProt/Swissprot protein database into chunks for transposonPSI
* Identify transposons in the UniProt/Swissprot protein dataset
* Remove transposons from the UniProt/Swissprot protein dataset
* Generate BLAST database from filtered UniProt/Swissprot protein dataset
* Blastx repeat library to filtered Uniprot/Swissprot database
* Remove blast hits from repeat library so that non-transposable genes are removed from the repeat library
* Final repeat library used to mask the genome assembly with [RepeatMasker v4.0.7](http://www.repeatmasker.org/RepeatMasker/) 