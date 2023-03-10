version 1.0


task quast_task{
	input{
		String docker = "staphb/quast"
		Int cpu = 4
		Int memory = 8
		String samplename

		#quast params
		File reference
		File query
		File r1
		File r2
	}
	command <<<
		quast.py ~{query} -r ~{reference} -o "temp" --pe1 ~{r1} --pe2 ~{r2}
		grep "N50" temp/report.tsv | sed "s/N50.//" > N50
		grep "Total length.[^(]" temp/report.tsv | sed "s/Total length.//" > TOTAL_LENGTH
		grep "^GC" temp/report.tsv | sed "s/GC (%).//" > GC
		grep "^Avg. coverage depth" temp/report.tsv | sed "s/Avg. coverage depth.//" > SEQ_COV
		grep "Genome fraction" temp/report.tsv | sed "s/Genome fraction (%).//" > REF_COV
		#rename files
		mv temp/report.tsv temp/~{samplename}_report.tsv
		mv temp/report.pdf temp/~{samplename}_report.pdf
		mv temp/contigs_reports/misassemblies_report.tsv temp/contigs_reports/~{samplename}_misassemblies_report.tsv
		mv temp/contigs_reports/unaligned_report.tsv temp/contigs_reports/~{samplename}_unaligned_report.tsv

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
		File quast_report = "temp/~{samplename}_report.tsv"
		String N50 = read_string("N50")
		String total_length = read_string("TOTAL_LENGTH")
		String percent_GC = read_string("GC")
		String sequencing_coverage = read_string("SEQ_COV")
		String percent_reference_coverage = read_string("REF_COV")
		File quast_report_pdf = "temp/~{samplename}_report.pdf"
		File misassemblies_report = "temp/contigs_reports/~{samplename}_misassemblies_report.tsv"
		File unaligned_report = "temp/contigs_reports/~{samplename}_unaligned_report.tsv"
	}
}