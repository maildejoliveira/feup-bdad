.mode	columns
.headers	on
.nullvalue	NULL

.print ''
.print 'Antes de fazer qualquer inserção:'
.print ''

SELECT * 
FROM Employee
WHERE Employee.id = 1;

INSERT INTO Request(data, time, price, clientID, cardNumber, restaurantID)  
VALUES ('2021-04-01', '18:00', 30, 1, 123456782123, 6);

INSERT INTO Delivery(arrivalTime, price, atDoor, scheduledTime, code, evaluation, registrationID, employeeID) 
VALUES ('19:40', 2.5, 1,'18:20', 27, 1, 1, 1);


.print ''
.print 'Depois de inserir uma evaluation de 1 para uma Delivery de um novo Request:'
.print ''

SELECT * 
FROM Employee
WHERE Employee.id = 1;

INSERT INTO Request(data, time, price, clientID, cardNumber, restaurantID)  
VALUES ('2021-07-01', '12:00', 30, 2, 123456782123, 7);

INSERT INTO Delivery(arrivalTime, price, atDoor, scheduledTime, code, evaluation, registrationID, employeeID) 
VALUES ('13:00', 2.5, 1,'12:00', 28, 5, 1, 1);


.print ''
.print 'Depois de inserir uma evaluation de 1 para outra Delivery de um novo Request:'
.print ''

SELECT * 
FROM Employee
WHERE Employee.id = 1;
.print ''
