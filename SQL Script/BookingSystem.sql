DELIMITER //
CREATE PROCEDURE CheckBooking(IN book_date DATE, IN table_no INT)
BEGIN
    SET @booking := (SELECT bookingID FROM bookings WHERE bookingDate = book_date AND tableNumber = table_no);
    IF @booking IS NOT NULL THEN
        SELECT CONCAT("Table ", table_no, " is already booked.") AS "Booking Status";
    END IF;
END//
DELIMITER ;

CALL CheckBooking("2022-10-10", 5);

-- ***********************************************************************************************************

DELIMITER //
CREATE PROCEDURE AddValidBooking(
    IN book_date DATE,
    IN table_no INT,
    IN customerId INT,
    IN persons INT
)
BEGIN
    SET @booking := (SELECT bookingID FROM bookings WHERE bookingDate = book_date AND tableNumber = table_no);

    -- Start the transaction
    START TRANSACTION;
    
    -- Generate a new booking ID
    SET @next_book_id := (SELECT MAX(bookingID) FROM bookings) + 1;
    
    -- Insert the new booking record
    INSERT INTO Bookings (bookingID, bookingDate, numberOfGuest, tableNumber, customerID, staffID)   
    VALUES (@next_book_id, book_date, persons, table_no, customerId, 2);

    -- Check if the table is already booked on the given date
    IF @booking THEN
        -- Table is already booked, so rollback the transaction
        ROLLBACK;
        SELECT CONCAT("Table ", table_no, " is already booked. Booking cancelled.") AS "Booking Status";
    ELSE
        -- Table is available, commit the transaction
        COMMIT;
        SELECT CONCAT("Table ", table_no, " is booked for you.") AS "Booking Status";
    END IF;
END//
DELIMITER ;

CALL AddValidBooking('2022-12-17', 6, 4, 3);

-- **************************************************************************************************************************
DELIMITER //
CREATE PROCEDURE AddBooking(
    IN booking_id INT,
    IN customer_id INT,
    IN booking_date DATE,
    IN table_number INT,
    IN persons INT
)
BEGIN
    -- Insert the new booking record
    INSERT INTO bookings (bookingID, bookingDate, numberOfGuest, tableNumber, customerID,  staffID)
    VALUES (booking_id, booking_date, persons, table_number, customer_id, 4);
    
    SELECT "New booking added successfully." AS Message;
END//
DELIMITER ;

CALL AddBooking(8, 4, '2023-07-22', 5, 10);

-- ***************************************************************************************************************

DELIMITER //
CREATE PROCEDURE UpdateBooking(
    IN booking_id INT,
    IN booking_date DATE
)
BEGIN
    -- Update the booking record with the new booking date
    UPDATE bookings
    SET bookingDate = booking_date
    WHERE bookingID = booking_id;
    
    SELECT "Booking updated successfully." AS Message;
END//
DELIMITER ;

CALL UpdateBooking(1, '2023-07-25');

-- ************************************************************************************************************************

DELIMITER //
CREATE PROCEDURE CancelBooking(
    IN booking_id INT
)
BEGIN
    -- Delete the booking record with the specified booking_id
    DELETE FROM bookings
    WHERE bookingID = booking_id;
    
    SELECT "Booking canceled successfully." AS Message;
END//
DELIMITER ;

CALL CancelBooking(1);

