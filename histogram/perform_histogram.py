import numpy as np
import argparse
import cPickle
import cv2
 
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-d", "--dataset", required=False, default="", help="Path to the directory containing histogram data")
args = vars(ap.parse_args())
		 
 # load the index and initialize our searcher
index = cPickle.loads(open(args["index"]).read(), "rb")

for (query, queryFeatures) in index.items():
	# perform search
	results = search(queryFeatures)
	
	# load query image
	path = args["dataset"] + "/%s" % query
	queryImage = cv2.imread(path)
	cv2.imshow("Query", queryImage)
	print "query: %s" % (query)

	# result groupings
	montageA = np.zeros((650 * 5, 648, 3), dtype = "uint8")
	montageB = np.zeros((650 * 5, 648, 3), dtype = "uint8")
	
	# top ten
	for j in xrange(0, 10):
		(score, imageName) = results[j]
		path = args["dataset"] + "/%s" % (imageName)
		result = cv2.imread(path)
		print "\t%d. %s : %.3f" % (j + 1, imageName, score)

		if j < 5:
			montageA[j * 650:(j + 1) * 650, :] = result
		else:
			montageB[(j - 5) * 650:((j - 5) + 1) * 650, :] = result
	
	cv2.imshow("Results 1-5", montageA)
	cv2.imshow("Results 6-10", montageB)
	cv2.waitKey(0)
	

# 
def search(self, queryFeatures):
	results = {}
	
	for (k, features) in self.index.items():
		# compute chi-squared distance
		# switch out for opencv's own methods
		d = self.chi2_distance(features, queryFeatures)
		
		# update results dict, 
		results[k] = d	
	
	# sort results into closest match first
	results = sorted([v, k] for (k, v) in results.items())

	return results


# apply distance metric
def chi2_distance(self, histA, histB, eps = 1e-10):
	# compute chi-squared
	d = 0.5 * np.sum([((a - b) ** 2) / (a + b + eps) for (a, b) in zip(histA, histB)])
	
	return d



