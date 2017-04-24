import numpy as np
import cv2
import sys, os
import argparse
from timeit import default_timer as timer

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/database")
import db
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/histogram")
import histogram
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/scraper")
from recipe_searcher import get_recipes


# manage cli args
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=False, default="", help="Path to the image for bottle classification")
ap.add_argument("-t", "--type", required=False, default="RGB", help="(RGB or HSV) Colour histogram type to use")
ap.add_argument("-c", "--classifier", required=False, default="LBP", help="(LBP or HAAR) Classifier type to use (if available)")
ap.add_argument("-m", "--metric", required=False, default="ChiSquared", help="(ChiSquared, Correlation, Intersection, Hellinger) Colour histogram comparison distance metric")
ap.add_argument("-w", "--webcam", required=False, default=0, help="which video camera/webcam to use (if multiple cameras are available)")
args = vars(ap.parse_args())


# target image display width
output_width = 600.0
# outline drawing colours
frame_colours = [["green", (89, 218, 137)], ["red", (14, 66, 255)], ["blue", (135, 107, 51)], ["peach", (102, 136, 249)], ["light_blue", (158, 189, 128)]]

# get all cascades from db
classifier_table = db.get_classifiers()
loaded_classifiers = []

# start camera capture
cap = cv2.VideoCapture(int(args["webcam"]))


# populate classifiers dict with supported classifiers from database
def init_classifier():
	# iterate over classifier paths & init cascade classifiers
	print("> Classifiers:")
	for classifier in classifier_table:
		# set classifier type
		classifier_type = classifier.lbp_path
		if args["classifier"] == "HAAR":
			classifier_type = classifier.haar_path
			
		# check classifier file
		if os.path.isfile(classifier_type) and classifier.enabled:
			# classifier file does not exist
			initialised_classifier = cv2.CascadeClassifier(classifier_type)
			loaded_classifiers.append([classifier, initialised_classifier])
			print("Enabled:  " + classifier_type)
		else:
			print("Disabled: " + classifier_type)

	print()


# classify bottles on camera stream
def classify_camera_stream():
	# ingredients and buffer (how many frames to record detected ingredients for)
	detection_results = {"bottles" : {}, "frame_count" : 3, "counting" : False}
	
	while(True):
		# capture frame from camera
		ret,frame = cap.read()
		# exit if no camera found
		if ret == False:
			print("No camera input...")
			break
		
		# perform classification on frame
		classify(frame, detection_results)
		
		# launch recipe viewer
		if detection_results["frame_count"] == 0:
			print("> Bottles detected:")
			for bottle_id, bottle in detection_results["bottles"].items():
				print(bottle.name)
			print("\n> Launching recipe viewer...")
			# clean up
			for i in range(1,10):
				cv2.destroyAllWindows()
				cv2.waitKey(1)
			# display recipes
			get_recipes(detection_results["bottles"])
			break
		
		
		key_pressed = cv2.waitKey(4) & 255
		# start recording bottles on space key press		
		if key_pressed == 32:
			detection_results["counting"] = True
			# close on esc key press
		elif key_pressed == 27:
			break
		else:
			continue
	

# classify bottles on single image
def classify_image():
	# ingredients and buffer (how many frames to record detected ingredients for)
	detection_results = {"bottles" : {}, "frame_count" : 3, "counting" : False}
	# read image from file
	img = cv2.imread(args["image"])
	# perform classification on frame
	classify(img, detection_results)
	
	cv2.waitKey(0)


# perform classification
def classify(frame, detection_results):
	if detection_results["counting"]:
		detection_results["frame_count"] -= 1

	# resize, scaled by target width
	r = output_width / frame.shape[1]
	dim = (int(output_width), int(frame.shape[0] * r))
	frame = cv2.resize(frame, dim, interpolation = cv2.INTER_AREA)
	
	# flip image
	#frame = cv2.flip(frame, 1)
	
	# get greyscale image
	frame_grey = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
	
	# equalise
	#frame_grey = cv2.equalizeHist(frame_grey)
	
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
			# display roi as imagein widow
			#cv2.imshow('Bottle Detector: ROI', roi)
			#cv2.waitKey(0)
			
			# perform histogram comparison (classifier_id, rgb|hsv)
			bottle_match = histogram.match_histogram(roi, loaded_classifier[0].classifier_id, args["type"], args["metric"])
			# skip draw if histogram search fails
			if bottle_match.action == False:
				break
				
			bottle = db.get_bottle(bottle_match.bottle_id)
			
			# add bottle to list of detected bottles
			if detection_results["counting"] == True:
				detection_results["bottles"][bottle.bottle_id] = bottle
			
			# draw rect around bottle ROI on original frame & label: image, top left point, bottom right point
			cv2.rectangle(frame, (crop_top_left[0], crop_top_left[1]), (crop_bottom_right[0], crop_bottom_right[1]), frame_colours[i][1], 1)
			# draw text label
			cv2.putText(frame, bottle.name, (crop_top_left[0], crop_top_left[1] - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.6, frame_colours[i][1], 2)
			cv2.putText(frame, bottle.name, (crop_top_left[0], crop_top_left[1] - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0,0,0), 1)

	# draw image to window
	cv2.imshow('Bottle Classifier', frame)
	

init_classifier()

# stream or image
if args["image"] == "":
	classify_camera_stream()
else:
	classify_image()
	

cap.release()
cv2.destroyAllWindows()


