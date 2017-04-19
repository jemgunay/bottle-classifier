import cv2
import numpy
import argparse
import pickle
import os, sys
import histogram


# manage cli args
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=True, help="Path to the image for histogram creation")
args = vars(ap.parse_args())

# load image, create histogram of image & save to file
image_rgb = cv2.imread(args["image"])
histograms = histogram.create_histograms(image_rgb)
new_file_names = histogram.save_histograms(histograms, args["image"])

# output file names
print("\n> Histogram files successfully created: \n" + '\n'.join(new_file_names))
