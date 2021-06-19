.mode	columns
.headers	on
.nullvalue	NULL

.print ' '
.print '6. Indique quais os funcionarios que só entregaram pedidos entre as 8:00 e o 12:00.'
.print ' '

SELECT DISTINCT Employee.id as 'Employee ID', Employee.name as 'Employee Name'
FROM Employee JOIN Delivery
ON Employee.id = Delivery.employeeID
WHERE julianday(Delivery.arrivalTime) BETWEEN julianday('18:00') AND julianday('21:00') AND NOT Employee.id IN (
    SELECT Employee.id
    FROM Employee JOIN Delivery
    ON Employee.id = Delivery.employeeID
    WHERE julianday(Delivery.arrivalTime) NOT BETWEEN julianday('18:00') AND julianday('21:00')
    INTERSECT
    SELECT Employee.id
    FROM Employee JOIN Delivery
    ON Employee.id = Delivery.employeeID
    WHERE julianday(Delivery.arrivalTime) BETWEEN julianday('18:00') AND julianday('21:00')
);
