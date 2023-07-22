-- 
DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(Quantity) AS `Max Qty in Order` FROM orders;
END //

DELIMITER ;

CALL GetMaxQuantity();

--
DELIMITER //

CREATE PROCEDURE GetOrderDetail(IN customer_id INT)
BEGIN
    SET @query = 'SELECT OrderID, Quantity, TotalCost
                  FROM orders
                  WHERE CustomerID = ?';

    PREPARE GetOrderDetail FROM @query;
END //

DELIMITER ;

-- Set the input value
SET @id = 1;

-- Call the prepared statement
EXECUTE GetOrderDetail USING @id;


