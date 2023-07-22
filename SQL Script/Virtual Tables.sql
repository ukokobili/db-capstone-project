-- create a virtual table called OrdersView
CREATE VIEW OrdersView AS
Select 
	OrderID, 
	Quantity,
	TotalCost
from Orders
where Quantity > 2;

Select * from OrdersView;

-- Extract the required information from each of the following tables by using the relevant JOIN clause
select  
	c.CustomerID,
	c.FullName,
    o.OrderID,
    o.TotalCost,
    m.MenuName, 
    i.CourseName,
    i.StaterName
from orders o 
left join customers c 
on o.CustomerID = c.CustomerID
left join menus m on o.MenuID = m.MenuID
left join menuitems i on m.MenuItemID = i.MenuItemID
where o.TotalCost > 150;

-- creating a subquery that lists the menu names from the menus table for any order quantity with more than 2.
select MenuName
from menus 
where exists (select m.MenuName from menus m inner join orders o 
											on m.MenuID = o.OrderID where o.Quantity > 2);