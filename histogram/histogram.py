import numpy as np
import argparse
import pickle
import cv2
import os, sys

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/database")
import db


# histogram bin size (RGB/HSV)
num_bins = [8, 8, 8]


def match_histogram(roi, classifier_id, histogram_type):
	# create both histograms for ROI
	query = create_histograms(roi)
	# choose from either the RGB or HSV histogram
	query_histogram = query[0]
	if histogram_type == "HSV":
		query_histogram = query[1]
	
	# get and index pre-generated histograms associated with current classifier
	histograms = db.get_histograms(classifier_id)
	index = {}
	for hist in histograms:
		# populate index dict with decoded candidate histograms
		hist_path = hist.rgb_path
		if histogram_type == "HSV":
			hist_path = hist.hsv_path
		# key : val = histogram_id : flattened histogram
		hist_path = os.path.join(os.path.dirname(__file__), hist_path)
		index[hist] = pickle.loads(open(hist_path, "rb").read())


	# perform search
	results = search(query_histogram, index)
	# return closest match (as peewee object)
	return results[0][1]
	
	

# search
def search(queryFeatures, index):
	results = {}
	
	for (k, features) in index.items():
		# compute chi-squared distance
		d = chi2_distance(features, queryFeatures)
		
		# update results dict
		results[k] = d	
	
	# sort results into closest match first
	results = sorted([v, k] for (k, v) in results.items())

	return results


# apply distance metric
def chi2_distance(histA, histB, eps = 1e-10):
	# compute chi-squared
	d = 0.5 * np.sum([((a - b) ** 2) / (a + b + eps) for (a, b) in zip(histA, histB)])
	
	return d
	


# return one dimensional rgb & hsv histograms of image
def create_histograms(image_rgb):
	# create hsv version
	image_hsv = cv2.cvtColor(image_rgb, cv2.COLOR_BGR2HSV)
	
	# compute 3D RGB & HSV histogram
	hist_rgb = cv2.calcHist([image_rgb], [0, 1, 2], None, num_bins, [0, 256, 0, 256, 0, 256])
	hist_hsv = cv2.calcHist([image_hsv], [0, 1, 2], None, num_bins, [0, 256, 0, 256, 0, 256])
	# normalise so scaled images will have similar histograms
	hist_rgb = cv2.normalize(hist_rgb, hist_rgb)
	hist_hsv = cv2.normalize(hist_hsv, hist_hsv)
	
	# flatten histograms to 1D
	hists_flat = [hist_rgb.flatten(), hist_hsv.flatten()]
	return hists_flat


# write histogram to file
def save_histograms(flattened_histograms, original_image_path):
	# get path & name for new stored histogram file
	base_name = os.path.basename(original_image_path)
	file_name = os.path.splitext(base_name)[0]
	file_path = os.path.dirname(original_image_path)
	
	new_file_start = file_path + "/" + file_name
	new_files = [new_file_start + "_rgb.histo", new_file_start + "_hsv.histo"]
	
	# save histograms to new files
	for i, name in enumerate(new_files):
		f = open(name, "wb")
		f.write(pickle.dumps(flattened_histograms[i]))
		f.close()

	return new_files


