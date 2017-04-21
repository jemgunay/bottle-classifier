import numpy as np
import cv2


face_cascade = cv2.CascadeClassifier('train_classifier/classifier/cascade.xml')

img = cv2.imread('vodka3.bmp')

r = 500.0 / img.shape[1]
dim = (500, int(img.shape[0] * r))
img = cv2.resize(img, dim, interpolation = cv2.INTER_AREA)

gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

faces = face_cascade.detectMultiScale(gray, 1.05, 3)
for (x,y,w,h) in faces:
	cv2.rectangle(img, (x,y), (x+w,y+h), (255,0,0), 2)

cv2.imshow('img', img)
cv2.waitKey(0)
cv2.destroyAllWindows()
