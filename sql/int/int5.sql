.mode	columns
.headers	on
.nullvalue	NULL

.print ' '
.print '5. Indique por avaliação das entregas (por exemplo de 3-3.9) , o número total de avaliações feitas e qual o número total de entregas cujo atraso foi menor que meia hora.'
.print ' '

SELECT Ev as 'Rounded Evaluation', numberOfEvals as 'Number of evaluations', ifnull(delayLowerThanThirtyM,0) as 'Number of Deliveries which delay was lower than 30 minutes'
FROM (
    SELECT round(evaluation) as Ev, count(code) as numberOfEvals
    FROM Delivery
    GROUP BY (Ev)
    ) AS NewDelivery 
    LEFT JOIN  (
    SELECT round(evaluation) as Eval, count(evaluation) as delayLowerThanThirtyM 
    FROM Delivery
    GROUP BY round(evaluation)
    HAVING julianday( strftime('%H:%M', (julianday(arrivalTime)-julianday(scheduledTime)+julianday('00:00')) ) ) - julianday('00:30') <=0.0
) as DelayFromDelivery 
ON NewDelivery.Ev=DelayFromDelivery.Eval;