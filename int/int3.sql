.mode	columns
.headers	on
.nullvalue	NULL

.print ' '
.print '3. Quais as Deliveries feitas pelos employees que tenham 3 ou mais tipos de veículos associados.'
.print ' '


SELECT code AS 'Delivery and Request Code'
FROM Delivery JOIN Request
USING (code)  
WHERE EXISTS (
    SELECT Employee.id, Employee.name
    FROM Employee JOIN VehicleEmployee JOIN Vehicle JOIN VehicleType
    ON Employee.id = VehicleEmployee.employeeID AND Vehicle.id = VehicleEmployee.vehicleID AND Vehicle.vehicleTypeID = VehicleType.id 
    WHERE Employee.id = Delivery.employeeID
    GROUP BY Employee.id 
    HAVING count(*)  >= 3
);
