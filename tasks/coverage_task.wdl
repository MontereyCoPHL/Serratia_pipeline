version 1.0


task coverage_task{
	input{
		String docker = "mcphl/fastq-info"
		Int cpu = 4
		Int memory = 8
		File reference
		File r1
		File r2
		String samplename

	}
	command <<<
		r1_count=$(sed -n "2~4p" ~{r1}|wc -m)
		echo -e "r1 counts: $r1"
		r2_count=$(sed -n "2~4p" ~{r2}|wc -m)
		echo "r2 counts: $r2"
		genome_length=$(tail -n+2 ~{reference}|wc -m)
		echo "genome length: $genome_length"
		total_bases=$(echo "$r1_count+$r2_count"|bc)
		echo "total bases: $total_bases"
		coverage=$(echo "$total_bases/$genome_length"|bc)
		echo "coverage: $coverage"
		echo $coverage > COVERAGE
		echo -e "Sample\tBases\tGenome\tCoverage(X)\n~{samplename}\t$total_bases\t$genome_length\t$coverage" > ~{samplename}_coverage_out.txt

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