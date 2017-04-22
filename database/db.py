from db_models import *

db.connect()

# insert recipe details and ingredients into database
def insert_recipe(recipe):

	# check if recipe exists already
	recipe_search = Recipe.select().where(Recipe.name == recipe['name'])
	if recipe_search.exists() == False:
		# insert new recipe
		new_recipe = Recipe.insert(name=recipe['name'], serves=recipe['serves'], rating=recipe['rating'], instructions=recipe['instructions'])
		new_recipe_id = new_recipe.execute()
	
		# iterate over all recipe ingredients
		for new_ingredient, new_measure in recipe['ingredients'].items():
			# check if ingredient exists already
			ingredient = Ingredient.select().where(Ingredient.name == new_ingredient)
			ingredient_id = 0
		
			if ingredient.exists():
				ingredient_id = ingredient.get().ingredient_id
			else:
				# insert ingredient if it does not exist
				ingredient = Ingredient.insert(name=new_ingredient)
				ingredient_id = ingredient.execute()
		
			# insert new measure grouping
			new_measure = Measure(recipe_id=new_recipe_id, ingredient_id=ingredient_id, amount=new_measure)
			new_measure.save()


# get all cascades from database
def get_classifiers():
	return Classifier.select()

	
# get all histograms associated with classifier_id
def get_histograms(classifier_id):
	histograms = Histogram.select().where(Histogram.classifier_id == classifier_id)
	
	return histograms
	
	
# get all bottle by id
def get_bottle(bottle_id):
	return Bottle.select().where(Bottle.bottle_id == bottle_id).get()


def get_recipes_by_ingredients(ingredients_str):
	return Ingredient.raw("""SELECT Recipe.recipe_id, Recipe.rating, Ingredient.ingredient_id FROM Measure
								INNER JOIN Ingredient ON (Ingredient.ingredient_id = Measure.ingredient_id) 
								INNER JOIN Recipe ON Recipe.recipe_id = Measure.recipe_id
								WHERE Ingredient.ingredient_id IN (""" + ingredients_str + """) ORDER BY rating DESC""")

def get_ingredients_by_recipe(recipe_id):
	return Ingredient.raw("""SELECT Recipe.recipe_id, Ingredient.name, Measure.amount FROM Measure
											INNER JOIN Ingredient ON (Ingredient.ingredient_id = Measure.ingredient_id) 
											INNER JOIN Recipe ON Recipe.recipe_id = Measure.recipe_id
											WHERE Recipe.recipe_id = """ + str(recipe_id))


# get ingredient id by bottle id
def get_ingredient_id(bottle_id):
	return Bottle.select().where(Bottle.bottle_id == bottle_id).get().ingredient_id

def get_ingredient_name(ingredient_id):
	return Ingredient.select().where(Ingredient.ingredient_id == ingredient_id).get().name


db.close()
