from flask import Flask, render_template, Response, request, jsonify
import sys, os

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/database")
import db


@app.route('/')
def index():
	# serve home page
	return render_template('index.html')


@app.route("/recipe")
@app.route("/recipe/<name>")
def command():
	# handle requests to control turret
	action = request.args.get('action', 0, type=int)
	if action == 0:
		return jsonify(result="no command supplied")
	elif action == 1:
		# rotate left/counterclockwise
		print("left")
	
	return jsonify(result=action)


if __name__ == '__main__':
	# debug=True
	app.run(host='0.0.0.0', port=8080, debug=False, threaded=True)

