version 1.0

import "../tasks/unicycler_task.wdl" as unicycler
import "../tasks/ragtag_task.wdl" as ragtag
import "../tasks/quast_task.wdl" as quast
import "../tasks/busco_task.wdl" as busco
import "../tasks/amrfinderplus_task.wdl" as amrfinder

workflow serratia_assemble{
	input{
		File r1
		File r2
		File reference
		String samplename
	}
	call unicycler.unicycler_task{
		input: r1 = r1, r2 = r2, samplename = ~{samplename}
	}
	call ragtag.ragtag_task{
		input: reference = reference, query = unicycler_task.assembly_fasta, samplename = ~{samplename}
	}
	call quast.quast_task{
		input: query = ragtag_task.ragtag_assembly, reference = reference, r1 = r1, r2 = r2, samplename = ~{samplename}
	}
	call busco.busco_task{
		input: query = ragtag_task.ragtag_assembly, samplename = ~{samplename}
	}
	call amrfinder.amrfinderplus_task{
		input: assembly = ragtag_task.ragtag_assembly, samplename = ~{samplename}
	}
	output {
		#unicyler output
		File unicycler_assembly_gfa = unicycler_task.assembly_gfa
		File unicycler_assembly_fasta = unicycler_task.assembly_fasta
		File unicycler_log = unicycler_task.unicycler_log
		#ragtag output
		File ragtag_assembly = ragtag_task.ragtag_assembly
		File ragtag_stats = ragtag_task.ragtag_stats
		#quast output
		File quast_report = quast_task.quast_report
		String N50 = quast_task.N50
		String total_length = quast_task.total_length
		String percent_GC = quast_task.percent_GC
		File quast_report_pdf = quast_task.quast_report_pdf
		File misassemblies_report = quast_task.misassemblies_report
		File unaligned_report = quast_task.unaligned_report
		#busco output
		File busco_report = busco_task.busco_report
		String one_line_summary = busco_task.one_line_summary
		File predicted_genes = busco_task.predicted_genes
		#amrfinderplus output
		File amrfinderplus_report = amrfinderplus_task.amrfinder_report
	}

}