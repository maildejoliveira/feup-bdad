.mode	columns
.headers	on
.nullvalue	NULL

.print ' '
.print '7. Indique para cada hora (exemplo 9h-9:59h) o Food Type mais pedido e respetiva quantidade.'
.print ' '

SELECT hour as 'Request Hour',foodTypeName as 'Most Requested Food Type', max(nFoodItems) as 'Number of FoodItems Of This Food Type'
FROM ( 
    SELECT strftime('%H',Request.time) as hour, FoodType.name as foodTypeName, count(FoodType.id) as nFoodItems
    FROM Request
        JOIN RequestFoodItem
        JOIN FoodItem
        JOIN FoodType
    WHERE Request.code = RequestFoodItem.code 
        AND FoodItem.id = RequestFoodItem.foodItemID 
        AND FoodItem.foodTypeID = FoodType.id
    GROUP BY FoodType.name, strftime('%H',Request.time))
GROUP BY hour
ORDER BY hour; 