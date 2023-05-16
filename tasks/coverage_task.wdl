version 1.0


task coverage_task{
	input{
		String docker = ""
		Int cpu = 4
		Int memory = 8
		File reference
		File r1
		File r2
		String samplename

	}
	command <<<
		./fastqinfo-2.0.sh -r $(head -n 2 ~{r1} | tail -n 1 | wc -c) ~{r1} ~{r2} ~{reference} > ~{samplename}_coverage_out.txt
		tail -n 1 ~{samplename}_coverage_out.txt | sed -E "s/.*[\t]+//" > COVERAGE

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
		File coverage_report = "~{samplename}_coverage_out.txt"
		String sequencing_coverage = read_string("COVERAGE")
	}
}