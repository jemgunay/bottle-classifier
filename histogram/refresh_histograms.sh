#!/bin/bash
for f in ./histogram_data/*.jpg; do python3 create_histogram.py -i $f; done
