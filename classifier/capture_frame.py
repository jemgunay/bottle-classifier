from datetime import datetime
import numpy as np
import cv2

cap = cv2.VideoCapture(0)

while(True):
	# capture frame
	ret, frame = cap.read()

	# show image
	cv2.imshow('frame', frame)

	# write the resulting frame on space key press
	key_pressed = cv2.waitKey(4)
	if key_pressed == 32:
		cv2.imwrite("img_" + str(datetime.now().time()) + ".jpg", frame)
		
	# close on esc key press
	if key_pressed == 27:
		break

# When everything done, release the capture
cap.release()
cv2.destroyAllWindows()
