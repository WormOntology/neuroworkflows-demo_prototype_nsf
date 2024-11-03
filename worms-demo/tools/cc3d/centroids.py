from pathlib import Path
import pickle

import cc3d
import numpy as np
import click

@click.command()
@click.option("--input_file", default="output/data.npy", help="The input file path")
@click.option("--output_dir", default="output/", help="The output directory file path")
@click.option("--connectivity", default=6, help="only 4,8 (2D) and 26, 18, and 6 (3D) are allowed")
@click.option("--threshold", default=100, help="Removes objects with fewer than `threshold` voxels.")
def generate_centroids(input_file, output_dir, connectivity, threshold):
    vol = np.load(input_file)
    labels = cc3d.dust(vol, connectivity=connectivity, threshold=threshold)
    stats = cc3d.statistics(labels)

    out_dir = Path(output_dir)
    out_dir.mkdir(exist_ok=True, parents=True)

    # with open(out_dir/"tagouts.txt",'w') as f:
    #     print('I AM CENTROID!!!!!',file=f)

    # with open(out_dir/"annotations.pkl", 'wb') as pkl:
    #     pickle.dump(stats, pkl) # JPN added labels to save

    # with open(out_dir/"labels.pkl", 'wb') as pkl:
    #     pickle.dump(labels, pkl) # JPN added labels to save


    with open(out_dir/"annotations.pkl", 'wb') as pkl:
        pickle.dump([stats,labels], pkl) # JPN added labels to save

if __name__ == '__main__':
    generate_centroids()