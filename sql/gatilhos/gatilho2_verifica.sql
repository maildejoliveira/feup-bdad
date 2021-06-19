.mode	columns
.headers	on
.nullvalue	NULL

.print ''
.print 'Antes de fazer qualquer inserção:'
.print ''


SELECT count(*) as 'Number of deliverys' from Delivery;

-- Valid Time Window, Restaurant with ID 6 can attend from 10:00 to 14:00 and from 18:00 to 23:00
INSERT INTO Request(data, time, price, clientID, cardNumber, restaurantID)  
VALUES ('2021-04-01', '18:00', 30, 1, 123456782123, 6);

INSERT INTO Delivery(arrivalTime, price, atDoor, scheduledTime, code, evaluation, registrationID, employeeID) 
VALUES ('19:40', 2.5, 1,'18:20', 27, 1, 1, 1);


.print ''
.print 'Depois de inserir uma nova Delivery e um novo Request:'
.print ''


SELECT count(*) as 'Number of deliverys after insert' from Delivery;
.print ''

-- Invalid Time Window, Restaurant with ID 6 can not attend any customer at 4:00, ABORT is raised
INSERT INTO Request(data, time, price, clientID, cardNumber, restaurantID)  
VALUES ('2021-07-01', '12:00', 30, 2, 123456782123, 7);

INSERT INTO Delivery(arrivalTime, price, atDoor, scheduledTime, code, evaluation, registrationID, employeeID) 
VALUES ('13:00', 2.5, 1,'4:00', 28, 5, 1, 1);


.print ''
.print 'Depois de inserir uma nova Delivery inválida e um novo Request:'
.print ''

SELECT count(*) as 'Number of deliverys after invalid insert' from Delivery;
