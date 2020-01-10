#!/usr/bin/env python
"""
Этот модуль создаёт bash файлы. 
"""

import logging
import argparse
import os
import json
logging.basicConfig(level=logging.INFO)

def arg_parse():
    ''' arg_parse() -> dict
    Parse arguments grom cli using argparse. 
    '''

    logging.info(f'[arg_parse] init')
    parser = argparse.ArgumentParser(
        description=sys.modules[__name__].__doc__)

    return args

def get_fils_list(path):
    pass

def get_subdirs_list(path):
    return [dI for dI in os.listdir(path) if os.path.isdir(os.path.join(path,dI))]

def get_scrips_list() -> dict:
    subdirs = get_subdirs_list("../Scripts")
    sctips = dict()
    for subdir in subdirs:
        try:
            with open('../Scripts/'+subdir+'/info.json') as json_file:
                sctips[subdir] = json.load(json_file)
        except FileNotFoundError as e:
            logging.warning(f'[get_scrips_list] {e}')
    return sctips

def main():
    global args
    args = arg_parse()

if __name__ == "__main__":
  main()


  