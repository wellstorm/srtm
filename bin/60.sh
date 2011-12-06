#!/bin/bash
find ../hgt.txt/ -name "*.hgt.txt" -exec  ruby -I../lib ../lib/60.rb  -o ../json \{\} \; 
