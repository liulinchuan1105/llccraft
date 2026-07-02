#!/usr/bin/env python3
"""Push key with REAL password."""
import os, time, sys, pathlib
from winpty import PtyProcess

PUBKEY_PATH = pathlib.Path(os.path.expanduser('~/.ssh/llccraft_sg.pub'))
pkey = PUBKEY_PATH.read_text().strip()

REMOTE = (
    'mkdir -p ~/.ssh && '
    'chmod 700 ~/.ssh && '
    f"(umask 077; printf '%s\n' {pkey!r} >> ~/.ssh/authorized_keys) && "
    'chmod 600 ~/.ssh/authorized_keys && '
    'sort -u ~/.ssh/authorized_keys -o ~/.ssh/authorized_keys && '
    'wc -l ~/.ssh/authorized_keys && '
    'echo __KEY_PUSHED_OK__'
)

cmd = [
    'ssh', '-tt',
    '-o', 'StrictHostKeyChecking=no',
    '-o', 'UserKnownHostsFile=/dev/null',
    '-o', 'PreferredAuthentications=password',
    '-o', 'PubkeyAuthentication=no',
    '-o', 'NumberOfPasswordPrompts=1',
    'root@8.219.190.222',
    REMOTE,
]

p = PtyProcess.spawn(cmd, dimensions=(40, 120))
buf = ''
start = time.time()
saw_pwd = sent_pwd = saw_ok = saw_denied = False
while time.time() - start < 25:
    try:
        data = p.read(2048)
        if not data:
            time.sleep(0.2)
            continue
        # only print non-escape for cleanliness
        clean = ''.join(c for c in data if c.isprintable() or c in '\r\n')
        if clean.strip():
            print('SSH>', clean.rstrip())
        buf += data
        if 'password:' in buf.lower() and not sent_pwd:
            print('>>> sending password...')
            p.write(os.environ['SSH_PASSWORD'] + '\r')
            sent_pwd = True
            buf = ''
        if '__KEY_PUSHED_OK__' in buf:
            saw_ok = True
            break
        if 'denied' in buf.lower() or 'Permission denied' in buf:
            saw_denied = True
            break
    except Exception as e:
        print(f'>>> ex: {type(e).__name__} {e}')
        break

if saw_ok:
    print('✅ KEY PUSHED OK')
    p.write('exit\r')
elif saw_denied:
    print('❌ PASSWORD DENIED')
else:
    print('⚠️ TIMEOUT')

time.sleep(0.5)
try: p.terminate()
except: pass
sys.exit(0 if saw_ok else 1)
