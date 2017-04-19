import cv2
import numpy
import argparse
import pickle
import os, sys


# manage cli args
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=True, help="Path to the image for histogram creation")
args = vars(ap.parse_args())

# bin size
num_bins = [8, 8, 8]

# return one dimensional rgb & hsv histograms of image
def create_histograms(image_path):
	# load image & create hsv version
	image_rgb = cv2.imread(image_path)
	image_hsv = cv2.cvtColor(image_rgb, cv2.COLOR_BGR2HSV)
	
	# compute 3D RGB & HSV histogram
	hist_rgb = cv2.calcHist([image_rgb], [0, 1, 2], None, num_bins, [0, 256, 0, 256, 0, 256])
	hist_hsv = cv2.calcHist([image_hsv], [0, 1, 2], None, num_bins, [0, 256, 0, 256, 0, 256])
	# normalise so scaled images will have similar histograms
	hist_rgb = cv2.normalize(hist_rgb, hist_rgb)
	hist_hsv = cv2.normalize(hist_hsv, hist_hsv)
	
	# flatten histograms to 1D
	hist_flat = [hist_rgb.flatten(), hist_hsv.flatten()]
	return hist_flat


# write histogram to file
def save_histograms(histograms, original_image_path):
	# get path & name for new stored histogram file
	base_name = os.path.basename(original_image_path)
	file_name = os.path.splitext(base_name)[0]
	file_path = os.path.dirname(original_image_path)
	
	new_file_rgb = file_path + "/" + file_name + "_rgb.histo"
	new_file_hsv = file_path + "/" + file_name + "_hsv.histo"
	new_files = [new_file_rgb, new_file_hsv]
	
	# save histograms to new files
	for i, name in enumerate(new_files):
		f = open(name, "wb")
		f.write(pickle.dumps(histograms[i]))
		f.close()
	
	return new_files


# create histogram of image & save to file
histograms = create_histograms(args["image"])
new_file_names = save_histograms(histograms, args["image"])


print("\n> Histogram files successfully created: \n" + '\n'.join(new_file_names))
