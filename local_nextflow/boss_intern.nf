#!/usr/bin/env nextflow

nextflow.enable.dsl = 2


// Define the Nextflow process for downloading and processing data
process downloadData {
    output:
    path "$params.out_dir/data.npy"

    script:
    """
    #!../../../venv/bin/python
    from multiprocessing import freeze_support

    import numpy as np
    import os
    from intern import array
    from intern.remote.boss import BossRemote

    # Why do we need this?
    freeze_support()

    config = {
        "protocol": "https",
        "host": "api.bossdb.io",
        "token": "$params.token",
    }

    # Specify the BOSSdb URI
    bossdb_uri = "$params.bossdb_uri"

    # Save a cutout to a numpy array in ZYX order:
    em = array(bossdb_uri, boss_config=config)
    data = em[$params.roi]

    # Convert the downloaded data to a NumPy array
    numpy_array = np.array(data)
    
    if not os.path.exists("$params.out_dir"):
        os.mkdir("$params.out_dir")

    np.save("$params.out_dir/data.npy", numpy_array)
    """
}

// Define the Nextflow process for converting data to TIFF images
process convertToTIFF {
    input:
    path "$params.out_dir/data.npy"

    script:
    """
    #!../../../venv/bin/python

    import numpy as np
    import tifffile as tiff

    numpy_array = np.load("$params.out_dir/data.npy")

    # Iterate over each slice in the data cube
    if numpy_array.ndim == 2:
        tiff.imsave(f"$params.out_dir/slice_0.tiff", numpy_array)
    else:
        for i, slice_data in enumerate(numpy_array):
            # Save the slice as a TIFF image
            tiff.imsave(f"$params.out_dir/slice_{i}.tiff", slice_data)
    """
}

// Define the Nextflow workflow
workflow {
    downloadData()
    convertToTIFF(downloadData.out)
}
