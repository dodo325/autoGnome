#!/usr/bin/env python
"""
Этот модуль создаёт bash файлы. 
"""

import logging
import argparse
import os
import json
import shutil
import sys
logging.basicConfig(level=logging.INFO)

import inquirer

def arg_parse() -> dict:
    ''' arg_parse() -> dict
    Parse arguments grom cli using argparse. 
    '''

    logging.debug(f'[arg_parse] init')
    parser = argparse.ArgumentParser(
        description=sys.modules[__name__].__doc__)

    # scripts_dir
    parser.add_argument("-s", "--scripts-dir", type=str, default=None,
                        help="path to Scripts\ dir")
    parser.add_argument("-d", "--build-dir", type=str, default=None,
                        help="path to Scripts\ dir")
                        # scripts_names
    parser.add_argument('-n','--scripts-names', nargs='+', help='Set scripts_names', required=False)
    
    args = vars(parser.parse_args())
    logging.info(f'[arg_parse] args= {args}') 
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

def get_path_local(path: str):
    return os.path.abspath(os.path.abspath(os.path.dirname(__file__))+"/"+path) #-> src_dir + Scrips
     

def get_subdirs_list(path: str):
    return [dI for dI in os.listdir(path) if os.path.isdir(os.path.join(path,dI))]

def get_scripts_list(scripts_dir: str = None) -> dict:
    if not scripts_dir:
        scripts_dir = get_path_local("../Scripts")
    
    logging.debug(f"[get_scripts_list] scripts_dir = {scripts_dir}")
    
    subdirs = get_subdirs_list(scripts_dir)
    sctipts = dict()
    for subdir in subdirs:
        try:
            with open(scripts_dir+'/'+subdir+'/info.json') as json_file:
                sctipts[subdir] = json.load(json_file)
        except FileNotFoundError as e:
            logging.warning(f'[get_sctipts_list] {e}')
    logging.debug(f"[get_scripts_list] sctipts = {sctipts}")
    return sctipts

def get_all_tags(scripts):
    tags = set()
    for name, data in scripts.items():
        tags.update(data['tags'])
    return tags

def get_scripts_dependences_order(scripts: dict, scripts_names: list):
    graph = dict()
    for name, data in scripts.items():
        graph[name] = data['dependence']
    
    scripts_dependences = []
    for name in scripts_names:
        script_dependences = recursive_topological_sort(graph, name)
        for scripts_dependence in script_dependences:
            if scripts_dependence not in scripts_dependences:
                scripts_dependences.append(scripts_dependence)
    return scripts_dependences


def collect_scripts(scripts_names: list, scripts: dict, build_dir: str = None) -> None:

    logging.debug(f"[collect_scripts] names = {scripts_names}")
    scripts_dependences = get_scripts_dependences_order(scripts, scripts_names)
    header = get_path_local("../Scripts/header.sh")

    
    if not build_dir:
        build_dir = get_path_local("../../build/")         
    
    if not build_dir.endswith("/"):
            build_dir += "/"
    build_file = build_dir + "install.sh"
     
    
    build_dirf = open(build_file, "a") #a
    build_dirf.write("")
    
    headerf = open(header, "r")
    build_dirf.write(headerf.read())
    build_dirf.write("\n")
    headerf.close()
    
    for script in scripts_dependences:
        logging.info(f"[collect_scripts] script = {script}")

        install_dir = get_path_local("../Scripts")+'/'+script+'/'
        install_file = install_dir + scripts[script]['installers']['default']
        install_filef = open(install_file, "r")
        
        logging.debug(f"[collect_scripts] install_file = {install_file}")
        build_dirf.write("\n")
        build_dirf.write(install_filef.read())
        
        res_dir = install_dir + "res/"
        if os.path.isdir(res_dir):
            try:
                destination = shutil.copytree(res_dir, build_dir + "res/", copy_function = shutil.copy)  
            except Exception as e:
                logging.warning(f"[collect_scripts] {e}")
    build_dirf.close()

if __name__ == "__main__":
    global args
    args = arg_parse()
    scripts = get_scripts_list(scripts_dir=args['scripts_dir'])
    
    if not args['scripts_names']:
        questions = [inquirer.Checkbox(
            'scripts_names',
            message="What do you want to install?",
            choices=scripts.keys(),
        )]
        answers = inquirer.prompt(questions) 
        args['scripts_names'] = answers['scripts_names']
    collect_scripts(
        scripts_names = args['scripts_names'], 
        scripts = scripts, 
        build_dir = args['build_dir'],
    )


  