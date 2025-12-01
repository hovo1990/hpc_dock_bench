

process pocketFeatExtract {
    // errorStrategy 'ignore'
    // cache false
    // def date = LocalDate.now().toString().replace("-","_")

    tag "CPU-ICM-PockeatFeatExtract-p${code}"


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
        publishDir "${params.outdir}/pocket_ICM_FEAT_EXTRACT/stage1_individual", mode: 'copy', overwrite: true
    }



    input:
        tuple val(dataset_name), val(code), path(folder)


    output:
        tuple val(dataset_name), val(code), val("p${code}"), file("${code}_feat.icb"), file("${code}_feat.csv"),path("p${code}/*")


    script:
    def i_version=4
        """
            trap 'if [[ \$? == 251 ]]; then echo OK; exit 0; fi' EXIT
            cp  -r ${folder}/* .
            ${params.icm_home}/icm64 \
                ${projectDir}/bin/pocket_feat_extract.icm \
                    -i=${code}_protein.pdb \
                    -il=${code}_ligand.sdf  \
                    -projID="p${code}" \
                    -out=${code}_session.icb \
                    -ot=${code}_table.csv
        """


        // -- * #template #example #conditional
        // -- * use this only for one case
        // if (code=='8F4J_PHO'){
        //     """
        //         trap 'if [[ \$? == 251 ]]; then echo OK; exit 0; fi' EXIT
        //         cp  -r ${folder}/* .
        //         ${params.icm_home}/icm64 \
        //             ${projectDir}/bin/icm_prep_dock_project.icm \
        //                 -icode=${code} \
        //                 -il=${code}_ligand.sdf  \
        //                 -projID="p${code}"
        //     """
        // } else {
        //     """
        //         trap 'if [[ \$? == 251 ]]; then echo OK; exit 0; fi' EXIT
        //         cp  -r ${folder}/* .
        //         ${params.icm_home}/icm64 \
        //             ${projectDir}/bin/dockScan_prep_dock_project.icm \
        //                 -i=${code}_protein.pdb \
        //                 -il=${code}_ligand.sdf  \
        //                 -projID="p${code}"
        //     """
        // }


}


