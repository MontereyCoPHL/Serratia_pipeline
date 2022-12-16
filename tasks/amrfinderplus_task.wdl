version 1.0

task amrfinderplus_task{
	input {
		String docker = "staphb/ncbi-amrfinderplus:latest"
		Int cpu = 4
		Int memory = 8

		#amrfinderplus params
		File assembly
		Int threads = 8
		String base = basename(assembly, ".fasta")
	}
	command <<<
		amrfinder -n ~{assembly} --threads ~{threads} --plus > ~{base}.amrfinder
	>>>
	runtime {
		docker: "~{docker}"
		cpu: cpu
		memory: "~{memory} GB"
		disks: "local-disk 100 SSD"
		preemptible: 0
		maxRetries: 3
	}
	output {
		File amrfinder_report = "~{base}.amrfinder"
	}
}