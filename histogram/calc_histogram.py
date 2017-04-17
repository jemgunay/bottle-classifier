import numpy as np
import cv2

class RGBHistogram:
	def __init__(self, bins):
		self.bins = bins

	def describe(self, image):
		# compute 3D RGB histogram
		hist = cv2.calcHist([image], [0, 1, 2], None, self.bins, [0, 256, 0, 256, 0, 256])
		# normalise so scaled images will have similar histograms
		hist = cv2.normalize(hist, hist)
		
		return hist.flatten()

