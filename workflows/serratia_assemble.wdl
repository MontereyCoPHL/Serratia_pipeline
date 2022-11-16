version 1.0

import "../tasks/unicycler_task.wdl" as unicycler
import "../tasks/ragtag_task.wdl" as ragtag
import "../tasks/quast_task.wdl" as quast
import "../tasks/busco_task.wdl" as busco

workflow serratia_assemble{
	input{
		File r1
		File r2
		File reference
	}
	call unicycler.unicycler_task{
		input: r1 = r1, r2 = r2
	}
	call ragtag.ragtag_task{
		input: reference = reference, query = unicycler_task.assembly_fasta
	}
	call quast.quast_task{
		input: query = ragtag_task.ragtag_assembly, reference = reference, r1 = r1, r2 = r2
	}
	call busco.busco_task{
		input: query = ragtag_task.ragtag_assembly
	}

}