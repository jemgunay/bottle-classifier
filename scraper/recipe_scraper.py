import sys
import argparse
import re
import requests
from bs4 import BeautifulSoup

# parse arguments
ap = argparse.ArgumentParser()
ap.add_argument("-u", "--url", required=True, help="URL to scrape from 'www.cocktail.uk.com' (by recipe or ingredient)")
ap.add_argument("-p", "--pages", default=1, help="number of results pages to scrape (when scraping by ingredient only)", type=int)
ap.add_argument("-d", "--debug", default=False, help="print data collection debug info", type=bool)
args = vars(ap.parse_args())
print()

# split URL into sections and check validity
def validate_URL(URL):
	URL_split = URL.split("/")
	
	for i,section in enumerate(URL_split):
		# check for 'https://www.cocktail.uk.com/cocktails/'
		if "cocktail.uk.com" in URL_split[i] and URL_split[i+1] == "cocktails":
			# check for scrape type (by recipe or ingredient)
			if URL_split[i+2] == "containing":
				# split off page param if provided
				scrape_ingredient(URL_split[i+3].split('?')[0])
			else:
				scrape_recipe(URL_split[i+2])
			return
	
	# invalid URL
	print("> Invalid URL provided: please provide a URL from www.cocktail.uk.com")		
	sys.exit()


# scrape multiple recipes by ingredient
def scrape_ingredient(ingredient_name):
	# iterate over each page of results requested in args
	for page_num in range(args['pages']):
		html = request_page('containing/' + ingredient_name + '?page=' + str(page_num+1))
		soup = BeautifulSoup(html, 'html.parser')
		
		# iterate over each recipe on the retrieved ingredient page
		for recipe in soup.find_all('a')[::2]:
			if not len(recipe.find_parents("div", class_="item")):
				if "/cocktails/" in recipe.get('href') and "/containing/" not in recipe.get('href'):
					scrape_recipe(recipe.get('href')[11:])


# scrape single recipe
def scrape_recipe(recipe_name):
	html = request_page(recipe_name)
	# scrape recipe details
	soup = BeautifulSoup(html, 'html.parser')
	if args['debug']:
		# recipe name
		print("> " + soup.find(itemprop="name").string[:-9])
		# instruction notes
		print(soup.find(itemprop="instructions").string)
		# serves
		print("serves: " + soup.find(style="margin-bottom: 5px;").string[8:])
		# rating
		print("rating: " + soup.find(itemprop="rating").string + "\n")
	
	for ingredient in soup.find_all(itemprop="ingredient"):
		# get all ingredients and their measures
		measurement = str(ingredient.contents[1].string)
		# catch exeption when no measure exists
		try:
			ingredient = str(ingredient.contents[3].string).replace("®", '')
		except IndexError:
			ingredient = ""
		
		if args['debug']:
			print(measurement + " " + ingredient)
	
	if args['debug']:
		print()
		

# perform requests to cocktail.uk.com
def request_page(query):
	r = requests.get('https://www.cocktail.uk.com/cocktails/' + query)
	if r.status_code == requests.codes.ok:
		return r.text
	else:
		print("> Invalid URL provided: cocktail recipe or ingredient does not exist (" + query + ")")
		sys.exit()
		

validate_URL(args['url'])



