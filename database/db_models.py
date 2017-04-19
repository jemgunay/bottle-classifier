from peewee import *

# init database connection
db = MySQLDatabase(host='localhost', user='root', passwd='', database='bottle_classifier')

# define table models
class Recipe(Model):
	recipe_id = PrimaryKeyField()
	name = CharField()
	serves = SmallIntegerField()
	rating = DecimalField()
	instructions = CharField()

	class Meta:
		database = db
		db_table = 'Recipe'
		
		
class Ingredient(Model):
	ingredient_id = PrimaryKeyField()
	name = CharField()

	class Meta:
		database = db
		db_table = 'Ingredient'
		
		
class Measure(Model):
	measure_id = PrimaryKeyField()
	recipe_id = SmallIntegerField()
	ingredient_id = SmallIntegerField()
	amount = CharField()

	class Meta:
		database = db
		db_table = 'Measure'
		
		
class Classifier(Model):
	classifier_id = PrimaryKeyField()
	lbp_path = CharField()
	haar_path = CharField()
	min_width = SmallIntegerField()
	min_height = SmallIntegerField()
	crop_width = SmallIntegerField()
	crop_height = SmallIntegerField()
	crop_offset_x = SmallIntegerField()
	crop_offset_y = SmallIntegerField()
	enabled = BooleanField()

	class Meta:
		database = db
		db_table = 'Classifier'
		

class Histogram(Model):
	histogram_id = PrimaryKeyField()
	classifier_id = SmallIntegerField()
	bottle_id = SmallIntegerField()
	rgb_path = CharField()
	hsv_path = CharField()
	action = BooleanField()
	enabled = BooleanField()

	class Meta:
		database = db
		db_table = 'Histogram'
		

class Bottle(Model):
	bottle_id = PrimaryKeyField()
	ingredient_id = SmallIntegerField()
	name = CharField()

	class Meta:
		database = db
		db_table = 'Bottle'
		
