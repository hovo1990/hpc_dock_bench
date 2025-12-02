"""
AUTHOR: HOVAKIM GRABSKI
PURPOSE: Join tables using pandas
DATE: 2023-04-12
"""
# %%
import gc
import gzip
import os
import pathlib
import re
import sys
import zipfile
from unicodedata import normalize

import click
import fs
import matplotlib as mpl
import matplotlib.cm as cm
import matplotlib.pyplot as plt
import mpire
import numpy as np
import pandas as pd
import seaborn as sns
from loguru import logger
from mpire import WorkerPool

# %%
# -- ? Import libraries
# %matplotlib inline
from tqdm.auto import tqdm, trange

# %%
# -- ? print import statements
logger.info("Python: {}".format(sys.version))
logger.info("Numpy: {}".format(np.__version__))
logger.info("Matplotlib: {}".format(mpl.__version__))
logger.info("pandas: {}".format(pd.__version__))


# %%
@click.command()
@click.argument("inputs", nargs=-1)
@click.option(
    "-o", "--output", help="Output to a bsv table or any other format", required=True
)
@click.option(
    "-n",
    "--cpus",
    default=os.cpu_count(),
    type=int,
    help="number of cpu cores on the machine",
)
def join_tables(inputs, output, cpus):
    logger.info(" Info> inputs are {}".format(inputs))
    logger.info(" Info> output parquet is {}".format(output))
    logger.info(" Info> Number of cpu cores on the machine are {}".format(cpus))
    test = 1

    try:
        li = []

        for i in inputs:
            suffix = pathlib.Path(i).suffix
            logger.info(" Info> reading {}, suffix is {}".format(i, suffix))
            if suffix == ".bsv":
                df = pd.read_csv(i, sep="|")
            elif suffix == ".csv":
                df = pd.read_csv(i, sep=",")
            li.append(df)
        frame = pd.concat(li, axis=0, ignore_index=True)
    except Exception as e:
        logger.warning(" Error> could not read table files due to {}".format(e))
        exit(1)

    test = 1

    # -- * Now store file
    try:
        logger.info(" Info> Write table to a file")
        frame.to_csv(output, sep=",", index=False)
        exit(0)
    except Exception as e:
        logger.warning(
            " Error> Saving process table to file has failed sepukku time! {}".format(e)
        )
        exit(1)

    # # -- len(toKeep.input.unique())


# %%
if __name__ == "__main__":
    join_tables()
