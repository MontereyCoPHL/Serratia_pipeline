version 1.0


task ragtag_task{
	input{
		String docker = "mcphl/ragtag"
		Int cpu = 4
		Int memory = 8
		String samplename

		#ragtag params
		File reference
		File query
	}
	command <<<
		ragtag.py scaffold ~{reference} ~{query}
		mv ragtag_output/ragtag.scaffold.fasta ragtag_output/~{samplename}.fasta
		mv ragtag_output/ragtag.scaffold.stats ragtag_output/~{samplename}.stats

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
		File ragtag_assembly = "ragtag_output/~{samplename}.fasta"
		File ragtag_stats = "ragtag_output/~{samplename}.stats"
	}
}