from search_histogram import Searcher
import numpy as np
import argparse
import cPickle
import cv2
 
# construct the argument parser and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-d", "--dataset", required = True, help = "Path to the directory that contains the images we just indexed")
ap.add_argument("-i", "--index", required = True, help = "Path to where we stored our index")
args = vars(ap.parse_args())
		 
 # load the index and initialize our searcher
index = cPickle.loads(open(args["index"]).read())
searcher = Searcher(index)

for (query, queryFeatures) in index.items():
	# perform search
	results = searcher.search(queryFeatures)
	
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
