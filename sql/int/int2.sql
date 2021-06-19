.mode	columns
.headers	on
.nullvalue	NULL

.print ' '
.print '2. Em que restaurantes posso comprar bebida depois das 23:30 ou antes das 6:00.'
.print ' '

SELECT DISTINCT Restaurant.id AS 'Restaurant ID', Restaurant.name AS 'Restaurant Name', 
    printf('%d:00', RestaurantPeriod.openTime) AS 'Horário de Abertura', printf('%d:00', RestaurantPeriod.closeTime) AS 'Horário de Fecho'
FROM Restaurant JOIN RestaurantFoodItem JOIN FoodItem JOIN FoodItemType JOIN RestaurantPeriod
ON Restaurant.id = RestaurantFoodItem.restaurantID AND RestaurantFoodItem.foodItemID = FoodItem.id 
    AND FoodItem.foodItemTypeID = FoodItemType.id AND RestaurantPeriod.restaurantID = Restaurant.id
WHERE (julianday('23:30') <= julianday(printf('%d:00', RestaurantPeriod.closeTime)) 
    OR julianday('6:00') >= julianday(printf('%d:00', RestaurantPeriod.openTime))) 
    AND FoodItemType.name = 'bebida';