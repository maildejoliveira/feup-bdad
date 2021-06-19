PRAGMA foreign_keys=ON;

DROP TABLE IF EXISTS VehicleEmployee;
DROP TABLE IF EXISTS RestaurantFoodItem;
DROP TABLE IF EXISTS RequestFoodItem;
DROP TABLE IF EXISTS RestaurantPeriod;
DROP TABLE IF EXISTS Menu;
DROP TABLE IF EXISTS FoodItemIngredient;
DROP TABLE IF EXISTS Owns;
DROP TABLE IF EXISTS Delivery;
DROP TABLE IF EXISTS County;
DROP TABLE IF EXISTS VehicleType;
DROP TABLE IF EXISTS Vehicle;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Request;
DROP TABLE IF EXISTS FoodItem;
DROP TABLE IF EXISTS FoodType;
DROP TABLE IF EXISTS Ingredient;
DROP TABLE IF EXISTS FoodItemType;
DROP TABLE IF EXISTS Period;
DROP TABLE IF EXISTS Restaurant;
DROP TABLE IF EXISTS Card;
DROP TABLE IF EXISTS Client;

CREATE TABLE Client ( 
    id INTEGER,
    name TEXT,
    address TEXT,
    nif INTEGER UNIQUE,
    email TEXT UNIQUE,
    phone INTEGER UNIQUE,
    password TEXT,
    CONSTRAINT clientPK PRIMARY KEY (id), 
    CONSTRAINT phoneLength CHECK (phone BETWEEN 900000000 AND 999999999 ),
    CONSTRAINT nifLength CHECK (LENGTH (nif) = 9),
    CONSTRAINT contactNotAvailable CHECK ( email IS NOT NULL OR phone IS NOT NULL ),
    CONSTRAINT addressNotNull CHECK ( address IS NOT NULL ),
    CONSTRAINT nameNotNull CHECK ( name IS NOT NULL ),
    CONSTRAINT passRestrictions CHECK ( password IS NOT NULL AND LENGTH(password) > 5 ),
    CONSTRAINT emailPattern CHECK (email LIKE '%@%')
);


CREATE TABLE Card ( 
    number INTEGER,
    expirationDate DATE,
    CONSTRAINT cardPK PRIMARY KEY (number),
    CONSTRAINT cardNumberLength CHECK (LENGTH (number) = 12),
    CONSTRAINT dateNotNull CHECK ( expirationDate IS NOT NULL ),
    CONSTRAINT datePattern CHECK (expirationDate LIKE '__/__')
);


CREATE TABLE Restaurant (
    id INTEGER,
    name TEXT,
    address TEXT UNIQUE,
    evaluation REAL DEFAULT 0.0,
    CONSTRAINT restaurantPK PRIMARY KEY (id),
    CONSTRAINT evaluationValues CHECK (evaluation BETWEEN 0.0 AND 5.0 ),
    CONSTRAINT nameNotNull CHECK ( name IS NOT NULL ),
    CONSTRAINT addressNotNull CHECK ( address IS NOT NULL )
);



CREATE TABLE Period ( 
    openTime DATE,
    closeTime DATE,
    dayOfTheWeek INTEGER,
    CONSTRAINT periodPK PRIMARY KEY (openTime, closeTime, dayOfTheWeek),
    CONSTRAINT dayWeekRange CHECK ( dayOfTheWeek BETWEEN 1 AND 7 ),
    CONSTRAINT validTimeWindow CHECK ( openTime < closeTime ),
    CONSTRAINT openTimeNotNull CHECK (openTime IS NOT NULL),
    CONSTRAINT closeTimeNotNull CHECK (closeTime IS NOT NULL),
    CONSTRAINT dayOfTheWeekNotNull CHECK (dayOfTheWeek IS NOT NULL)
);


CREATE TABLE FoodItemType ( 
    id INTEGER,
    name TEXT UNIQUE DEFAULT 'Not Specified',
    CONSTRAINT foodItemTypePK PRIMARY KEY (id)
); 


CREATE TABLE Ingredient ( 
    id INTEGER,
    name TEXT UNIQUE,
    calories REAL,
    CONSTRAINT ingredientPK PRIMARY KEY (id),
    CONSTRAINT nameNotNull CHECK ( name IS NOT NULL ),
    CONSTRAINT calorieRange CHECK ( calories > 0.0 )
);


CREATE TABLE FoodType ( 
    id INTEGER,
    name TEXT UNIQUE DEFAULT 'Not Specified',
    CONSTRAINT foodTypePK PRIMARY KEY (id)
);


