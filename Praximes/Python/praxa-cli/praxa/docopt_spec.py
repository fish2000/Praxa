"""

VX - the VirtualEnv Executor

Usage:
    vx exec [--venv=<name>] [--] COMMAND [COMMAND]...
    vx work [--venv=<name>]
    vx quit
    
    vx list [--envs | --praxons | --pids | --modules | --all]
    vx status
    
    vx fashion <new-env-name> [--merge=<git-repo>]
                              [--use=<praxon>]...
                              [--eschew=<praxon>]...
    vx merge <mergee-name> <git-repo>
    vx split <splitee-name> <python-module> [--path=<where-to>]
    vx destroy <condemned-env-name>
    
    vx env
    vx env (dump | load) [--pid=<pid> | --file=<path> | (- | --raw-json=<json>)]
    
    vx run
    vx run  [--develop | --deploy]
            [--uwsgi | --gunicorn]
            [--supervisord | --honcho]
            [--port=<port>]
            [--bind=<ip-address>]...
    

General Options:
    -h --help               Show this screen.
    -v --version            Show version and exit.
    -V --verbose            Be verbose (print warnings).
    -VV --scintillate       Be extra-verbose (print extra info traces).
    -VVV --loquate          Be super-extra-verbose (print debug-level traces).
    -VVVV --bloviate        Be obnoxiously, ceaselessly chatty (debug traces plus giant raw dumps).

Runtime Options:
    --venv=ENV              VirtualEnv in which to execute [default: current].

Environment Serialization Options:
    --pid=PID               Dump or load env vars using file storage for this PID [default: current].
    --file=PATH             Dump or load env vars to a named file.
    --raw-json=JSON         Dump or load env vars to a raw JSON string [default: stdio].

List Options:
    -e --envs               List available virtualenvs.
    -p --praxons            List available praxons, per-category.
    -P --pids               List known process IDs with serialzed env data.
    -m --modules            List all python modules in the current virtualenv.
    -a --all                List everything (all of the above) for all available virtualenvs.

Web App Service Options:
    -d --develop            Run web app in development mode (the default).
    -D --deploy             Run web app in deploy mode.
    --uwsgi                 Serve web app over HTTP with uWSGI.
    --gunicorn              Serve web app over HTTP with gunicorn.
    --port=PORT             Bind web app HTTP endpoint to a TCP socket port [default: 8000].
    --bind=IPADDRESS        Bind web app HTTP endpoint to an IP address [default: 0.0.0.0].


"""