version 1.0

import "../tasks/bwa_task.wdl" as bwa
import "../tasks/samtools_task.wdl" as samtools

workflow serratia_bwa_map{
	input{
		File r1
		File r2
		File reference
	}
	call bwa.bwa_task{
		input: r1 = r1, r2 = r2, reference = reference
	}
	call samtools.samtools_task{
		input: sam = bwa_task.sam
	}

}