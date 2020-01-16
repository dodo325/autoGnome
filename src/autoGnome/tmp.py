#!/usr/bin/env python
"""
Этот модуль создаёт bash файлы. 
"""
import logging
logging.basicConfig(level=logging.INFO)


def arg_parse() -> dict:
    ''' Parse arguments grom cli using argparse. '''

    logging.info(f'[arg_parse] init')
    parser = argparse.ArgumentParser(
        description=sys.modules[__name__].__doc__)

    return args

def main():
    global args
    args = arg_parse()

if __name__ == "__main__":
  main()