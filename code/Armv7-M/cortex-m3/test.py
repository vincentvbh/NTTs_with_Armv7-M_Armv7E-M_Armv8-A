#!/usr/bin/env python3

import datetime
import subprocess
import sys
from os.path import exists

import serial
import numpy as np
from config import Settings

testType = "test"
iterations = 1
ntests = 10
schemeList = ["lightsaber", "saber", "firesaber"]
impleList = ["speed", "speedstack", "stack", "ref"]
cpu = "m3"


def getBinary(scheme, impl):
    return f"elf/crypto_kem_{scheme}_{impl}_{testType}.elf"

def getFlash(binary):
    return f"openocd -f nucleo-f2.cfg -c \"program {binary} reset exit\" "

def makeAll():
    subprocess.check_call(f"make clean", shell=True)
    subprocess.check_call(f"make -j8 ITERATIONS={iterations}", shell=True)

def test(scheme, impl):
    binary = getBinary(scheme, impl)

    if exists(binary) == 0:
        print(f"skip {binary}")
        return 0

    try:
        subprocess.check_call(getFlash(binary), shell=True)
    except:
        print("st-flash failed --> retry")
        return test(scheme, impl)

    with serial.Serial(Settings.SERIAL_DEVICE, Settings.BAUD_RATE, timeout=10) as dev:
        log = b""

        while True:
            device_output = dev.read()
            if device_output == b'':
                print("timeout --> retry")
                return test(scheme, impl)
            sys.stdout.buffer.write(device_output)
            sys.stdout.flush()
            log += device_output
            if device_output == b'#':
                break

    log = log.decode(errors="ignore")
    assert log.count("ERROR") == 0 and log.count("OK") == ntests


makeAll()

for scheme in schemeList:
    for imple in impleList:
        test(scheme, cpu + imple)


