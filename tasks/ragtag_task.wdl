version 1.0


task ragtag_task{
	input{
		String docker = "mcphl/ragtag"
		Int cpu = 4
		Int memory = 8

		#ragtag params
		File reference
		File query
		String baseout = basename(query)
	}
	command <<<
		ragtag.py scaffold ~{reference} ~{query}
		mv ragtag_output/ragtag.scaffold.fasta ragtag_output/~{baseout}.fasta
		mv ragtag_output/ragtag.scaffold.stats ragtag_output/~{baseout}.stats

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
		File ragtag_assembly = "ragtag_output/~{baseout}.fasta"
		File ragtag_stats = "ragtag_output/~{baseout}.stats"
	}
}