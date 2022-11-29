version 1.0

import "../tasks/multiqc_task.wdl" as multiqc

workflow fastqc_aggregate{
	input{
		Array[File] pretrim_reports
		Array[File] posttrim_reports
	}
	call multiqc.multiqc_task as task1{
		input: reports = pretrim_reports
	}
	call multiqc.multiqc_task as task2{
		input: reports = posttrim_reports
	}
	output{
		File pretrim_multiqc_report = task1.report
		File posttrim_multiqc_report = task2.report

	}

}