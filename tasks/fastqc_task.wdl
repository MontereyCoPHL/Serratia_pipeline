version 1.0

task fastqc_task{
	input{
		String docker = "staphb/fastqc:latest"
		Int cpu = 4
		Int memory = 8

		#fastqc params
		File read
		String out_zip = "temp/" + sub(basename(read), "\\.fastq*", "_fastqc.zip")
		String out_html = "temp/" + sub(basename(read), "\\.fastq*", "_fastqc.html")
		Int threads = 4
	}
	command <<<
		mkdir temp
		fastqc ~{read} -o temp

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
		File report_zip = out_zip
		File report_html = out_html
	}
}