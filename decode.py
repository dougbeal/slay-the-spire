import base64
import json
import sys

#https://gist.github.com/revolunet/2412240
def xor_crypt_string(data, key='key', encode=False, decode=False):
    from itertools import cycle
    import base64
    if decode:
        data = base64.decodestring(data)
    xored = ''.join(chr(x ^ ord(y)) for (x,y) in zip(data, cycle(key)))
    if encode:
        return base64.encodestring(xored).strip()
    return xored

if len(sys.argv) > 1:
    filename = sys.argv[1]
else:
    filename = '/dev/stdin'

with open(filename, 'r') as f:
    decoded = xor_crypt_string(base64.b64decode(f.read()))
    parsed = json.loads(decoded)
    sys.stdout.write(json.dumps(parsed, indent=4))
