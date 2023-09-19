#!/usr/bin/env python

import datajoint as dj
import pickle 
import pandas as pd
import numpy as np
import click

@click.command()
@click.option("--input_file")
@click.option("--host", default="localhost")
@click.option("--user", default="root")
@click.option("--password", default="simple")
def upload_annotations(input_file, host, user, password):
    dj.config['database.host'] = host
    dj.config['database.user'] = user
    dj.config['database.password'] = password
    dj.conn()

    schema = dj.Schema('incf-demo')

    @schema
    class Components(dj.Manual):
        definition = """
        id: int                           # label id
        ---
        voxel_counts: int                 # size
        centroids: longblob               # centroid position (x,y,z)
        """
    
    comp = Components()

    with open(input_file, 'rb') as pkl:
        stats = pickle.load(pkl)

    data = pd.DataFrame(
        {
            'voxel_counts':list(stats['voxel_counts']),
            'centroids': list(stats['centroids']),
        }
    )
    data['id'] = data.index
    comp.insert(data, skip_duplicates=True)
    print(comp)

if __name__ == "__main__":
    upload_annotations()
    