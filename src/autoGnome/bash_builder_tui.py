#!/usr/bin/env python
"""
Этот модуль отвечает за TUI
"""
# import urwid
import inquirer
from .bash_builder import get_scripts_list, collect_scripts
questions = [inquirer.Checkbox(
    'interests',
    message="What are you interested in?",
    choices=['Computers', 'Books', 'Science', 'Nature', 'Fantasy', 'History'],
)]
answers = inquirer.prompt(questions)  # returns a dict
print(answers['interests']) 