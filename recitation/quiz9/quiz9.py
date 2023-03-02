#!/usr/bin/env python3

import re

user_string = input("Please enter a string: ")

list_of_questions = re.findall(r"([\w+\s]*\w+\S\?+)",user_string)

number_of_questions = len(list_of_questions)

if(int(number_of_questions) == 3):
    print("You're entry contains 3 questions!")
else:
    print("You're entry does not contain 3 questions.")
