from db_models import *

# insert recipe details and ingredients into database
def insert_recipe(recipe):
	db.connect()

	# insert recipe name & properties
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

	db.close()


# get all cascades from database
def get_classifiers():
	db.connect()
	
	classifiers = Classifier.select()
	
	db.close()

	return classifiers
	
	
def get_bottle(classifier_id):
	db.connect()
	
	#bottle = Bottle.select().where(Bottle.)
	
	db.close()
	
	#return bottle
