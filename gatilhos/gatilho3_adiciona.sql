CREATE TRIGGER employeeEvaluation
AFTER INSERT ON Delivery
FOR EACH ROW
BEGIN
    UPDATE Employee SET evaluation = 
        (SELECT sum(Delivery.evaluation)/count(*)
        FROM Delivery 
        WHERE NEW.employeeID = Delivery.employeeID
        GROUP BY Delivery.employeeID)

    WHERE NEW.employeeID=Employee.id;
END;
