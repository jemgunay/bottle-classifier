CREATE TABLE Recipe (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    serves VARCHAR(2),
    rating DOUBLE(20),
    instructions VARCHAR(255),
) ENGINE=INNODB;


CREATE TABLE Ingredient (
    ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    serves VARCHAR(2),
) ENGINE=INNODB;

CREATE TABLE Measure (
    measure_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT,
    ingredient_id INT,
    
    FOREIGN KEY (recipe_id) REFERENCES Recipe(recipe_id)
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(ingredient_id)
) ENGINE=INNODB;


# create cascade table here



CREATE TABLE Bottle (
    bottle_id INT AUTO_INCREMENT PRIMARY KEY,
    ingredient_id INT,
    cascade_id INT,
	name VARCHAR(30),
	detection_offset_x INT,
	detection_offset_y INT,
	detection_offset_w INT,
	detection_offset_h INT,
	
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(ingredient_id)
    FOREIGN KEY (cascade_id) REFERENCES Cascade(cascade_id)
) ENGINE=INNODB;
