#!/usr/bin/env nextflow

nextflow.enable.dsl = 2


// Define the Nextflow process for downloading and processing data
process internPull {
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
process convertToTIFF {
    container 'util/tiff-export'

    input:
    path "$params.out_dir/data.npy"

    script:
    """
    #!/usr/bin/env python

    import numpy as np
    import tifffile as tiff

    numpy_array = np.load("$params.out_dir/data.npy")

    # Iterate over each slice in the data cube
    if numpy_array.ndim == 2:
        tiff.imwrite(f"$params.out_dir/slice_0.tiff", numpy_array)
    else:
        for i, slice_data in enumerate(numpy_array):
            # Save the slice as a TIFF image
            tiff.imwrite(f"$params.out_dir/slice_{i}.tiff", slice_data)
    """
}

// Define the Nextflow workflow
workflow {
    internPull()
    convertToTIFF(internPull.out)
}
