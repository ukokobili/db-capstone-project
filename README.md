# Meta Data Engineering Capstone Project: Little Lemon Database Design
This guided project is part of completing the Meta Data Engineering course, and its main objective is to design and implement a comprehensive database system for Little Lemon Restaurant. Using MySQL Workbench, creating a well-structured database model, which has been deployed as a fully functional MySQL database.

To ensure data security and integrity, developed custom stored procedures that enable secure CRUD operations. These procedures are integrated with transactions, providing a robust mechanism to maintain data consistency during various database interactions.

Additionally, incorporated a feature to generate sales reports, offering valuable insights into the restaurant's performance and customer preferences. The project emphasizes data-driven decision-making and empowers Little Lemon to optimize operations and enhance customer satisfaction.

Throughout the project, the focus has been on creating a scalable and user-friendly database solution that meets the restaurant's specific needs. This project showcases the knowledge and skills in database modeling, stored procedure development, and data analysis, contributing to the successful management of Little Lemon restaurant.
![](https://github.com/ukokobili/db-capstone-project/blob/main/Images/LittleLemonDM.png)

## The modern data stack used in this project includes:

* MySQL Database: We utilized MySQL as the primary database management system. It efficiently stores and manages the structured data for LittleLemon restaurant, enabling reliable data retrieval and manipulation.
```

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
```
![](https://github.com/ukokobili/db-capstone-project/blob/main/Images/AddValidBooking.png)

* Python: Python served as our versatile programming language of choice. We employed it for various data processing, analysis, and integration tasks. Python's rich ecosystem of libraries and frameworks allowed us to streamline data workflows and implement complex algorithms.
```
# require the full name and contact details for every customer 
# that has placed an order greater than $60 for a promotional campaign.
promotional_campaign = """
    SELECT c.firstName, c.lastName, c.phoneNumber, o.totalCost
    FROM customers c
    INNER JOIN bookings b
        ON b.customerID = c.customerID
    INNER JOIN orders o
        ON o.bookingID = b.bookingID
    WHERE o.totalCost > 60;
"""

cursor.execute(promotional_campaign)

results = cursor.fetchall()

print("Information about customers for the purpose of the promotional campaign:")

for i, result in enumerate(results):
    print("Customer no. ", i+1, ": ", result[0], "whose contact is (", result[2], ") has paid ", result[3], "$.")

Information about customers for the purpose of the promotional campaign:
Customer no.  1 :  Pope whose contact is ( 1789236 ) has paid  105.0 $.
Customer no.  2 :  Ken whose contact is ( 1808000 ) has paid  61.0 $.
```

* Tableau: As a powerful Business Intelligence (BI) tool, Tableau facilitated data analysis and visualization. With its intuitive interface and interactive dashboards, we gained valuable insights from the data, enabling us to make data-driven decisions for LittleLemon.
![](https://github.com/ukokobili/db-capstone-project/blob/main/Tableau/LittleLemonDashboard.png)

* GitHub: We leveraged GitHub as our version control tool. Its collaborative features allowed us to manage code changes, work efficiently as a team, and maintain a history of our project's development.

Together, this modern data stack empowered us to create a robust and efficient data solution for LittleLemon restaurant. It exemplifies the synergy between cutting-edge technologies and effective data management practices, fostering success and growth for the restaurant's operations.
