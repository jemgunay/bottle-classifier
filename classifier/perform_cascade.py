import numpy as np
import cv2
import sys, os
import argparse

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/database")
import db
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/histogram")
import histogram


# manage cli args
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=False, default="", help="Path to the image for bottle classification")
ap.add_argument("-t", "--type", required=False, default="RGB", help="(RGB or HSV) Colour histogram type to use")
args = vars(ap.parse_args())


# target image display width
target_width = 600.0
# outline drawing colours
frame_colours = [["green", (89, 218, 137)], ["red", (14, 66, 255)], ["blue", (135, 107, 51)], ["peach", (102, 136, 249)], ["light_blue", (158, 189, 128)]]

# get all cascades from db
classifier_table = db.get_classifiers()
loaded_classifiers = []


# populate classifiers dict with supported classifiers from database
def init_classifier():
	# iterate over classifier paths & init cascade classifiers
	print("> Classifiers:")
	for classifier in classifier_table:
		if os.path.isfile(classifier.lbp_path) and classifier.enabled:
			# classifier file does not exist
			initialised_classifier = cv2.CascadeClassifier(classifier.lbp_path)
			loaded_classifiers.append([classifier, initialised_classifier])
			print("Success: " + classifier.lbp_path)
		else:
			print("Failed:  " + classifier.lbp_path)

	print()


# classify bottles on camera stream
def classify_camera_stream():
	# start camera capture
	cap = cv2.VideoCapture(0)

	while(True):
		# capture frame from camera
		ret,frame = cap.read()
		
		if ret == False:
			print("No camera input...")
			return
		
		# perform classification on frame
		classify(frame)
		
		# pause 5ms, close on esc key press
		if cv2.waitKey(5) == 27:
			break
	

# classify bottles on single image
def classify_image():
	# read image from file
	img = cv2.imread(args["image"])
	# perform classification on frame
	classify(img)
	
	cv2.waitKey(0)


# perform classification
def classify(frame):	
	# resize, scaled by target width
	r = target_width / frame.shape[1]
	dim = (int(target_width), int(frame.shape[0] * r))
	frame = cv2.resize(frame, dim, interpolation = cv2.INTER_AREA)
	
	# flip image
	#frame = cv2.flip(frame, 1)
	
	# get greyscale image
	frame_grey = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
	
	for i, loaded_classifier in enumerate(loaded_classifiers):
		# apply cascade classifier
		detected_bottles = loaded_classifier[1].detectMultiScale(frame_grey, scaleFactor=1.05, minNeighbors=5, minSize=(loaded_classifier[0].min_width, loaded_classifier[0].min_height))
		
		# draw results into image
		for (x,y,w,h) in detected_bottles:
			#print(w,h)
			# get crop window size: dimensions * crop scale (percent of original)
			crop_w = int(w * (loaded_classifier[0].crop_width * 0.01))
			crop_h = int(h * (loaded_classifier[0].crop_height * 0.01))
			crop_top_left = [int(x + (w*0.5) - (crop_w*0.5)) + loaded_classifier[0].crop_offset_x, int((y) + (h*0.5) - (crop_h*0.5)) + loaded_classifier[0].crop_offset_y]
			crop_bottom_right = [int((x+w) - (w*0.5) + (crop_w*0.5)) + loaded_classifier[0].crop_offset_x, int((y+h) - (h*0.5) + (crop_h*0.5)) + loaded_classifier[0].crop_offset_y]
			
			# crop region of interest (ROI) from image
			roi = frame[(crop_top_left[1]):(crop_bottom_right[1]), (crop_top_left[0]):(crop_bottom_right[0])]
			#cv2.imshow('Bottle Detector: ROI', roi)
			#cv2.waitKey(0)
			
			# perform histogram comparison (classifier_id, rgb|hsv)
			bottle_match = histogram.match_histogram(roi, loaded_classifier[0].classifier_id, args["type"])
			# skip draw if histogram search fails
			if bottle_match.action == False:
				break
		
			# draw rect around bottle ROI on original frame & label: image, top left point, bottom right point
			cv2.rectangle(frame, (crop_top_left[0], crop_top_left[1]), (crop_bottom_right[0], crop_bottom_right[1]), frame_colours[i][1], 1)
			# draw text label
			cv2.putText(frame, bottle_match.rgb_path, (x+crop_w,y+20), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255,255,255))
			
	
	# draw image to window
	cv2.imshow('Bottle Classifier', frame)
	

init_classifier()

# stream or image
if args["image"] == "":
	classify_camera_stream()
else:
	classify_image()
	

cv2.destroyAllWindows()


