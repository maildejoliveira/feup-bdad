CREATE TRIGGER updateRequestPrice
AFTER INSERT ON RequestFoodItem
FOR EACH ROW
BEGIN
    UPDATE Request SET price = price + (SELECT FoodItem.price from FoodItem Where NEW.foodItemID=FoodItem.id )*NEW.numberOfFoodItems
    Where NEW.code=Request.code;
END;