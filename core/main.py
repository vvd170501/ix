import sys
import profile
import importlib


CLIS = [
    ('core.realm_cmd', 'realm_add', False),
    ('core.realm_cmd', 'realm_remove', False),
    ('core.realm_cmd', 'realm_upgrade', False),
    ('core.realm_cmd', 'realm_list', False),
    ('core.realm_cmd', 'realm_purge', False),
    ('core.build_cmd', 'build', False),

    ('core.gc_cmd', 'gc', False),
    ('core.sh_cmd', 'sh', True),

    ('core.cache_cmd', 'cache_all', True),
    ('core.cache_cmd', 'cache_url', True),
    ('core.cache_cmd', 'cache_upload', True),

    ('core.misc_cmd', 'misc_tar', True),
    ('core.misc_cmd', 'misc_untar', True),
    ('core.misc_cmd', 'misc_runpy', True),
    ('core.misc_cmd', 'misc_unzip', True),
    ('core.misc_cmd', 'misc_fetch', True),
]


def find_handler(args):
    sent = '$$'
    xargs = sent.join(args)

    for k, v, _ in CLIS:
        vv = v.replace('_', sent)

        if xargs.startswith(vv):
            a = xargs[len(vv):].split(sent)

            while a and a[0] == '':
                a = a[1:]

            return k, v, a


def print_help():
    print('usage: mix <command>:')

    for k, v, hide in CLIS:
        if not hide:
            print('    ' + v.replace('_', ' '))


def main(args, binary):
    hndl = find_handler(args)

    if not hndl:
        print_help()
        sys.exit(0)

    k, v, a = hndl

    ctx = {
        'args': a,
        'binary': binary,
    }

    def run():
        importlib.import_module(k).__dict__['cli_' + v](ctx)

    #profile.runctx('run()', locals(), globals())
    run()
