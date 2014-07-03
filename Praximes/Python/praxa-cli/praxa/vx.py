#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function

from clint import resources
from sys import exit
from os import getpid, getenv, environ
from os import makedirs, pathsep as PATHSEP
from os.path import isdir, exists, join

from argh import arg, command, named, ArghParser
from argparse import REMAINDER

import re
import six
import json
import subprocess

andand = re.compile(r"\s+&&\s+")

def _path_to_tuple(path_var, unique=True, validate=True):
    """ Get a uniquified tuple for a PATH value, as per the typical
        environment-variable representation:
        
        PATH="/dir/subdir/path:/another/dir/subdir/path:/yet/another/dir/path"
        
        ... since PATH-style lists are frequently initialized with recursion,
        i.e. something like:
        
        PATH="/dir/subdir/path:/another/dir/subdir/path:${PATH}"
        
        ... and since the order is significant in these lists, this function
        defaults to preserving the PATH lists' order while stripping
        duplicate entries. """
    # Tuple-ize and return
    if not PATHSEP in path_var:
        return (path_var,)
    
    path_parts = path_var.split(PATHSEP)
    validate_path = validate and exists or (lambda pth: True)
    
    # Tuple-ize without stripping duplicates
    # ... when validate is False, we use a filter function
    # that indiscriminantly returns True
    if not unique:
        return tuple(filter(validate_path, path_parts))
    
    # The main deal -- for an explanation, see:
    # http://stackoverflow.com/a/480227/298171
    seen = set()
    seen_add = seen.add
    return tuple(directory for directory in path_parts \
        if validate_path(directory) and \
            directory not in seen and \
                not seen_add(directory))

def _sequence_to_path(seq):
    return PATHSEP.join(seq)

def _current_env_to_dict(env_alt={}):
    env = env_alt or dict(environ)
    return dict(zip(
        env.keys(),
        map(lambda env_value: PATHSEP in env_value \
                and _path_to_tuple(env_value, validate=True) \
                or env_value,
            env.values())))

def _dict_to_env_commands(env_dict, dry_run=False):
    env = dict(zip(
        env_dict.keys(),
        map(lambda val: type(val) in six.string_types \
                and val \
                or _sequence_to_path(val),
            env_dict.values())))
    return u";\\\n".join(['export %s="%s"' % (k, v) for k, v in env.items()])


@arg('--path', '-D', default=None)
@arg('--pid', '-P', default=None)
@arg('--json', '-J', default=None)
def dump(**kwargs):
    """ Dump environment (or an arbitrary JSON string) out to a file
        with the PID in the name """
    from_json = {}
    if kwargs['json'] is not None:
        try:
            from_json.update(
                json.loads(kwargs['json']))
        except ValueError, err:
            print(err)
    
    env_dict = _current_env_to_dict(from_json)
    # from pprint import pprint
    # pprint(env_dict)
    
    pth = kwargs.get('path') or resources.user.path
    if not isdir(pth):
        raise ValueError("Can't dump into invalid directory: %s" % pth)
    
    filename = 'env.%s.%d.json' % (
        getenv('INSTANCE_NAME', "Praxa"),
        'pid' in kwargs and int(kwargs.get('pid')) or getpid())
    
    if not kwargs.get('path'):
        resources.user.write(
            filename,
            json.dumps(env_dict, indent=4))
        return
    
    dump_path = join(pth, filename)
    with open(dump_path, 'wb') as handle:
        json.dump([env_dict], handle, indent=4)
        return

@arg('--path', '-D', default=None)
@arg('--pid', '-P', default=None)
@arg('--json', '-J', default=None)
def load(**kwargs):
    """ Load most recent environment (or an arbitrary JSON string)
        from a previously dumped file -- we expect the PID
        in the file name """
    pth = kwargs.get('path') or resources.user.path
    if not isdir(pth):
        raise ValueError("Can't load from invalid directory: %s" % pth)
    
    filename = 'env.%s.%d.json' % (
        getenv('INSTANCE_NAME', "Praxa"),
        kwargs.get('pid', getpid()))
    
    if kwargs['json'] is not None:
        pth = kwargs.get('path') or resources.user.path
        load_path = join(pth, filename)
        with open(load_path, 'rb') as handle:
            load_json = handle.read()
    else:
        load_json = kwargs['json']
    
    loaded_dict = json.loads(load_json)
    print(_dict_to_env_commands(loaded_dict))

def _args_to_workon_command(venv, *cmdargs):
    global andand
    cmdblock = u"""
        workon %s && \
        eval %s && \
        deactivate
    """ % (venv, u" ".join(cmdargs))
    out = andand.subn(' && ', cmdblock.strip())
    print(out[0])
    return out[0]

@arg('--venv', '-V',
    default=None,
    help="Name of virtualenv to use (as created with `mkvirtualenv`)")
@arg('command', nargs=1,
    default=None,
    help="Command to execute")
@arg('args', nargs=REMAINDER,
    default=None,
    help="[optional] Arguments to command")
@named('exec')
@command
def vexec(command, *args, **kwargs):
    #command = kwargs.pop('command', None)
    venv = kwargs.pop('venv', None)
    #print(venv)
    cmd = tuple(command) + tuple(args)
    #print(cmd)
    
    if venv is None:
        venv = getenv("INSTANCE_NAME")
    
    if venv == getenv("INSTANCE_NAME"):
        subprocess.call(cmd)
        return
    
    print(subprocess.call([
        '/usr/local/bin/bash', '--login', '-c',
        _args_to_workon_command(venv, *cmd)
    ]))
    return

def main(*argv):
    resources.init("Praxa", getenv('INSTANCE_NAME', "Praxa"))
    if not isdir(resources.user.path):
        makedirs(resources.user.path)
    
    arguments = list(argv)
    parser = ArghParser()
    parser.add_commands([dump, load], namespace="env",
        title="Environment Manipulation")
    parser.add_commands([vexec]) # the default
    
    if len(arguments):
        if arguments[0] not in ('env', 'dump', 'load', 'exec'):
            arguments.insert(0, 'exec')
    
    parser.dispatch(argv=arguments)
    return 0

if __name__ == '__main__':
    # exit(main(*sys.argv[1:]))
    
    #main('--venv', 'TESSAR', 'gls', '-la', '--quote-name', '--no-group', '--color=always')
    #main('--venv', 'TESSAR', 'ls', '..')
    #main('exec', '--venv', 'TESSAR', 'gls', '-la', '--quote-name', '--no-group', '--color=always')
    
    #main('env', 'dump', '--path', '/tmp')
    exit(main('env', 'dump', '--pid', '66666'))



