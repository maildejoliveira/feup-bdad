.mode	columns
.headers	on
.nullvalue	NULL

.print ' '
.print '1. Indique todos os itens de comida e respetivo preço por restaurante, assim como o seu nome e localização.'
.print ' '

SELECT Restaurant.name as 'Restaurant Name', Restaurant.address as 'Restaurant Location', FoodItem.name as 'FoodItem Name', FoodItem.price as 'FoodItem price'
FROM Restaurant JOIN RestaurantFoodItem JOIN FoodItem
ON Restaurant.id = restaurantID
    AND foodItemID = FoodItem.id
ORDER BY Restaurant.id;
