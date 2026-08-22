import os
import sys

def escape(s):
    temp = "".join(c for c in s if ord(c) < 127)
    return temp.replace("'", "''")

if __name__ == '__main__':
    os.system('''PowerShell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('{}');'''.format(escape(sys.argv[1])))
