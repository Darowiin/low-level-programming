import subprocess

exe_path = 'easy_1.2.exe'

params = b" "*32 + b"\x53\x41\x42\x49"

process = subprocess.Popen(
    exe_path,
    stdin=subprocess.PIPE
)

stdout = process.communicate(input=params)