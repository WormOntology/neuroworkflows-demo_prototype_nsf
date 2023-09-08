#! /usr/bin/python

from multiprocessing import freeze_support

import numpy as np
import tifffile as tiff
from intern import array
from intern.remote.boss import BossRemote


def main():
    config = {
        "protocol": "https",
        "host": "api.bossdb.io",
        "token": "",
    }

    rmt = BossRemote(config)

    # Specify the BOSSdb URI
    bossdb_uri = "bossdb://nguyen_thomas2022/cb2/em"

    # Save a cutout to a numpy array in ZYX order:
    em = array(bossdb_uri)
    data = em[600:606, 111362:112386, 123826:124850]

    # Convert the downloaded data to a NumPy array
    numpy_array = np.array(data)

    # Iterate over each slice in the data cube
    for i, slice_data in enumerate(numpy_array):
        # Save the slice as a TIFF image
        tiff.imsave(f"bossdb_images/slice_{i}.tiff", slice_data)


if __name__ == "__main__":
    freeze_support()
    main()
