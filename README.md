# Bottle Classifier & Cocktail Resolver
An application for detecting and classifying bottles, as well as displaying appropriate cocktail recipes based on the classifier bottles.

Achieved using trained HAAR/LBP cascades for detection and colour histograms generated of detected ROI to improve classification performance. Currently classifies Smirnoff Vodka and Jack Daniels bottles, as well as Red Bull cans, Monster Energy cans and an orange juice carton.


## Usage
### Main Application
Ensure MySQL server is running and that the database has been created (import latest: "database/backup/bottle_classifier_backup_X.sql")
```
cd classifier
Help: 						 python3 perform_cascade.py -h
Classify from camera stream: python3 perform_cascade.py
Classify from image:         python3 perform_cascade.py -i ../test_data/test_multi.jpg
```

### Recipe Scraper
Scrap a singular recipe or multiple recipes by ingredient from "https://cocktail.uk.com"
```
cd scraper
Scrape all containing ingredient:  python3 recipe_scraper.py -u https://www.cocktail.uk.com/cocktails/containing/vodka
Scrape singular recipe:            python3 recipe_scraper.py -u https://www.cocktail.uk.com/cocktails/cosmopolitan
Scrape and save to MySQL database: python3 recipe_scraper.py -u https://www.cocktail.uk.com/cocktails/cosmopolitan -s true
```

### Flush Histograms
After adding new images to "histogram/histogram_data", ".histo" histogram files can be generated. These must be entered into the database manually after creation.
```
cd histogram
Regenerate all new & old histograms: ./refresh_histograms.sh
Create singular histogram set:       python3 create_histogram.py -i histogram_data/oj.jpg
```

## Dependencies
Local MySQL database

Python 3
OpenCV 3.1.0
NumPy
PyMySQL
peewee
Beautiful Soup 4
Flask
argparse
webbrowser
