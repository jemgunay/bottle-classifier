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
