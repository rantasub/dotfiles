#!/usr/bin/env python2

import subprocess

def _get_pass_output(account):
    return subprocess.check_output('pass Mail/' + account, shell=True)

def get_pass(account):
    return _get_pass_output(account).splitlines()[0]

def get_field(account, field):
    settings = dict(line.split(': ') for line in
                    _get_pass_output(account).splitlines()[1:])

    return settings[field]
