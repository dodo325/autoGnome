#!/usr/bin/env python
"""
Этот модуль создаёт bash файлы. 
"""

import logging
import argparse
import os
import json
import sys
logging.basicConfig(level=logging.INFO)

def arg_parse():
    ''' arg_parse() -> dict
    Parse arguments grom cli using argparse. 
    '''

    logging.info(f'[arg_parse] init')
    parser = argparse.ArgumentParser(
        description=sys.modules[__name__].__doc__)

    return args

def recursive_dfs(graph, node):
    result = []
    seen = set()

    def recursive_helper(node):
        for neighbor in graph[node]:
            if neighbor not in seen:
                result.append(neighbor)     # this line will be replaced below
                seen.add(neighbor)
                recursive_helper(neighbor)

    recursive_helper(node)
    return result

def recursive_topological_sort(graph, node):
    result = []
    seen = set()

    def recursive_helper(node):
        for neighbor in graph[node]:
            if neighbor not in seen:
                seen.add(neighbor)
                recursive_helper(neighbor)
        result.insert(0, node)              # this line replaces the result.append line

    recursive_helper(node)
    return result

def get_fils_list(path):
    pass

def get_path(filename):
    fpath = os.path.abspath(filename)
    return fpath

def collect_scripts():
    scripts = get_scripts_list()
    header = get_path("../Scripts/header.sh")
    build_dir = get_path("../../build/install.sh")
    
    headerf = open(header, "r")
    build_dirf = open(build_dir, "w")
    build_dirf.write("")
    build_dirf.close()

    build_dirf = open(build_dir, "a") #a
    build_dirf.write(headerf.read())
    headerf.close()
    
    for script in scripts.keys():
        files = get_path("../Scripts")+'/'+scripts[script]["name"]+'/'+scripts[script]['installers']['default']
        filesf = open(files, "r")
        build_dirf.write(filesf.read())
    
    build_dirf.close()

def get_subdirs_list(path):
    return [dI for dI in os.listdir(path) if os.path.isdir(os.path.join(path,dI))]

def get_scripts_list() -> dict:
    script_dir = get_path("../Scripts")
    subdirs = get_subdirs_list(script_dir)
    sctipts = dict()
    for subdir in subdirs:
        try:
            with open(script_dir+'/'+subdir+'/info.json') as json_file:
                sctipts[subdir] = json.load(json_file)
        except FileNotFoundError as e:
            logging.warning(f'[get_sctipts_list] {e}')
    return sctipts

def get_script_dependences_order(scripts, script_name):
    graph = dict()
    for name, data in scripts.items():
        graph[name] = data['dependence']
    return recursive_topological_sort(graph, script_name)

def main():
    global args
    args = arg_parse()

if __name__ == "__main__":
  main()


  