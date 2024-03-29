<h1>Welcome to the Serratia assembly pipeline</h1><br>

This pipeline is designed for use with paired-end Illumina reads on the [Terra platform](https://app.terra.bio).<br>
The pipeline consists of two parts. First, Serratia_Preprocess is run to trim raw reads and generate QC reports for both the trimmed and untrimmed files using [FastQC](https://github.com/s-andrews/FastQC). The QC reports can then optionally be aggregated into a single report for each step using the Fastqc_Aggregate pipeline, which runs [MultiQC](https://github.com/ewels/MultiQC). Note that this step is run as a set-level workflow. At this point, the user is encouraged to review the QC reports and decide which samples to generate assemblies for. Finally, the Serratia_Assemble pipeline is used for the construction of the assemblies and generation of QC metrics. If you simply wish to generate sequencing coverage metrics for existing assemblies, you can run the Get_Coverage workflow. This step is normally run as part of Serratia_Assemble but can also be run separately.<br><br>


To run, please import the workflows from Dockstore into your workspace.<br>[Serratia_Preprocess](https://dockstore.org/workflows/github.com/MontereyCoPHL/Serratia_pipeline/Serratia_Preprocess:main?tab=info)<br>[Fastqc_Aggregate](https://dockstore.org/workflows/github.com/MontereyCoPHL/Serratia_pipeline/Fastqc_Aggregate:main?tab=info)<br>[Serratia_Assemble](https://dockstore.org/workflows/github.com/MontereyCoPHL/Serratia_pipeline/Serratia_Assemble:main?tab=info)<br>
[Get_Coverage](https://dockstore.org/workflows/github.com/MontereyCoPHL/Serratia_pipeline/get_coverage:main?tab=info)<br><br>
Recommended reference file: [GCF_003031645.1_ASM303164v1_genomic.fna](https://www.ncbi.nlm.nih.gov/data-hub/genome/GCF_003031645.1)
