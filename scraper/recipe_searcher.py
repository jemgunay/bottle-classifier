import os, sys
from decimal import Decimal
from flask import Flask, render_template, Response, request, jsonify
import webbrowser

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/database")
from db_models import *
from db import *

# get list of recipes by bottles supplied
def get_recipes(bottle_ids):
	bottles_count = len(bottle_ids)
	ingredients_str = ""
	bottles_detected = []
	
	# construct comma separated recipe ids and trim last comma
	for bottle_id, bottle in bottle_ids.items():
		ingredient_id = get_ingredient_id(bottle_id)
		ingredients_str += str(ingredient_id) + ", "
	
	ingredients_str = ingredients_str[:-2]
	
	# join recipes and ingredients tables
	recipes = get_recipes_by_ingredients(ingredients_str)
	
	# group recipes with their number of ingredients returned
	results_grouping = {}
	
	for recipe in recipes.execute():
		if recipe.recipe_id in results_grouping:
			results_grouping[recipe.recipe_id] += 1
		else:
			results_grouping[recipe.recipe_id] = 1
	
	# store recipe/ingredient info to be passed onto server for display
	final_recipes = []
	counter = 0
	
	for recipe_id, count in results_grouping.items():
		if count == bottles_count:
			# get recipe details
			recipe_details = Recipe.select().where(Recipe.recipe_id == recipe_id).get()
			final_recipes.append([recipe_details, []])
			
			ingredients = get_ingredients_by_recipe(recipe_id)

			for ingredient in ingredients.execute():
				#print("  " + ingredient.amount + " " + ingredient.name)
				final_recipes[counter][1].append((ingredient.amount + " " +ingredient.name).strip())
			
			counter += 1
			
	# start server
	launch_server(final_recipes)


# launch server for recipe viewing
def launch_server(recipes):
	try:	
		app = Flask(__name__)

		@app.route('/')
		def index():
			# serve home page
			return render_template('index.html', recipes=recipes)
		
		# open browser
		webbrowser.open("http://127.0.0.1:8080/", new=2)
		# start server
		app.run(host='0.0.0.0', port=8080, debug=False, threaded=True)
	
	except KeyboardInterrupt:
		print("server error")
	
	

#get_recipes({8:"", 12:""})
