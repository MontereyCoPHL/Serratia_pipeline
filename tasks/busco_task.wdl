version 1.0


task busco_task{
	input{
		String docker = "ezlabgva/busco:v5.4.3_cv1"
		Int cpu = 4
		Int memory = 8

		#busco params
		File query
		String base = sub(basename(query), ".fasta", "")
	}
	command <<<
		busco --in ~{query} -l bacteria_odb10 -m "genome" -o ~{base}
		grep "one_line_summary" ~{base}/short_summary.specific.bacteria_odb10.~{base}.json | sed -E "s/.*:.\"(.*)\",/\1/" > SUMMARY

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
		File busco_report = "~{base}/short_summary.specific.bacteria_odb10.~{base}.txt"
		String one_line_summary = read_string("SUMMARY")
		File predicted_genes = "~{base}/prodigal_output/predicted_genes/predicted.faa"
	}
}