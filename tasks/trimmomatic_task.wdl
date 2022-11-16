version 1.0

task trimmomatic_task {
	input {
		File r1
		File r2
		String docker = "staphb/trimmomatic"
		Int cpu = 4
		Int memory = 8
		#trimmomatic params
		Int minlen = 100
		Int window_size = 4
		Int quality_trim_score = 15
		Int leading = 3
		Int trailing = 3
		String primers = "/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10"
	}
	String base = sub(basename(r1), "_1.fastq", ".fastq.gz")

	command <<<
		trimmomatic PE -summary -trimlog -phred33 ~{r1} ~{r2} -baseout ~{base} ILLUMINACLIP:~{primers} LEADING:~{leading} TRAILING:~{trailing} SLIDINGWINDOW:~{window_size}:~{quality_trim_score} MINLEN:~{minlen}
	>>>
	output{
		File read1_trimmed = sub(base, "\\.fastq", "_1P.fastq")
		File read2_trimmed = sub(base, "\\.fastq", "_2P.fastq")
		File log = stdout()
	}
	runtime{
		docker: "~{docker}"
		memory: "~{memory} GB"
		cpu: cpu
		disks: "local-disk 100 SSD"
		preemptible: 0
		maxRetries: 3
	}
}