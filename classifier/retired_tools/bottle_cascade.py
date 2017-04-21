import numpy as np
import cv2

#bottle_cascade = cv2.CascadeClassifier('classifier_1/classifier/cascade.xml')
#bottle_cascade = cv2.CascadeClassifier('classifier_2/classifier/cascade.xml')
#bottle_cascade = cv2.CascadeClassifier('classifier_3/classifier/cascade.xml')
#bottle_cascade = cv2.CascadeClassifier('classifier_2_resized/classifier/cascade.xml')
#bottle_cascade = cv2.CascadeClassifier('classifier_2_resized_2/classifier_good/cascade.xml')
#bottle_cascade = cv2.CascadeClassifier('classifier_3_resized/classifier/cascade.xml')
bottle_cascade = cv2.CascadeClassifier('classifier_jd/classifier_first/cascade.xml')
#bottle_cascade = cv2.CascadeClassifier('classifier_oj/classifier/cascade.xml')

cap = cv2.VideoCapture(0)

while(1):
	ret,frame = cap.read()

	# resize, scaled by target width
	target_width = 600.0
	r = target_width / frame.shape[1]
	dim = (int(target_width), int(frame.shape[0] * r))
	frame_resized = cv2.resize(frame, dim, interpolation = cv2.INTER_AREA)
	#frame_resized = cv2.flip(frame_resized, 1)
	# get greyscale image
	frame_grey = cv2.cvtColor(frame_resized, cv2.COLOR_BGR2GRAY)
	
	# apply cascade classifier
	#detected_bottles = bottle_cascade.detectMultiScale(frame_grey, scaleFactor=1.05, minNeighbors=5, minSize=(80, 150))
	detected_bottles = bottle_cascade.detectMultiScale(frame_grey, scaleFactor=1.05, minNeighbors=5)
	for (x,y,w,h) in detected_bottles:
		#print(w,h)
		
		# get crop window size: dimensions * crop scale (percent of original)
		crop_scale = [30, 10]
		
		crop_w = int(w * (crop_scale[0] * 0.01))
		crop_h = int(h * (crop_scale[1] * 0.01))
		# draw rect around bottle: image, top left point, bottom right point
		cv2.rectangle(frame_resized, (x+crop_w, y+crop_h), (x+w-crop_w, y+h+crop_h), (255,0,0), 1)
		cv2.putText(frame_resized, "bottle", (x+crop_w,y+20), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255,255,255))
		roi = frame_resized[(y+crop_h):(y+h+crop_h), (x+crop_w):(x+w-crop_w)]
		#cv2.imshow('bottle detector', roi)
	
	# apply second cascade classifier
	'''detected_juice = juice_cascade.detectMultiScale(frame_grey, 1.05, 8)
	for (x,y,w,h) in detected_juice:
		# draw rect around bottle: image, top left point, bottom right point
		crop_w = int(w * 0.3)
		crop_h = int(h * 0.1)
		cv2.rectangle(frame_resized, (x+crop_w, y+crop_h), (x+w-crop_w, y+h+crop_h), (0,255,0), 1)
		cv2.putText(frame_resized, "juice", (x+crop_w,y+20), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255,255,255))
		'''
		
	cv2.imshow('bottle detector', frame_resized)
	
	# wait for 5 seconds before closing frame
	if cv2.waitKey(5) == 27:
		break

cv2.destroyAllWindows()
