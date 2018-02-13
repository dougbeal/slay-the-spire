import base64
import json
import sys

#https://gist.github.com/revolunet/2412240
def xor_crypt_string(data, key='key', encode=False, decode=False):
    from itertools import cycle
    import base64
    if decode:
        data = base64.decodestring(data)
    xored = ''.join(chr(ord(x) ^ ord(y)) for (x,y) in zip(data, cycle(key)))
    if encode:
        return base64.encodestring(xored.encode('utf8')).strip()
    return xored

if len(sys.argv) > 1:
    filename = sys.argv[1]
else:
    filename = '/dev/stdin'

with open(filename, 'r') as f:
    encoded = xor_crypt_string(f.read(), encode=True)
    sys.stdout.buffer.write(encoded)
#    with open(filename + ".edit", 'wb') as output:
#        output.write(encoded)
