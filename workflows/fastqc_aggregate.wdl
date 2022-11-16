version 1.0

import "../tasks/multiqc_task.wdl" as multiqc

workflow fastqc_aggregate{
	input{
		Array[File] reports
	}
	call multiqc.multiqc_task{
		input: reports = reports
	}

}