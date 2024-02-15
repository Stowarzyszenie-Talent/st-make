import os
from time import sleep

import yaml

from sinol_make import util

st_make_config_dir = os.path.expanduser('~/.local/share/st-config/')
user_config_file = os.path.join(st_make_config_dir, 'user.yml')


def has_config_dir():
    if not os.path.exists(st_make_config_dir):
        os.makedirs(st_make_config_dir)


def check_and_set_user_data():
    if not os.path.isfile(user_config_file):
        print(util.warning("No talent user config found. Creating one:"))
        initials = input("Provide your login (ex. jrozek): ")
        full_name = input("Provide your full name: ")
        # TODO: Specify requirements for the email
        email = input("Provide your email address (can be school email): ")
        discord = input("Provide your discord username: ")
        userdata = {
            'initials': initials,
            'full_name': full_name,
            'email': email,
            'discord': discord
        }
        with open(user_config_file, 'w+') as file:
            yaml.dump(userdata, file, allow_unicode=True)
            print(util.info(f"Your data saved at {user_config_file}. You can always edit this later"))
            sleep(1)


def get_user_data():
    check_and_set_user_data()
    with open(user_config_file, 'r') as config:
        return yaml.load(config, Loader=yaml.FullLoader)


def init():
    has_config_dir()
    check_and_set_user_data()
