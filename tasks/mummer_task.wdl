version 1.0

task mummer_task{
	input{
		String docker = "staphb/mummer"
		Int cpu = 4
		Int memory = 8
		String samplename

		#mummer params
		File reference
		File query
	}
	command <<<
		./nucmer -p ~{samplename} ~{reference} ~{query}
		./mummerplot -l ~{samplename}.delta
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
		File mummer_alignments = "~{samplename}.delta"
		File mummer_plot = "out.png"
	}
}