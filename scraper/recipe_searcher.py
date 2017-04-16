from bottle_db_models import *

# get list of recipes by ingredient
def get_recipes(ingredient):
	db.connect()
	
	ingredient = Ingredient.select().where(Ingredient.name == new_ingredient)
	if ingredient.exists():
		ingredient_id = ingredient.get().ingredient_id
	
	db.close



