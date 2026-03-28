#!/bin/bash

song_info=$(playerctl metadata --format '󰎆 Música Tocando: {{title}} - {{artist}}')

echo "$song_info" 