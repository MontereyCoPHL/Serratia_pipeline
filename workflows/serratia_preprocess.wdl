version 1.0

import "../tasks/fastqc_task.wdl" as fastqc
import "../tasks/trimmomatic_task.wdl" as trimmo

workflow serratia_preprocess{
	input{
		File read1
		File read2
	}
	call fastqc.fastqc_task as qc1{
		input: read = read1
	}
	call fastqc.fastqc_task as qc2{
		input: read = read2
	}
	call trimmo.trimmomatic_task as trim{
		input: r1=read1, r2=read2
	}
	call fastqc.fastqc_task as qc3{
		input: read = trim.read1_trimmed
	}
	call fastqc.fastqc_task as qc4{
		input: read = trim.read2_trimmed
	}

}
