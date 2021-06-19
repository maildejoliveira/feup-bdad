.mode	columns
.headers	on
.nullvalue	NULL

.print ' '
.print '8. Indique qual o restaurante mais aprazível para cada cliente, isto é, que vende o tipo de FoodItem os clients mais compram e de um preço semelhante.'
.print ' '

--Food types which client have boutght
DROP VIEW IF EXISTS ClientFoodTypes;
CREATE VIEW ClientFoodTypes AS 
SELECT Client.id AS clientID, FoodType.id AS foodTypeID, count(FoodType.id) AS nOcorr
FROM Client JOIN Request JOIN FoodItem JOIN RequestFoodItem JOIN FoodType
ON Request.code = RequestFoodItem.code AND FoodItem.id = RequestFoodItem.foodItemID AND FoodItem.foodTypeID = foodType.id AND Client.id = Request.clientID
GROUP BY Client.id, FoodType.id;

--Restaurants with at least one foodType of client foodType fav
DROP VIEW IF EXISTS ClientRestaurants;
CREATE VIEW ClientRestaurants AS 
SELECT DISTINCT Restaurant.id as restaurantID, FoodType.id, Client.id as clientID
FROM Client, Restaurant JOIN RestaurantFoodItem JOIN FoodItem JOIN FoodType
ON Restaurant.id = RestaurantFoodItem.restaurantID AND RestaurantFoodItem.foodItemID = FoodItem.id AND FoodItem.foodTypeID = foodType.id
WHERE FoodType.id IN (
    SELECT CF1.foodTypeID
    FROM ClientFoodTypes AS CF1
    WHERE CF1.clientID = Client.id AND CF1.nOcorr >= (SELECT max(nOcorr)
                        FROM ClientFoodTypes as CF2
                        WHERE CF2.clientID = CF1.clientID));

--for each client the restaurants most similar to their common choices
DROP VIEW IF EXISTS ClientCloserRestaurants;
CREATE VIEW ClientCloserRestaurants AS
SELECT  ClientRestaurants.clientID AS clientID , ClientRestaurants.RestaurantID AS restaurantID, abs(ClientMeanPrice.clientMeanPrice - RestaurantsMeanPrice.restaurantMeanPrice) AS difference
FROM (
        SELECT avg(FoodItem.price) as clientMeanPrice, Client.id as clientID    
        FROM Request JOIN Client JOIN RequestFoodItem JOIN FoodItem
        ON Request.clientID=Client.id AND RequestFoodItem.code = Request.code AND FoodItem.id = RequestFoodItem.foodItemID
        GROUP by Client.id
    ) AS ClientMeanPrice 
    JOIN ClientRestaurants 
    JOIN (
        SELECT Restaurant.id as restaurantID , avg(FoodItem.price) as restaurantMeanPrice
        FROM Restaurant JOIN RestaurantFoodItem JOIN FoodItem
        ON Restaurant.id = RestaurantFoodItem.restaurantID AND RestaurantFoodItem.foodItemID = FoodItem.id
        GROUP BY Restaurant.id
    ) AS RestaurantsMeanPrice
ON ClientMeanPrice.clientID = ClientRestaurants.clientID AND ClientRestaurants.restaurantID = RestaurantsMeanPrice.restaurantID;

SELECT clientID AS 'Client ID', Client.name AS 'Client Name', Restaurant.id as 'Restaurant ID', Restaurant.name as 'Restaurant Name'
FROM ClientCloserRestaurants AS CR1 JOIN Client JOIN Restaurant
ON Client.id = CR1.clientID AND Restaurant.id = CR1.restaurantID
WHERE CR1.difference <= (SELECT min(difference)
                        FROM ClientCloserRestaurants AS CR2
                        WHERE CR2.clientID = CR1.clientID)
GROUP BY clientID;
