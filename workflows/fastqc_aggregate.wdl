version 1.0

import "../tasks/multiqc_task.wdl" as multiqc

workflow fastqc_aggregate{
	input{
		Array[File] r1_pretrim_reports
		Array[File] r1_posttrim_reports
		Array[File] r2_pretrim_reports
		Array[File] r2_posttrim_reports
	}
	call multiqc.multiqc_task as task1{
		input: reports = r1_pretrim_reports
	}
	call multiqc.multiqc_task as task2{
		input: reports = r1_posttrim_reports
	}
	call multiqc.multiqc_task as task3{
		input: reports = r2_pretrim_reports
	}
	call multiqc.multiqc_task as task4{
		input: reports = r2_posttrim_reports
	}
	output{
		File r1_pretrim_multiqc_report = task1.report
		File r1_posttrim_multiqc_report = task2.report
		File r2_pretrim_multiqc_report = task3.report
		File r2_posttrim_multiqc_report = task4.report

	}

}