
#import sys
#from __future__ import print_function

with open('/var/log/daily.out', 'r') as daily:
    ln = daily.readline()
    while ln:
        if ln.startswith('Removing old temporary files') or ('/tmp/' in ln):
            #print(ln, file=sys.stdout, end='')
            print ln
        ln = daily.readline()
        
