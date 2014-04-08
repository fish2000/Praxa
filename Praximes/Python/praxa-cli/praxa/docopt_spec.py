"""Naval Fate.

Usage:
  naval_fate.py ship new <name>...
  naval_fate.py ship <name> move <x> <y> [--speed=<kn>]
  naval_fate.py ship shoot <x> <y>
  naval_fate.py mine (set|remove) <x> <y> [--moored | --drifting]
  naval_fate.py (-h | --help)
  naval_fate.py --version

Options:
  -h --help     Show this screen.
  --version     Show version.
  --speed=<kn>  Speed in knots [default: 10].
  --moored      Moored (anchored) mine.
  --drifting    Drifting mine.

"""


"""VX - the VirtualEnv Executor

Usage:
    vx exec [--venv=<ENV-NAME>] [COMMAND ...]
    vx work [--venv=<ENV-NAME>]
    vx quit
    
    vx list [--envs | --praxons | --pids | --modules | --all]
    vx status
    
    vx fashion <NEW-ENV-NAME> [--merge=<git-repo>]
                              [--use=<praxon>]...
                              [--eschew=<praxon>]...
    vx merge <MERGEE> <git-repo>
    vx split <SPLITEE> <PYTHON-MODULE> [--path=<where-to>]
    vx destroy <CONDEMNED-ENV-NAME>
    
    vx env
    vx env dump (--pid | --file | --raw-json) <where-to>
    vx env load (--pid | --file | --raw-json) <from-whence>
    
    

Options:
    -h --help       Show this screen.
    --version       Show version.
    --file          Dump or load environment vars from a file
    --pid           Dump or load env vars using file storage for this PID [default: current]
    --file          Dump or load env vars to a named file
    --raw-json      Dump or load env vars to a raw JSON string (dumps use stdout)
    --venv=<ENV>    VirtualEnv in which to execute [default: current]

"""