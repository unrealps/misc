#!/bin/bash
python3.12 reader.py --pulsar-url pulsar+ssl://mqe.tuyaeu.com:7285 \
                     --client-id f7f9e7aqkajqm7j4ax3f \
                     --client-secret efac69ccd3fa4f47a348db68e4a5cf3b \
                     --topic f7f9e7aqkajqm7j4ax3f/out/event \
                     --start-message-id earliest \
                     --regex "$1"
