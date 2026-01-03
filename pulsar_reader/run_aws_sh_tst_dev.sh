#!/bin/bash
python3.12 reader.py --pulsar-url pulsar+ssl://mqe.tuyaeu.com:7285 \
                     --client-id ujxufudmaa9ijajni8u6 \
                     --client-secret 8dbe14a9ae3446bf8d60e7183b6b99e8 \
                     --topic ujxufudmaa9ijajni8u6/out/event \
                     --start-message-id earliest \
                     --regex "$1"
