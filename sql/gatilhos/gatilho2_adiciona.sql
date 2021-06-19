CREATE TRIGGER validScheduledTime
BEFORE INSERT ON Delivery
FOR EACH ROW
BEGIN
    SELECT
        CASE
            WHEN NOT EXISTS (
                SELECT 1
                FROM Request JOIN Restaurant JOIN RestaurantPeriod
                ON Request.restaurantID=Restaurant.id 
                    AND Restaurant.id = RestaurantPeriod.restaurantID
                WHERE NEW.code = Request.code AND julianday(NEW.scheduledTime) >= julianday( printf('%d:00', RestaurantPeriod.openTime) )
                    AND julianday(NEW.scheduledTime) <= julianday( printf('%d:00', RestaurantPeriod.closeTime) )
            )
            THEN RAISE(ABORT, 'Invalid Scheduled Time')
        END;
END;
