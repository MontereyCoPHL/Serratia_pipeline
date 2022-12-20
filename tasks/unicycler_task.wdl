version 1.0


task unicycler_task{
	input{
		String docker = "staphb/unicycler:latest"
		Int cpu = 8
		Int memory = 8
		String samplename

		#unicycler params
		File r1
		File r2
		Int threads = 8
	}
	command <<<
		unicycler -1 ~{r1} -2 ~{r2} -o temp

		#rename outputs
		mv temp/assembly.gfa "temp/~{samplename}_assembly.gfa"
		mv temp/assembly.fasta "temp/~{samplename}.fasta"
		mv temp/unicycler.log "temp/~{samplename}_unicycler.log"
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
		File assembly_gfa = "temp/~{samplename}_assembly.gfa"
		File assembly_fasta = "temp/~{samplename}.fasta"
		File unicycler_log = "temp/~{samplename}_unicycler.log"
	}
}