#!/usr/bin/env nextflow

nextflow.enable.dsl = 2


// Define the Nextflow process for downloading and processing data
process intern_pull {
    container 'intern/pull'
    
    output:
    path "$params.out_dir/data.npy"
    
    """
    python /app/intern_pull.py \
    --bossdb_uri $params.bossdb_uri \
    --z_rng $params.z_rng \
    --y_rng $params.y_rng \
    --x_rng $params.x_rng \
    --output_dir $params.out_dir \
    """
}

// Define the Nextflow process for converting data to TIFF images
process cc3d_annotate {
    container 'cc3d/centroids'

    input:
    path "$params.out_dir/data.npy"

    output:
    path "$params.out_dir/annotations.pkl"

    script:
    """
    python /app/centroids.py \
    --input_file $params.out_dir/data.npy \
    --output_dir $params.out_dir \
    --connectivity $params.connectivity \
    --threshold $params.threshold \
    """
}

process datajoint_push {
    container 'datajoint/push'

    input:
    path "$params.out_dir/annotations.pkl"

    script:
    """
    python /app/datajoint-push.py \
    --input_file $params.out_dir/annotations.pkl \
    --host $params.host \
    --user $params.user \
    --password  $params.password 
    """
}

// Define the Nextflow workflow
workflow {
    intern_pull()
    cc3d_annotate(intern_pull.out)
    datajoint_push(cc3d_annotate.out)
}
