import os, sys
from decimal import Decimal

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/database")
from db_models import *



# get list of recipes by bottles supplied
def get_recipes(bottle_ids):
	bottles_count = len(bottle_ids)
	bottles_str = ""
	
	# construct comma separated recipe ids
	for bottle_id, bottle in bottle_ids.items():
		bottles_str += str(bottle_id) + ", "
	
	# shave off last comma separator
	bottles_str = bottles_str[:-2]
	
	# join recipes and ingredients
	recipes = Ingredient.raw("""SELECT Recipe.recipe_id, Recipe.rating, Ingredient.ingredient_id FROM Measure
								INNER JOIN Ingredient ON (Ingredient.ingredient_id = Measure.ingredient_id) 
								INNER JOIN Recipe ON Recipe.recipe_id = Measure.recipe_id
								WHERE Ingredient.ingredient_id IN (""" + bottles_str + """) ORDER BY rating DESC""")
	
	# group recipes with their number of ingredients returned
	results_grouping = {}
	
	for recipe in recipes.execute():
		#print(str(recipe.recipe_id) + " | " + str(recipe.ingredient_id))
		#print(Decimal(recipe.rating))
		if recipe.recipe_id in results_grouping:
			results_grouping[recipe.recipe_id] += 1
		else:
			results_grouping[recipe.recipe_id] = 1
			
	
	
	#print(results_grouping)
	
	
	# check for recipe containing all ingredients
	print("> Recipes including all detected ingredients:")
	for recipe in results_grouping:
		if recipe[1] == bottles_count:
			# get recipe details
			recipe_details = Recipe.select().where(Recipe.recipe_id = recipe[0])
			print()
			
			ingredients = Ingredient.raw("""SELECT Recipe.recipe_id, Ingredient.name, Measure.amount FROM Measure
											INNER JOIN Ingredient ON (Ingredient.ingredient_id = Measure.ingredient_id) 
											INNER JOIN Recipe ON Recipe.recipe_id = Measure.recipe_id
											WHERE recipe_id = """ recipe[0])

			for ingredient in ingredients.execute
	
	
	#print(sorted_grouping)
	


	
	

get_recipes({8:"", 12:""})
