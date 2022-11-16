version 1.0


task unicycler_task{
	input{
		String docker = "staphb/unicycler:latest"
		Int cpu = 4
		Int memory = 8

		#unicycler params
		File r1
		File r2
		String baseout = sub(basename(r1), "_1P.fq.gz", "")
		Int threads = 4
	}
	command <<<
		unicycler -1 ~{r1} -2 ~{r2} -o temp

		#rename outputs
		mv temp/assembly.gfa "temp/~{baseout}_assembly.gfa"
		mv temp/assembly.fasta "temp/~{baseout}_assembly.fasta"
		mv temp/unicycler.log "temp/~{baseout}_unicycler.log"
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
		File assembly_gfa = "temp/~{baseout}_assembly.gfa"
		File assembly_fasta = "temp/~{baseout}_assembly.fasta"
		File unicycler_log = "temp/~{baseout}_unicycler.log"
	}
}