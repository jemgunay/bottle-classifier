from matplotlib import pyplot as plt
import numpy as np
import cv2

image = cv2.imread("bombay_blue.jpg")
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

hist = cv2.calcHist([gray], [0], None, [256], [0, 256])
plt.figure()
plt.title("Grayscale Histogram")
plt.xlabel("Bins")
plt.ylabel("Number of pixels")
plt.plot(hist)
plt.xlim([0, 256])

cv2.imshow("image", gray)
plt.show()
