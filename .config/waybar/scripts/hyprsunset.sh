#!/bin/bash

if pgrep -x "hyprsunset" > /dev/null
then
    # Se estiver rodando, desliga
    pkill hyprsunset
else
    # Se não estiver rodando, liga com a temperatura desejada
    hyprsunset -t 3400 &
fi
