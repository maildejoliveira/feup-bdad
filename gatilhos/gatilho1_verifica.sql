.mode	columns
.headers	on
.nullvalue	NULL

.print ''
.print 'Antes de qualquer inserção:'
.print ''

SELECT * from RequestFoodItem Where code=7;
.print ''
SELECT * from Request Where code=7;

INSERT INTO RequestFoodItem (code, foodItemID) values (7,44);

.print ''
.print 'Depois de inserir um FoodItem a um Request:'
.print ''

SELECT * from RequestFoodItem Where code=7;
.print ''
SELECT * from Request Where code=7;

INSERT INTO RequestFoodItem (code, foodItemID, numberOfFoodItems) values (7,1,2);

.print ''
.print 'Depois de inserir outros dois FoodItem a um Request:'
.print ''

SELECT * from RequestFoodItem Where code=7;
.print ''
SELECT * from Request Where code=7;
