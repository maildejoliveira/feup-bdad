DROP TRIGGER IF EXISTS updateRequestPrice;

--ver se é suposto
DELETE FROM RequestFoodItem WHERE code = 7 AND foodItemID = 44;
DELETE FROM RequestFoodItem WHERE code = 7 AND foodItemID = 1;
UPDATE Request SET price = price - 40.5 WHERE code = 7;