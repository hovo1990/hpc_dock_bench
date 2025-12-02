

process join_tables{
    // errorStrategy 'ignore'
    // cache false
    // def date = LocalDate.now().toString().replace("-","_")

    tag "CPU-ICM-join_tables-pocket-feats"


    label 'low_cpu_debug'

    // -- * For debug purposes comment it
    maxRetries 5
    errorStrategy {
        if (task.exitStatus >= 100){
            'retry'
        } else {
            'terminate'
        }
    }


    cache true




    if ( workflow.containerEngine == 'singularity' && params.singularity_use_local_file  ) {
        container "${params.singularity_local_cpu_container}"
        // containerOptions " --nv"
    }
    else if (workflow.containerEngine == 'singularity' ){
        container "${params.container_cpu_link}"
    }
    else {
        container "${params.container_cpu_link}"
        // containerOptions " --gpus all"
    }



    if (params.mount_options) {
        if (workflow.containerEngine == 'singularity' ) {
            containerOptions "--bind ${params.mount_options}"
        }
        else {
            containerOptions "--volume ${params.mount_options}"
        }
    }

    if (params.save_intermediate) {
        publishDir "${params.outdir}/pocket_ICM_FEAT_EXTRACT/stage2_joined_table", mode: 'copy', overwrite: true
    }



    input:
       path(query_csv)


    output:
       path("pocket_feats_extracted.csv")


    script:
    def i_version=7
        """
            python  ${projectDir}/bin/join_tables.py \
                    --input="${query_csv}" \
                    --output="pocket_feats_extracted.csv"
        """

    }
