import numpy as np

class Searcher:
	def __init__(self, index):
		self.index = index
	
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
	
	def chi2_distance(self, histA, histB, eps = 1e-10):
		# compute chi-squared
		d = 0.5 * np.sum([((a - b) ** 2) / (a + b + eps) for (a, b) in zip(histA, histB)])
		
		return d



			
