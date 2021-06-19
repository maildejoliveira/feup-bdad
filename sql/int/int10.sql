.mode	columns
.headers	on
.nullvalue	NULL

.print ' '
.print '10. Indique quais os clientes que fizeram encomendas em todos os restaurantes de Comida Italiana.'
.print ' '

SELECT Client.id as 'Client ID', Client.name as 'Client Name'
FROM Client where client.id NOT IN (
    SELECT DISTINCT client
    FROM (
        SELECT Restaurant.id as restaurant, Client.id as client
        FROM Restaurant, Client 
        EXCEPT 
        SELECT DISTINCT Restaurant.id, Client.id
        FROM Client,Request,Restaurant
        WHERE Client.id=Request.clientID AND Request.restaurantID = Restaurant.id
    )
    WHERE restaurant IN (
        SELECT DISTINCT Restaurant.id
        FROM Restaurant JOIN RestaurantFoodItem JOIN FoodItem JOIN FoodType
        ON Restaurant.id = RestaurantFoodItem.restaurantID AND RestaurantFoodItem.foodItemID = FoodItem.id AND FoodItem.foodTypeID = FoodType.id
        WHERE FoodType.name = 'Indiana'
    )
);
