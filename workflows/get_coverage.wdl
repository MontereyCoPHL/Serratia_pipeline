version 1.0


import "../tasks/coverage_task.wdl" as coverage

workflow get_coverage{
	input{
		File r1
		File r2
		File reference
		String samplename
	}
	call coverage.coverage_task{
		input: samplename = samplename, reference = reference, r1 = r1, r2 = r2
	}
	output {
		File coverage_report = coverage_task.coverage_report
		String sequencing_coverage = coverage_task.sequencing_coverage
	}

}