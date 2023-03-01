version 1.0

task mummer_task{
	input{
		String docker = "quay.io/broadinstitute/viral-phylo:2.1.20.2"
		Int cpu = 4
		Int memory = 8
		String samplename

		#mummer params
		File reference
		File query
	}
	command <<<
		apt-get update
		apt-get install gnuplot -y
		nucmer -p ~{samplename} ~{reference} ~{query}
		mummerplot -l ~{samplename}.delta -p ~{samplename}_mummer_plot --png
		echo "mummerplot complete"
		#now run gnuplot on generated .gp
		gnuplot ~{samplename}_mummer_plot.gp
		echo "gnuplot complete"
	>>>
	runtime{
		docker: "~{docker}"
		cpu: cpu
		memory: "~{memory} GB"
		disks: "local-disk 100 SSD"
		preemptible: 0
		#maxRetries: 3
	}
	output{
		File mummer_alignments = "~{samplename}.delta"
		File mummer_plot = "~{samplename}_mummer_plot.png"
	}
}