CREATE TABLE FoodItem (
    id INTEGER,
    name TEXT,
    price REAL,
    image TEXT DEFAULT 'blank.png',
    foodItemTypeID INTEGER,
    foodTypeID INTEGER,
    CONSTRAINT foodItemPK PRIMARY KEY (id),
    CONSTRAINT foodItemTypeFK FOREIGN KEY (foodItemTypeID) REFERENCES FoodItemType(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT foodTypeFK FOREIGN KEY (foodTypeID) REFERENCES FoodType(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT nameNotNull CHECK ( name IS NOT NULL ),
    CONSTRAINT priceNotNull CHECK ( price IS NOT NULL ),
    CONSTRAINT foodItemTypeNotNull CHECK ( foodItemTypeID IS NOT NULL ),
    CONSTRAINT foodTypeNotNull CHECK ( foodTypeID IS NOT NULL ),
    CONSTRAINT priceRange CHECK ( price > 0.0 ),
    CONSTRAINT imagePattern CHECK (image LIKE '%.png' OR image LIKE '%.jpeg')
);


CREATE TABLE Request (
    code INTEGER,
    data DATE, 
    time DATE, 
    price REAL, 
    clientID INTEGER, 
    cardNumber INTEGER,
    restaurantID INTEGER,
    CONSTRAINT requestPK PRIMARY KEY (code),
    CONSTRAINT clientFK FOREIGN KEY (clientID) REFERENCES Client(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT cardFK FOREIGN KEY (cardNumber) REFERENCES Card(number) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT restaurantFK FOREIGN KEY (restaurantID) REFERENCES Restaurant(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT cardNumberLength CHECK (LENGTH (cardNumber) = 12),
    CONSTRAINT dateNotNull CHECK ( data IS NOT NULL ),
    CONSTRAINT timeNotNull CHECK ( time IS NOT NULL ),
    CONSTRAINT priceNotNull CHECK ( price IS NOT NULL ),
    CONSTRAINT clientNotNull CHECK ( clientID IS NOT NULL ),
    CONSTRAINT cardNotNull CHECK ( cardNumber IS NOT NULL ),
    CONSTRAINT restaurantNotNull CHECK ( restaurantID IS NOT NULL ),
    CONSTRAINT priceRange CHECK ( price > 0.0 ),
    CONSTRAINT datePattern CHECK (data LIKE '____-__-__'),
    CONSTRAINT timePattern CHECK (time LIKE '__:__')
);


CREATE TABLE Employee ( 
    id INTEGER,
    name TEXT,
    address TEXT,
    nif INTEGER UNIQUE,
    email TEXT UNIQUE,
    phone INTEGER UNIQUE,
    password TEXT, 
    evaluation REAL DEFAULT 0.0,
    postalCode INTEGER,
    CONSTRAINT employeePK PRIMARY KEY (id),
    CONSTRAINT countyFK FOREIGN KEY (postalCode) REFERENCES County(postalCode) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT phoneLength CHECK (phone BETWEEN 900000000 AND 999999999 ),
    CONSTRAINT nifLength CHECK (LENGTH (nif) = 9),
    CONSTRAINT contactNotAvailable CHECK ( email IS NOT NULL OR phone IS NOT NULL ),
    CONSTRAINT addressNotNull CHECK ( address IS NOT NULL ),
    CONSTRAINT nameNotNull CHECK ( name IS NOT NULL ),
    CONSTRAINT passRestrictions CHECK ( password IS NOT NULL AND LENGTH(password) > 5 ),
    CONSTRAINT nifNotNull CHECK ( nif IS NOT NULL ),
    CONSTRAINT evaluationValues CHECK (evaluation BETWEEN 0.0 AND 5.0 ),
    CONSTRAINT emailPattern CHECK (email LIKE '%@%')
);


CREATE TABLE Vehicle ( 
    id INTEGER,
    registration TEXT UNIQUE,
    vehicleTypeID INTEGER,
    CONSTRAINT vehiclePK PRIMARY KEY (id),
    CONSTRAINT vehicleTypeFK FOREIGN KEY (vehicleTypeID) REFERENCES VehicleType(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT registrationNotNull CHECK ( registration IS NOT NULL ),
    CONSTRAINT vehicleTypeNotNull CHECK ( vehicleTypeID IS NOT NULL ),
    CONSTRAINT registrationPattern CHECK (registration LIKE '__-__-__')
    
);



CREATE TABLE VehicleType ( 
    id INTEGER,
    name TEXT UNIQUE,
    CONSTRAINT vehicleTypePK PRIMARY KEY (id),
    CONSTRAINT nameNotNull CHECK ( name IS NOT NULL )
);


CREATE TABLE County ( 
    name TEXT,
    postalCode INTEGER,
    CONSTRAINT countyPK PRIMARY KEY (postalCode),
    CONSTRAINT postalCodeLenght CHECK (LENGTH (postalCode) = 4)
) WITHOUT ROWID;



CREATE TABLE Delivery (
    code INTEGER,
    arrivalTime DATE,
    price REAL,
    atDoor BOOLEAN DEFAULT 1,
    scheduledTime DATE,
    evaluation REAL DEFAULT 3.0,
    registrationID INTEGER,
    employeeID INTEGER,
    CONSTRAINT deliveryPK PRIMARY KEY (code),
    CONSTRAINT vehicleFK FOREIGN KEY (registrationID) REFERENCES Vehicle(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT employeeFK FOREIGN KEY (employeeID) REFERENCES Employee(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT requestFK FOREIGN KEY (code) REFERENCES Request(code) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT arrivalTimeNotNull CHECK ( arrivalTime IS NOT NULL ),
    CONSTRAINT priceNotNull CHECK ( price IS NOT NULL ),
    CONSTRAINT registrationNotNull CHECK ( registrationID IS NOT NULL ),
    CONSTRAINT employeeNotNull CHECK ( employeeID IS NOT NULL ),
    CONSTRAINT validTimeWindow CHECK ( scheduledTime <= arrivalTime ),
    CONSTRAINT priceRange CHECK ( price > 0.0 ),
    CONSTRAINT evaluationValues CHECK (evaluation BETWEEN 0.0 AND 5.0 )
);


-- MANY TO MANY ASSOCIATIONS


CREATE TABLE Owns ( 
    clientID INTEGER,
    cardNumber INTEGER,
    CONSTRAINT ownsPK PRIMARY KEY (clientID,cardNumber),
    CONSTRAINT clientFK FOREIGN KEY (clientID) REFERENCES Client(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT cardFK FOREIGN KEY (cardNumber) REFERENCES Card(number) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT cardNumberNotNull CHECK ( cardNumber IS NOT NULL )
);



CREATE TABLE FoodItemIngredient (
    foodItemID INTEGER,
    ingredientID INTEGER,
    CONSTRAINT foodItemIngredientPK PRIMARY KEY (foodItemID,ingredientID),
    CONSTRAINT foodItemFK FOREIGN KEY (foodItemID) REFERENCES FoodItem(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ingredientFK FOREIGN KEY (ingredientID) REFERENCES Ingredient(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ingredientIDNotNull CHECK ( ingredientID IS NOT NULL )
);



CREATE TABLE Menu (  
    foodItemID1 INTEGER,
    foodItemID2 INTEGER,
    CONSTRAINT menuPK PRIMARY KEY (foodItemID1, foodItemID2),
    CONSTRAINT foodItemFK1 FOREIGN KEY (foodItemID1) REFERENCES FoodItem(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT foodItemFK2 FOREIGN KEY (foodItemID2) REFERENCES FoodItem(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT foodItemIDNotNull CHECK ( foodItemID2 IS NOT NULL )
);



CREATE TABLE RestaurantPeriod (
    restaurantID INTEGER,
    openTime DATE,
    closeTime DATE,
    dayOfTheWeek INTEGER,
    CONSTRAINT restaurantPeriodPK PRIMARY KEY (restaurantID,openTime,closeTime,dayOfTheWeek),
    CONSTRAINT restaurantFK FOREIGN KEY (restaurantID) REFERENCES Restaurant(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT periodFK FOREIGN KEY (openTime,closeTime,dayOfTheWeek) REFERENCES Period(openTime,closeTime,dayOfTheWeek) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE RequestFoodItem ( 
    code INTEGER,
    foodItemID INTEGER,
    numberOfFoodItems INTEGER DEFAULT 1,
    CONSTRAINT requestFoodItemPK PRIMARY KEY(code, foodItemID),
    CONSTRAINT requestFK FOREIGN KEY (code) REFERENCES Request(code) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT foodItemFK FOREIGN KEY (foodItemID) REFERENCES FoodItem(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT foodItemQuantity CHECK ( numberOfFoodItems > 0 ),
    CONSTRAINT foodItemIDNotNull CHECK ( foodItemID IS NOT NULL )

);

CREATE TABLE RestaurantFoodItem ( 
    restaurantID INTEGER,
    foodItemID INTEGER,
    CONSTRAINT restaurantFoodItemPK PRIMARY KEY(restaurantID, foodItemID),
    CONSTRAINT restaurantFK FOREIGN KEY (restaurantID) REFERENCES Restaurant(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT foodItemFK FOREIGN KEY (foodItemID) REFERENCES FoodItem(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT foodItemIDNotNull CHECK ( foodItemID IS NOT NULL )

);

CREATE TABLE VehicleEmployee (
    vehicleID TEXT,
    employeeID TEXT,
    CONSTRAINT vehicleEmployeePK PRIMARY KEY (vehicleID, employeeID),
    CONSTRAINT vehicleFK FOREIGN KEY (vehicleID) REFERENCES Vehicle(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT employeeFK FOREIGN KEY (employeeID) REFERENCES Employee(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT vehicleIDNotNull CHECK ( vehicleID IS NOT NULL ),
    CONSTRAINT employeeIDNotNull CHECK ( employeeID IS NOT NULL )
);
