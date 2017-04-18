import cv2
import numpy
import argparse
import pickle
import os

# manage cli args
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=True, help="Path to the image for histogram creation")
ap.add_argument("-d", "--display", required=False, default=False, help="Display histogram graphically after creation")
args = vars(ap.parse_args())

# bin size
num_bins = [8, 8, 8]

# return one dimensional histogram of image
def create_histogram(image_path):
	image = cv2.imread(image_path)
	# compute 3D RGB histogram
	hist = cv2.calcHist([image], [0, 1, 2], None, num_bins, [0, 256, 0, 256, 0, 256])
	# normalise so scaled images will have similar histograms
	hist = cv2.normalize(hist, hist)
	
	return hist.flatten()


# write histogram to file
def save_histogram(histogram, original_image_path):
	# get path & name for new stored histogram file
	base_name = os.path.basename(original_image_path)
	file_name = os.path.splitext(base_name)[0]
	file_path = os.path.dirname(original_image_path)
	
	new_file = file_path + "/" + file_name + ".histo"
	
	# save histogram to new file
	f = open(new_file, "wb")
	f.write(pickle.dumps(histogram))
	f.close()
	
	return new_file


# create histogram of image & save to file
histogram = create_histogram(args["image"])
new_file_name = save_histogram(histogram, args["image"])

# add to db


print("\n.histo file successfully created: " + new_file_name)
