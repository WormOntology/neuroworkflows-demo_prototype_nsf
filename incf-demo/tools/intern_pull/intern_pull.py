#!../../../venv/bin/python
import click
import numpy as np
from intern import array
from pathlib import Path

# python intern_export.py bossdb://Kasthuri/ac4/em --x_rng 0,1024 --y_rng 0,1024 --z_rng 0,100 --res 0 --token $(TOKEN) --output_file data.npy


def parse_comma_separated(ctx, param, value):
    if value is None:
        return []
    try:
        return [int(item.strip()) for item in value.split(",")]
    except ValueError:
        raise click.BadParameter("Invalid comma-separated list of integers")


@click.command()
@click.option("--bossdb_uri", required=True, help="The URI for BossDB")
@click.option(
    "--x_rng",
    required=True,
    type=click.STRING,
    callback=parse_comma_separated,
    help="The x range of the region of interest",
)
@click.option(
    "--y_rng",
    required=True,
    type=click.STRING,
    callback=parse_comma_separated,
    help="The y range of the region of interest",
)
@click.option(
    "--z_rng",
    required=True,
    type=click.STRING,
    callback=parse_comma_separated,
    help="The z range of the region of interest",
)
@click.option("--res", default=0, help="The desired resolution")
@click.option("--token", default="public", help="The personal BossDB access token")
@click.option("--output_dir", default="output/", help="The output directory file path")
def intern_pull(bossdb_uri, x_rng, y_rng, z_rng, res, token, output_dir):
    config = {
        "protocol": "https",
        "host": "api.bossdb.io",
        "token": token,
    }

    # Save a cutout to a numpy array in ZYX order:
    em = array(bossdb_uri, boss_config=config, resolution=res)
    print(x_rng, y_rng, z_rng)

    # TODO: Fix this bug?
    data = em[z_rng[0]:z_rng[1], y_rng[0]:y_rng[1], x_rng[0]:x_rng[1]]

    # Save data to output file
    out_dir = Path(output_dir)
    out_dir.mkdir(exist_ok=True, parents=True)
    np.save(out_dir / "data.npy", data)


if __name__ == "__main__":
    intern_pull()
