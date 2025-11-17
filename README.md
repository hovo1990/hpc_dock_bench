# ablab/hpcdockbench

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new/ablab/hpcdockbench)
[![GitHub Actions CI Status](https://github.com/ablab/hpcdockbench/actions/workflows/nf-test.yml/badge.svg)](https://github.com/ablab/hpcdockbench/actions/workflows/nf-test.yml)
[![GitHub Actions Linting Status](https://github.com/ablab/hpcdockbench/actions/workflows/linting.yml/badge.svg)](https://github.com/ablab/hpcdockbench/actions/workflows/linting.yml)[![Cite with Zenodo](http://img.shields.io/badge/DOI-10.5281/zenodo.XXXXXXX-1073c8?labelColor=000000)](https://doi.org/10.5281/zenodo.XXXXXXX)
[![nf-test](https://img.shields.io/badge/unit_tests-nf--test-337ab7.svg)](https://www.nf-test.com)

[![Nextflow](https://img.shields.io/badge/version-%E2%89%A525.04.0-green?style=flat&logo=nextflow&logoColor=white&color=%230DC09D&link=https%3A%2F%2Fnextflow.io)](https://www.nextflow.io/)
[![nf-core template version](https://img.shields.io/badge/nf--core_template-3.4.1-green?style=flat&logo=nfcore&logoColor=white&color=%2324B064&link=https%3A%2F%2Fnf-co.re)](https://github.com/nf-core/tools/releases/tag/3.4.1)
[![run with docker](https://img.shields.io/badge/run%20with-docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)
[![run with singularity](https://img.shields.io/badge/run%20with-singularity-1d355c.svg?labelColor=000000)](https://sylabs.io/docs/)
[![Launch on Seqera Platform](https://img.shields.io/badge/Launch%20%F0%9F%9A%80-Seqera%20Platform-%234256e7)](https://cloud.seqera.io/launch?pipeline=https://github.com/ablab/hpcdockbench)

## Introduction

**ablab/hpcdockbench** is a bioinformatics pipeline that that performs docking benchmark on the Astex and PoseBusters data sets.

<!-- TODO nf-core:
   Complete this sentence with a 2-3 sentence summary of what types of data the pipeline ingests, a brief overview of the
   major pipeline sections and the types of output it produces. You're giving an overview to someone new
   to nf-core here, in 15-20 seconds. For an example, see https://github.com/nf-core/rnaseq/blob/master/README.md#introduction
-->

<!-- TODO nf-core: Include a figure that guides the user through the major workflow steps. Many nf-core
     workflows use the "tube map" design for that. See https://nf-co.re/docs/guidelines/graphic_design/workflow_diagrams#examples for examples.   -->



## Usage

> [!NOTE]
> If you are new to Nextflow and nf-core, please refer to [this page](https://nf-co.re/docs/usage/installation) on how to set-up Nextflow. Make sure to [test your setup](https://nf-co.re/docs/usage/introduction#how-to-run-a-pipeline) with `-profile test` before running the workflow on actual data.

<!-- TODO nf-core: Describe the minimum required steps to execute the pipeline, e.g. how to prepare samplesheets.
     Explain what rows and columns represent. For instance (please edit as appropriate):

First, prepare a samplesheet with your input data that looks as follows:

`samplesheet.csv`:

```csv
sample,fastq_1,fastq_2
CONTROL_REP1,AEG588A1_S1_L002_R1_001.fastq.gz,AEG588A1_S1_L002_R2_001.fastq.gz
```

Each row represents a fastq file (single-end) or a pair of fastq files (paired end).

-->




Now, you can run the pipeline using:

<!-- TODO nf-core: update the following command to include all required parameters for a minimal example -->


## How to run using docker profile
```bash
export ICM_HOME=~/soft/icm/icms
export NFX_OPTS="-Xms=512m -Xmx=4g"
export NXF_GLIBC_VERSION=$(ldd --version | head -n1 | awk '{print $NF}')

nextflow run main.nf \
   -resume \
   -profile docker \
   --outdir ~/hpc_dock_bench_docker \
   --icm_home $ICM_HOME


```


## How to run using Singularity profile
```bash
export ICM_HOME=~/soft/icm/icms
export NFX_OPTS="-Xms=512m -Xmx=4g"
export NXF_GLIBC_VERSION=$(ldd --version | head -n1 | awk '{print $NF}')
export HOOK_URL="https://discord.com/api/webhooks/XXXXXX/XXXXXXXX/slack"

nextflow run main.nf \
   -resume \
   -profile singularity \
   --outdir ~/hpc_dock_bench_singularity_test11 \
   --icm_home $ICM_HOME \
   --hook_url $HOOK_URL


nextflow run main.nf \
   -resume \
   -profile singularity \
   --useGPU true \
   --outdir ~/hpc_dock_bench_singularity_testGPU \
   --icm_home $ICM_HOME \
   --hook_url $HOOK_URL


```

### To Save intermediate results for Singularity/Apptainer run
```bash
export ICM_HOME=~/soft/icm/icms
export NFX_OPTS="-Xms=512m -Xmx=4g"
export NXF_GLIBC_VERSION=$(ldd --version | head -n1 | awk '{print $NF}')

nextflow run main.nf \
   -resume \
   -profile singularity \
   --outdir ~/hpc_dock_bench_singularity \
   --save_intermediate true \
   --icm_home $ICM_HOME


```

## How to run on a basic Slurm Cluster with GPU enabled


```bash
export ICM_HOME=/pro/icm/icms
export NFX_OPTS="-Xms=512m -Xmx=4g"
export SINGULARITY_CACHEDIR="/scratch/$USER/hpc_dock_bench"
export NXF_GLIBC_VERSION=$(ldd --version | head -n1 | awk '{print $NF}')

nextflow run main.nf \
   -resume \
   -profile slurm \
   --useGPU true \
   --outdir ~/a/hpc_dock_bench_slurm_test11 \
   --icm_home $ICM_HOME \
   --save_intermediate true \
   --mount_options "/home/$USER,/mnt/nfsa/pro:/pro:rw,/mnt/nfsa/data:/data:rw,/mnt/nfsa/users:/users:rw,/mnt/nfsa/lab:/lab:rw,/home/opt/tmp:/home/opt/tmp:rw"


```





> [!WARNING]
> Please provide pipeline parameters via the CLI or Nextflow `-params-file` option. Custom config files including those provided by the `-c` Nextflow option can be used to provide any configuration _**except for parameters**_; see [docs](https://nf-co.re/docs/usage/getting_started/configuration#custom-configuration-files).

## Credits

ablab/hpcdockbench was originally written by Hovakim Grabski, Siranuysh Grabska, Ruben Abagyan.

We thank the following people for their extensive assistance in the development of this pipeline:

<!-- TODO nf-core: If applicable, make list of people who have also contributed -->

## Contributions and Support

If you would like to contribute to this pipeline, please see the [contributing guidelines](.github/CONTRIBUTING.md).

## Citations

<!-- TODO nf-core: Add citation for pipeline after first release. Uncomment lines below and update Zenodo doi and badge at the top of this file. -->
<!-- If you use ablab/hpcdockbench for your analysis, please cite it using the following doi: [10.5281/zenodo.XXXXXX](https://doi.org/10.5281/zenodo.XXXXXX) -->

<!-- TODO nf-core: Add bibliography of tools and data used in your pipeline -->

An extensive list of references for the tools used by the pipeline can be found in the [`CITATIONS.md`](CITATIONS.md) file.

This pipeline uses code and infrastructure developed and maintained by the [nf-core](https://nf-co.re) community, reused here under the [MIT license](https://github.com/nf-core/tools/blob/main/LICENSE).

> **The nf-core framework for community-curated bioinformatics pipelines.**
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> _Nat Biotechnol._ 2020 Feb 13. doi: [10.1038/s41587-020-0439-x](https://dx.doi.org/10.1038/s41587-020-0439-x).
