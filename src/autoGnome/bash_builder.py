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
                result.append(neighbor)
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
        result.insert(0, node)

    recursive_helper(node)
    return result[::-1]

def get_fils_list(path):
    pass

def get_path(filename):
    fpath = os.path.dirname(os.path.abspath(filename + '/' + __file__)) #-> src_dir + Scrips
    #fpath = os.path.abspath(filename)
    return fpath

def get_subdirs_list(path):
    return [dI for dI in os.listdir(path) if os.path.isdir(os.path.join(path,dI))]

def get_scripts_list() -> dict:
    script_dir = get_path("Scripts")
    subdirs = get_subdirs_list(script_dir)
    sctipts = dict()
    for subdir in subdirs:
        try:
            with open(script_dir+'/'+subdir+'/info.json') as json_file:
                sctipts[subdir] = json.load(json_file)
        except FileNotFoundError as e:
            logging.warning(f'[get_sctipts_list] {e}')
    return sctipts

def get_all_tags(scripts):
    tags = set()
    for name, data in scripts.items():
        tags.update(data['tags'])
    return tags

def get_scripts_dependences_order(scripts, scripts_name):
    graph = dict()
    for name, data in scripts.items():
        graph[name] = data['dependence']
    
    scripts_dependences = []
    for name in scripts_name:
        script_dependences = recursive_topological_sort(graph, name)
        for scripts_dependence in script_dependences:
            if scripts_dependence not in scripts_dependences:
                scripts_dependences.append(scripts_dependence)
    return scripts_dependences


def collect_scripts(names: list, scripts: dict, build_dir: str = None) -> None:
    logging.debug(f"[collect_scripts] names = {names}")
    scripts_dependences = get_scripts_dependences_order(names, scripts)
    header = get_path("../Scripts/header.sh")

    if not build_dir:
        build_dir = get_path("../../build/install.sh")
    
    headerf = open(header, "r")
    build_dirf = open(build_dir, "w")
    build_dirf.write("")
    build_dirf.close()

    build_dirf = open(build_dir, "a") #a
    build_dirf.write(headerf.read())
    build_dirf.write("\n")
    headerf.close()
    
    for script in scripts_dependences:
        logging.debug(f"[collect_scripts] script = {script}")
        install_file = get_path("../Scripts")+'/'+script+'/'+scripts[script]['installers']['default']
        install_filef = open(install_file, "r")
        logging.debug(f"[collect_scripts] install_file = {install_file}")
        build_dirf.write("\n")
        build_dirf.write(install_filef.read())
    
    build_dirf.close()

def main():
    global args
    args = arg_parse()

if __name__ == "__main__":
  main()


  