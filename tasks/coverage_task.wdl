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
		#get total count of all bases in fastq file (every fourth line starting at the second is a read)
		r1_total_count=$(gunzip -k -c ~{r1}|sed -n "2~4p"|wc -m)
		#count the total number of reads
		r1_reads=$(gunzip -k -c ~{r1}|grep -c ">")
		#subtract total number of reads from total base count to account for end of line characters that were also counted
		r1_count=$(echo "$r1_total_count-$r1_reads"|bc)
		echo "r1 counts: $r1_count"
		r2_total_count=$(gunzip -k -c ~{r2}|sed -n "2~4p"|wc -m)
		r2_reads=$(gunzip -k -c ~{r2}|grep -c ">")
		r2_count=$(echo "$r2_total_count-$r2_reads"|bc)
		echo "r2 counts: $r2_count"
		genome_bases=$(sed -n "2~2p" ~{reference}|wc -m)
		genome_contigs=$(grep -c ">" ~{reference})
		genome_total_count=$(sed -n "2~2p" ~{reference}|wc -m)
		genome_length=$(echo "$genome_total_count-$genome_contigs"|bc)
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