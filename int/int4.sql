.mode	columns
.headers	on
.nullvalue	NULL

.print ' '
.print '4. Top três compradores da aplicação (com a percentagem de dinheiro gasto).'
.print ' '

SELECT Client.id as 'Client ID', Client.name as 'Client Name', sum(Request.price) as 'Money Spent', printf('%f %', 100 * sum(Request.price) / (
     SELECT sum(Request.price)
     FROM Request
     )) as 'Money Percentage'
FROM Client JOIN Request
ON Client.id = Request.clientID
GROUP BY Client.id
ORDER BY sum(Request.price) DESC
LIMIT 3;
