version 1.0

import "../tasks/fastqc_task.wdl" as fastqc
import "../tasks/trimmomatic_task.wdl" as trimmo

workflow serratia_preprocess{
	input{
		File read1
		File read2
		String samplename
	}
	call fastqc.fastqc_task as qc1{
		input: read = read1
	}
	call fastqc.fastqc_task as qc2{
		input: read = read2
	}
	call trimmo.trimmomatic_task as trim{
		input: r1=read1, r2=read2, samplename = samplename
	}
	call fastqc.fastqc_task as qc3{
		input: read = trim.read1_trimmed
	}
	call fastqc.fastqc_task as qc4{
		input: read = trim.read2_trimmed
	}
	output{
		#qc1 output
		File read1_pretrim_report_zip = qc1.report_zip
		File read1_pretrim_report_html = qc1.report_html
		#qc2 output
		File read2_pretrim_report_zip = qc2.report_zip
		File read2_pretrim_report_html = qc2.report_html
		#qc3 output
		File read1_posttrim_report_zip = qc3.report_zip
		File read1_posttrim_report_html = qc3.report_html
		#qc4 output
		File read2_posttrim_report_zip = qc4.report_zip
		File read2_posttrim_report_html = qc4.report_html
		#trimmomatic output
		File read1_trimmed = trim.read1_trimmed
		File read2_trimmed = trim.read2_trimmed
		File trimmomatic_log = trim.log
	}

}
