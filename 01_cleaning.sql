-- Remove transactions with no CustomerID 
DELETE FROM retail WHERE CustomerID IS NULL;

-- Remove cancelled orders 
DELETE FROM retail WHERE Invoice LIKE 'C%';
