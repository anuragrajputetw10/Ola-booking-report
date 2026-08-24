use ola ;

SELECT count(*)
FROM bookings;

SELECT *
FROM bookings;


# 1. To find all successful bookings:
CREATE VIEW Successful_Bookings As
SELECT *
FROM bookings
WHERE Booking_Status ='Success' ;

SELECT *
FROM Successful_Bookings;

# 2. Find Average ride distance for each vehicle type:
CREATE VIEW ride_distance_for_each_vehicle as 
SELECT Vehicle_Type, avg(Ride_Distance) as avg_distance
FROM bookings
GROUP BY Vehicle_Type;

SELECT *
FROM ride_distance_for_each_vehicle ;

# 3. Find Total no. of cancelled rides by customers:
CREATE VIEW cancelled_rides_by_customers as

SELECT count(*)
FROM bookings
WHERE Booking_Status = 'Canceled by Customer' ;

SELECT *
FROM cancelled_rides_by_customers ;

# 4. Top 5 customers who booked most no. of rides:
CREATE VIEW Top_5_customers as

SELECT Customer_ID, COUNT(Booking_ID) as total_rides
FROM bookings
GROUP BY Customer_ID
ORDER BY total_rides DESC limit 5 ;

SELECT *
FROM Top_5_customers;

# 5. NO. OF RIDES CANCELLED BY DRIVERS DUE TO PERSONAL OR CAR RELATED ISSUE
CREATE VIEW Rides_Canceled_by_Driver as
SELECT count(*)
FROM bookings
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue' ;

SELECT *
FROM Rides_Canceled_by_Driver;

# 6. Maximum and minimum driver ratings for Prime Sedan bookings:
CREATE VIEW max_min_driver_ratings as 
SELECT max(Driver_Ratings) as max_rating,
min(Driver_Ratings) as min_rating
FROM bookings
WHERE Vehicle_Type = 'Prime Sedan';

SELECT *
FROM max_min_driver_ratings;

# 7. Retrieve all rides where payment is done via UPI :
CREATE VIEW UPI_payment as
SELECT *
FROM bookings
WHERE Payment_Method = 'UPI';

SELECT *
FROM UPI_payment;

# 8. Find the average customer rating per vehicle type :
CREATE VIEW avg_cust_rating as
SELECT Vehicle_Type, avg(Customer_Rating) as avg_customer_rating
FROM bookings
GROUP BY Vehicle_Type ;

SELECT *
FROM avg_cust_rating;

# 9. Calculate the total booking value of rides completed successfully:
CREATE VIEW total_successful_ride_value as
SELECT sum(Booking_Value) as total_successful_booking
FROM bookings
WHERE Booking_Status = 'Success' ;

SELECT *
FROM total_successful_ride_value;

# 10. List all incomplete rides along with the reasons:
CREATE VIEW Incomplete_Rides_Reason AS
SELECT Booking_ID, Incomplete_Rides_Reason
FROM bookings
WHERE Incomplete_Rides = 'Yes'
;

SELECT *
FROM Incomplete_Rides_Reason;
















