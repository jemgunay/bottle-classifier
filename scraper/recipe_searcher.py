import os, sys
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + "/database")
from classifier_db_models import *

# get list of recipes by ingredient
def get_recipes(ingredient_name):
	db.connect()
	
	ingredient = Ingredient.select().where(Ingredient.name == ingredient_name)
	if ingredient.exists():
		print(ingredient.name)
	
	db.close


get_recipes("Cola")
