version 1.0

task multiqc_task{
	input{
		String docker = "staphb/multiqc:latest"
		Int cpu = 4
		Int memory = 8

		#multiqc params
		Array[File] reports
		String out_name = "multiqc_report.html"
		Int threads = 4
	}
	command <<<
		multiqc ~{sep=" " reports}
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
		File report = out_name
	}
}