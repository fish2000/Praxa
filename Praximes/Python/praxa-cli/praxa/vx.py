
from __future__ import print_function

from clint import resources
from os import getenv, pathsep as PATHSEP
from argh import arg, command, named, ArghParser

import re
import six
import json

andand = re.compile(r"\s+&&\s+")

def _path_to_tuple(path_var, unique=True):
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
    
    # Tuple-ize without stripping duplicates
    if not unique:
        return tuple(path_var.split(PATHSEP))
    
    # The main deal -- for an explanation of this technique, see also:
    # http://stackoverflow.com/a/480227/298171
    seen = set()
    seen_add = seen.add
    return (directory for directory in path_var.split(PATHSEP) \
        if directory not in seen and \
            not seen_add(directory))

def _sequence_to_path(seq):
    return PATHSEP.join(seq)

def _current_env_to_dict(env_alt={}):
    from os import environ
    env = env_alt or dict(environ)
    return dict(zip(
        env.keys(),
        map(lambda env_value: PATHSEP in env_value and _path_to_tuple(env_value) or env_value,
            env.values())))

def _dict_to_env_commands(env_dict, dry_run=False):
    env = dict(zip(
        env_dict.keys(),
        map(lambda val: type(val) in six.string_types and val or _sequence_to_path(val),
            env_dict.values())))
    return u";\\\n".join(['export %s="%s"' % (k, v) for k, v in env.items()])


@arg('--path', '-D', default=None)
@arg('--pid', '-P', default=None)
@arg('--with-json', '-J', default=None)
def dump(**kwargs):
    """ Dump environment (or an arbitrary JSON string) out to a file
        with the PID in the name """
    from os import getpid
    from os.path import isdir, join
    
    if kwargs['with-json'] is not None:
        try:
            from_json = json.loads(kwargs['with-json'])
        except ValueError:
            from_json = {}
    env_dict = _current_env_to_dict(from_json)
    
    pth = kwargs.get('path') or resources.user.path
    if not isdir(pth):
        raise ValueError("Can't dump into invalid directory: %s" % pth)
    
    filename = 'env.%s.%d.json' % (
        getenv('INSTANCE_NAME', "Praxa"),
        kwargs.get('pid', getpid()))
    
    if not kwargs.get('path'):
        resources.user.write(
            filename,
            json.dumps(env_dict, indent=4))
        return
    
    dump_path = join(pth, filename)
    with open(dump_path, 'wb') as handle:
        json.dump(handle, env_dict, indent=4)
        return

@arg('--path', '-D', default=None)
@arg('--pid', '-P', default=None)
@arg('--with-json', '-J', default=None)
def load(**kwargs):
    """ Load most recent environment (or an arbitrary JSON string)
        from a previously dumped file -- we expect the PID
        in the file name """
    from os import getpid
    from os.path import isdir, join
    
    pth = kwargs.get('path') or resources.user.path
    if not isdir(pth):
        raise ValueError("Can't dump into invalid directory: %s" % pth)
    
    filename = 'env.%s.%d.json' % (
        getenv('INSTANCE_NAME', "Praxa"),
        kwargs.get('pid', getpid()))
    
    if kwargs['with-json'] is not None:
        pth = kwargs.get('path') or resources.user.path
        load_path = join(pth, filename)
        with open(load_path, 'rb') as handle:
            load_json = handle.read()
    else:
        load_json = kwargs['with-json']
    
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
@arg('cmd', nargs='+', default=None,
    help="Command to execute")
@named('exec')
@command
def vexec(venv=None, *cmd):
    import subprocess
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
    arguments = list(argv)
    parser = ArghParser()
    parser.add_commands([dump, load], namespace="env",
        title="Environment Manipulation")
    parser.add_commands([vexec]) # the default
    
    if len(arguments):
        if arguments[0] not in ('dump', 'load', 'exec'):
            arguments.insert(0, 'exec')
    
    parser.dispatch(argv=arguments)
    return 0

if __name__ == '__main__':
    # import sys
    # sys.exit(main(*sys.argv[1:]))
    # main('--venv', 'TESSAR', 'ls', '-la')
    main('--venv', 'TESSAR', 'ls', '..')