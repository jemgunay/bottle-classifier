import numpy as np
import cv2
import sys, os

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/database")
import db


# get all cascades from db
classifier_table = db.get_classifiers()
loaded_classifiers = []

# iterate over classifier paths & init cascade classifiers
print("> Classifiers:")
for classifier in classifier_table:
	if os.path.isfile(classifier.lbp_path) and classifier.enabled:
		# classifier file does not exist
		new_classifier = cv2.CascadeClassifier(classifier.lbp_path)
		loaded_classifiers.append(new_classifier)
		print("Success: " + classifier.lbp_path)
	else:
		print("Failed: " + classifier.lbp_path)


print()

# target image display width
target_width = 600.0
# start camera capture
cap = cv2.VideoCapture(0)
# outline drawing colours
frame_colours = [(89, 218, 137), (14, 66, 255), (135, 107, 51), (102, 136, 249), (158, 189, 128)]


# start main loop
while(True):
	# capture frame
	ret,frame = cap.read()

	# resize, scaled by target width
	r = target_width / frame.shape[1]
	dim = (int(target_width), int(frame.shape[0] * r))
	frame_resized = cv2.resize(frame, dim, interpolation = cv2.INTER_AREA)
	# flip image
	#frame_resized = cv2.flip(frame_resized, 1)
	# get greyscale image
	frame_grey = cv2.cvtColor(frame_resized, cv2.COLOR_BGR2GRAY)
	
	
	for i, loaded_classifier in enumerate(loaded_classifiers):
		# apply cascade classifier
		detected_bottles = loaded_classifier.detectMultiScale(frame_grey, scaleFactor=1.05, minNeighbors=5, minSize=(classifier_table[i].min_width, classifier_table[i].min_height))
		
		# draw results into image
		for (x,y,w,h) in detected_bottles:
			#print(w,h)
			# get crop window size: dimensions * crop scale (percent of original)
			crop_w = int(w * (classifier_table[i].crop_width * 0.01))
			crop_h = int(h * (classifier_table[i].crop_height * 0.01))
			
			# crop region of interest (ROI) from image
			roi = frame_resized[(y+crop_h):(y+h+crop_h), (x+crop_w):(x+w-crop_w)]
			#cv2.imshow('Bottle Detector: ROI', roi)
		
			# perform histogram comparison
			
		
			# draw rect around bottle ROI on original frame & label: image, top left point, bottom right point
			cv2.rectangle(frame_resized, (x+crop_w, y+crop_h), (x+w-crop_w, y+h+crop_h), frame_colours[i], 2)
			# draw text label
			cv2.putText(frame_resized, "bottle", (x+crop_w,y+20), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255,255,255))
			
	
	# draw image to window
	cv2.imshow('Bottle Classifier', frame_resized)
	
	# wait for 5 seconds before closing frame after esc key pressed
	if cv2.waitKey(5) == 27:
		break


cv2.destroyAllWindows()


