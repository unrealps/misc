#!/bin/bash
python3.12 reader.py --pulsar-url pulsar+ssl://mqe.tuyaeu.com:7285 \
                     --client-id 9hy9qaj9audub0ihk1zv \
                     --client-secret bfce6cad4d494dc280db6997fb830507 \
                     --topic 9hy9qaj9audub0ihk1zv/out/event \
                     --start-message-id earliest \
                     --regex "$1"
