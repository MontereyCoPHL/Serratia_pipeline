version 1.0


task bwa_task{
	input{
		String docker = "staphb/bwa:latest"
		Int cpu = 4
		Int memory = 8

		#bwa params
		File reference
		File r1
		File r2
		String out_sam = sub(basename(r1), "_1.fastq", ".sam")
		Int threads = 4
	}
	command <<<
		bwa index ~{reference}
		bwa mem ~{reference} ~{r1} ~{r2} > ~{out_sam}
	>>>
	runtime{
		docker: "~{docker}"
		cpu: cpu
		memory: "~{memory} GB"
		disks: "local-disk 100 SSD"
		preemptible: 0
		maxRetries: 3
	}
	output{
		File sam = out_sam
	}
}