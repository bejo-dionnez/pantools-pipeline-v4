"""
Contains setup logic and common functions for other Snakemake rules.
"""

import sys
import tempfile

# Set pantools command with Java heap space.
if config['jar']:
    pantools = "java -Xms{}g -Xmx{}g -jar {}".format(config['Xms'], config['Xmx'], config['jar'])
else:
    pantools = "pantools -Xms{}g -Xmx{}g".format(config['Xms'], config['Xmx'])

# Set the temporary directory based on system default or given path.
temp = config['scratch'] if config['scratch'] else tempfile.gettempdir()
temp_dir = tempfile.TemporaryDirectory(dir = temp).name

# Gives needed input for functions that use proteins depending on db type.
def proteins_done(db_type):
    if (db_type == 'pangenome'):
        return("{results}/done/pangenome.add_annotations.done")
    else: 
        return("{results}/done/panproteome.build_panproteome.done")