from matplotlib import pyplot as plt
import numpy as np
import cv2

image = cv2.imread("bombay_white.jpg")
chans = cv2.split(image)
colors = ("b", "g", "r")

plt.figure()
plt.title("Split Channel Histogram (RGB)")
plt.xlabel("Colour Channel Intensity")
plt.ylabel("Number of Pixels")

for (chan, color) in zip(chans, colors):	
	hist = cv2.calcHist([chan], [0], None, [256], [0, 256])
	
	plt.plot(hist, color=color)
	plt.xlim([0, 256])

cv2.imshow("image", image)
plt.show()
