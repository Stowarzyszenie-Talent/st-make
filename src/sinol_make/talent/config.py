import os
import re

import yaml
from yaml import Dumper

from sinol_make import util
from sinol_make.helpers import package_util
from sinol_make.talent import user_util


def read_config():
    try:
        with open(os.path.join(os.getcwd(), "talent.yml")) as config_file:
            config = yaml.load(config_file, Loader=yaml.FullLoader)
            return config
    except FileNotFoundError:
        create_default_config()
        util.exit_with_error("No talent config file found. Created default file. Fill it and run the script again.")


def get_current_version():
    config = read_config()
    try:
        if "version" not in config:
            util.exit_with_error("No task version found in config. Fix talent.yml before continuing.")
        history = config["history"][config["version"]]
        user = config["users"][history[0]]
        res = f'{config["version"]}: {history[1]}, by {user[0]}'
        return res
    except KeyError as e:
        util.exit_with_error("Config not filled correctly: expected \"" + e.args[0] + "\" field")


# https://stackoverflow.com/questions/14228915/formatting-pyyaml-dump-output/44284819#44284819
class BeautifullyDumper(Dumper):
    def write_indent(self):
        indent = self.indent or 0
        if not self.indention or self.column > indent \
                or (self.column == indent and not self.whitespace):
            self.write_line_break()

        if indent == 0:
            self.write_line_break()

        if self.column < indent:
            self.whitespace = True
            data = u' ' * (indent - self.column)
            self.column = indent
            if self.encoding:
                data = data.encode(self.encoding)
            self.stream.write(data)


def create_new_version():
    config = read_config()
    new_version = ""
    old_version = config["version"]
    old_export = os.path.join(os.getcwd(), f'{package_util.get_task_id()}_stzad_{old_version}.tgz')
    if os.path.isfile(old_export):
        os.remove(old_export)

    try:
        while True:
            print()
            print(util.info("Current version:"))
            print(get_current_version())
            print(util.info("Choose how to update version:"))
            print("Type t to bump major version")
            print("Type m to bump minor version")
            print("Type p to bump patch version")
            option = input("Choose version to update: ")
            old_version = config["version"]
            if option == "t":
                new_version = 'v' + str(int("".join(re.search(r'\d+', old_version).group())) + 1) + '.0.0'
            elif option == "m":
                new_version = old_version.split('.')[0] + '.' + str(int(old_version.split('.')[1]) + 1) + '.0'
            elif option == "p":
                new_version = '.'.join(old_version.split('.')[0:2]) + '.' + str(int(old_version.split('.')[2]) + 1)
            else:
                print(util.error("Invalid value"))
                continue
            config["version"] = new_version
            print(f"New version: {new_version}")
            print()
            description = input("Add description: ")
            if description == "":
                print(util.error("Version description cannot be empty"))
                continue

            user = user_util.get_user_data()
            if user["initials"] not in config["users"]:
                config["users"][user["initials"]] = [user["full_name"], user["email"], user["discord"]]

            config["history"][new_version] = [user["initials"], description]

            with open(os.path.join(os.getcwd(), "talent.yml"), 'w') as config_file:
                yaml.dump(config, config_file, allow_unicode=True, sort_keys=False, default_flow_style=None,
                          Dumper=BeautifullyDumper)
            break

    except KeyboardInterrupt:
        util.exit_with_error("\nInterrupted")
    return new_version


def create_default_config():
    pass
