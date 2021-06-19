.mode	columns
.headers	on
.nullvalue	NULL
-------------------------------------------------------------------------------------------------------------------------
--SELECT 'ordena os restaurantes pelo numero de pedidos efetuados' as query1;

SELECT Restaurant.name as RestaurantName, count(*) as nRequests
FROM Restaurant JOIN Request ON Restaurant.id = Request.restaurantID
GROUP BY Restaurant.id
ORDER BY nRequests desc;
-------------------------------------------------------------------------------------------------------------------------
--SELECT 'quais os clientes que pediram um menu do Mc Donalds';

SELECT DISTINCT Client.name 
FROM Client JOIN Request JOIN Restaurant JOIN RequestFoodItem JOIN FoodItem JOIN FoodItemType
ON Client.id=Request.clientID AND Request.restaurantID = Restaurant.ID AND RequestFoodItem.code = Request.code 
AND RequestFoodItem.foodItemID = FoodItem.id AND FoodItemType.id = FoodItem.foodItemTypeID
WHERE Restaurant.name = "McDonald's" AND FoodItemType.name = 'menu';
-------------------------------------------------------------------------------------------------------------------------
--SELECT 'quanto dinheiro fez cada restaurant por mes em pedidos';

SELECT Restaurant.id, Restaurant.name, strftime('%m',Request.data) AS month, sum(Request.price)
FROM Request JOIN Restaurant
ON Request.restaurantID = Restaurant.ID
GROUP BY Restaurant.id, month;
-------------------------------------------------------------------------------------------------------------------------
--SELECT 'todos os employees cuja media das avaliações das deliveries efetuadas por ele é maior que 3.5';

SELECT Employee.id, avg(Delivery.evaluation)
FROM Employee JOIN Delivery 
ON Employee.id = Delivery.employeeID
GROUP BY Employee.id
HAVING avg(Delivery.evaluation) >= 4;
-------------------------------------------------------------------------------------------------------------------------
--saber qual o numero de request em cada county por ordem decrescente
-------------------------------------------------------------------------------------------------------------------------
--quais os funcionarios que só entregaram pedidos da parte da manha (medio) ___________
-------------------------------------------------------------------------------------------------------------------------
--quais os clientes que fizeram pedidos iguais
-------------------------------------------------------------------------------------------------------------------------
--qual o cliente que fez o mesmo pedido mais vezes
-------------------------------------------------------------------------------------------------------------------------
--existe alguma relação entre pedidos com o mesmo preço?
-------------------------------------------------------------------------------------------------------------------------
--qual o tipo de comida que foi entregue mais vezes por cada tipo de veiculo(ou employee)
-------------------------------------------------------------------------------------------------------------------------
--quais os pedidos realizados por uma carroça que tem comida do tipo sushi (interception)
-------------------------------------------------------------------------------------------------------------------------
--quais os pedidos realizados por um autocarro ou no county lamego (union)
-------------------------------------------------------------------------------------------------------------------------
--quais as bebidas que foram entregues depois das 8 da noite no porto
-------------------------------------------------------------------------------------------------------------------------
--quais os employes que realizaram entregas mais diversificadas, ou seja com foodItemTypes diferentes
-------------------------------------------------------------------------------------------------------------------------
--qual o pedido mais calorico
------------------------------------------------------------------------------------------------------------------------
--pares de comidas que foram encomendadas mais vezes juntas (prof)
-------------------------------------------------------------------------------------------------------------------------
--pedidos com sazionalidade e restaurantes (prof)
--restaurantes que entregaram pedidos todos os trimestres do ano
-------------------------------------------------------------------------------------------------------------------------
--relacionar atrasos do empregado ou restaurante (prof)
-------------------------------------------------------------------------------------------------------------------------
--ver se price de entrega influencia a procura (prof)
-------------------------------------------------------------------------------------------------------------------------
--qual foi o pedido que envolveu todos os foodItems disponiveis num restaurante
-------------------------------------------------------------------------------------------------------------------------
--quais os foodItems que são vendidos em mais que um restaurant
SELECT FoodItem.id, FoodItem.name, count(*)
FROM FoodItem JOIN RestaurantFoodItem JOIN Restaurant 
ON FoodItem.id = RestaurantFoodItem.foodItemID AND RestaurantFoodItem.restaurantID = Restaurant.id
GROUP BY FoodItem.id;
-------------------------------------------------------------------------------------------------------------------------
--qual o tipo de comida em media mais caro
-------------------------------------------------------------------------------------------------------------------------
--Top três compradores da aplicação (com a percentagem de dinheiro gasto)
-------------------------------------------------------------------------------------------------------------------------
--Percentagem de dinheiro gasto por cada cliente
-------------------------------------------------------------------------------------------------------------------------
--contar o tipo de veiclos que realizaram pedidos por periodo em cada restaurant
-------------------------------------------------------------------------------------------------------------------------
-- qual o foodType em media mais caro

SELECT Restaurant.id, Restaurant.name, Restaurant.evaluation, avg(FoodItem.price), FoodType.id, FoodType.name
FROM FoodItem JOIN FoodType JOIN Restaurant JOIN RestaurantFoodItem
ON FoodItem.foodTypeID = FoodType.id AND Restaurant.id = RestaurantFoodItem.restaurantID AND FoodItem.id = RestaurantFoodItem.foodItemID
GROUP BY FoodType.id, Restaurant.id ;

--OPERADORES:
--AGREGATION        |
--JOIN (INNER)      ||||||  
--NATURAL JOIN                                          FALTA
--LEFT JOIN         |
--ORDER BY          ||      DESC |
--GROUP BY          ||||      
--HAVING            |
--EXISTS / NOT      |                        
--NOT IN / IN       |||
--MAX               |||
--MIN               || 
--SUM               ||
--AVG               |
--COUNT             ||
--ABS               |
--DISTINCT          ||          
--EXCEPT            |
--INSERCT           |
--BETWEEN           |||
--IF NULL           |
--LIMIT             |
--SUBQUERIES        |||| 
--VIEWS             |
--julian day        |||
--strftime          |
--using             |
--union


--TRIGGERS:
--preço de um REQUEST 
--evaluation de um Employee



--OPERADORES:
--AGREGATION        ||
--JOIN (INNER)      ||||||||||           
--LEFT JOIN         |
--ORDER BY          |||              DESC |
--GROUP BY          |||||              
--HAVING            ||
--EXISTS / NOT      |                              
--NOT IN / IN       |||
--MAX               ||
--MIN               || 
--SUM               |
--AVG               |
--COUNT             ||             
--ABS               |
--DISTINCT          |||                    
--EXCEPT            |
--INSERCT           |
--BETWEEN           |
--IF NULL           |
--LIMIT             |
--SUBQUERIES        ||         
--VIEWS             |
--julian day        ||        
--strftime          ||
--using             |             
--OR                |
