.mode	columns
.headers	on
.nullvalue	NULL

.print ' '
.print '9. Indique qual o trabalhador que passou mais tempo sem realizar entregas.'
.print ' '

DROP VIEW IF EXISTS EmployeeDeliveries;
CREATE VIEW EmployeeDeliveries AS
SELECT Employee.id as employeeID, Employee.name as employeeName, Delivery.code as code, Request.data as data
FROM Employee 
    JOIN Delivery 
    JOIN Request
ON Employee.id = Delivery.employeeID 
    AND Delivery.code = Request.code
GROUP BY Employee.id, Delivery.code
ORDER BY Employee.id, Request.data;

SELECT employeeID AS 'Employee ID', employeeName AS 'Employee Name',max(nDays) AS 'Maximum Number of Days Off Work'
FROM (
    SELECT employeeID, employeeName , max(difference) as nDays
    FROM (
        SELECT ED1.employeeID as employeeID, ED1.employeeName as employeeName, ED1.data, ED2.data, min(julianday(ED2.data)-julianday(ED1.data)) as difference
        FROM EmployeeDeliveries AS ED1, EmployeeDeliveries AS ED2
        WHERE ED1.employeeID = ED2.employeeID AND ED1.data < ED2.data
        GROUP BY ED1.data)
    GROUP BY employeeID);
