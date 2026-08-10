-- Remove transactions with no CustomerID (can't attribute to a specific customer)
DELETE FROM retail WHERE CustomerID IS NULL;

-- Remove cancelled orders (Invoice numbers starting with 'C')
DELETE FROM retail WHERE Invoice LIKE 'C%';
