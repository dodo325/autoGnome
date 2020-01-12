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
    return result

def get_fils_list(path):
    pass

def get_subdirs_list(path):
    return [dI for dI in os.listdir(path) if os.path.isdir(os.path.join(path,dI))]

def get_scripts_list() -> dict:
    subdirs = get_subdirs_list("../Scripts")
    sctipts = dict()
    for subdir in subdirs:
        try:
            with open('../Scripts/'+subdir+'/info.json') as json_file:
                sctipts[subdir] = json.load(json_file)
        except FileNotFoundError as e:
            logging.warning(f'[get_sctipts_list] {e}')
    return sctipts

def get_all_tags(scripts):
    tags = set()
    for name, data in scripts.items():
        tags.update(data['tags'])
    return tags

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


  