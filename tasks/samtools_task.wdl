version 1.0


task samtools_task{
	input{
		String docker = "staphb/samtools:latest"
		Int cpu = 4
		Int memory = 8

		#samtools params
		File sam
		String out_bam = sub(basename(sam), ".sam", ".bam")
		String out_results = sub(basename(sam), ".sam", "_results.txt")
		Int threads = 4
	}
	command <<<
		samtools -b view ~{sam} > out_bam
		samtools flagstat out_bam > out_results
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
		File bam = out_bam
		File results = out_results
	}
}