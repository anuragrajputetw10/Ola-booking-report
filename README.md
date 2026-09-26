# 🚕 Ola Ride Bookings Analysis

A SQL-based analysis of Ola ride-booking data — covering successful bookings, cancellations, incomplete rides, and customer/vehicle-level performance metrics. Built entirely in MySQL, using queries and views to turn raw booking records into business-ready insights.

## 📌 Overview

This project analyzes ride-booking data to understand:
- How many bookings succeed vs. get cancelled, and by whom
- Why rides go incomplete
- How different vehicle types perform on distance and rating
- Who the most valuable customers are
- How much revenue successful bookings generate

The queries are written to be reusable — several are saved as views so the same business metrics can be pulled on demand.

## 🛠️ Tools Used

- **MySQL** — data storage, querying, and analysis

## 📊 What the Analysis Covers

- 10+ business-driven SQL queries and views
- Successful bookings vs. cancellations (customer-initiated vs. driver-initiated)
- Reasons behind incomplete rides
- Average ride distance and rating by vehicle type
- Top 5 customers by ride activity
- Total successful booking value

## 🔍 Techniques Used

- `GROUP BY` and aggregate functions (`AVG`, `SUM`, `COUNT`, `MAX`/`MIN`)
- Filtering and conditional logic with `WHERE`, `CASE`
- Joins across booking, customer, and vehicle tables
- Views for reusable business-metric queries

## 📈 Key Insight

Segmenting cancellations by who initiated them (customer vs. driver) surfaces very different root causes — useful for separately addressing demand-side vs. supply-side issues in ride reliability.

## 📁 Repository Contents

| File | Description |
|---|---|
| `Ola Bookings Report.sql` | All queries and views used in the analysis |
| `Sql-1-2.png` – `Sql-9-10.png` | Output screenshots for each pair of queries below, in order |

## 🗂️ Assumed Schema

Queries below assume a single `ride_bookings` table shaped like this — adjust names to match your actual table if they differ:

| Column | Description |
|---|---|
| `booking_id` | Unique ride/booking identifier |
| `booking_date`, `booking_time` | When the booking was made |
| `customer_id` | Unique customer identifier |
| `vehicle_type` | Mini, Prime, Auto, Bike, etc. |
| `booking_status` | `Success`, `Cancelled by Customer`, `Cancelled by Driver`, `Incomplete` |
| `incomplete_rides_reason` | Reason logged when a ride doesn't complete |
| `pickup_location`, `drop_location` | Trip endpoints |
| `ride_distance` | Distance travelled (km) |
| `booking_value` | Fare/revenue for the booking |
| `customer_rating`, `driver_rating` | Post-ride ratings |
| `payment_method` | Cash, UPI, Card, Wallet, etc. |

## 💼 Business Questions & SQL Solutions

**1. What share of bookings succeed vs. get cancelled or left incomplete?**
```sql
SELECT
    booking_status,
    COUNT(*) AS total_bookings,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct_of_total
FROM ride_bookings
GROUP BY booking_status
ORDER BY total_bookings DESC;
```
*Gives a one-glance breakdown of booking outcomes as a share of all rides.*

**2. Customer-initiated vs. driver-initiated cancellations — which is the bigger problem?**
```sql
SELECT
    booking_status,
    COUNT(*) AS cancelled_rides
FROM ride_bookings
WHERE booking_status IN ('Cancelled by Customer', 'Cancelled by Driver')
GROUP BY booking_status;
```
*Separates demand-side cancellations (customer changed their mind) from supply-side ones (driver backed out) so each can be tackled differently.*

**3. What are the top reasons rides go incomplete?**
```sql
SELECT
    incomplete_rides_reason,
    COUNT(*) AS occurrences
FROM ride_bookings
WHERE booking_status = 'Incomplete'
GROUP BY incomplete_rides_reason
ORDER BY occurrences DESC;
```
*Surfaces operational issues (e.g. vehicle breakdown, customer unreachable) worth fixing first.*

**4. Average ride distance and customer rating by vehicle type**
```sql
SELECT
    vehicle_type,
    ROUND(AVG(ride_distance), 2) AS avg_distance,
    ROUND(AVG(customer_rating), 2) AS avg_rating
FROM ride_bookings
WHERE booking_status = 'Success'
GROUP BY vehicle_type
ORDER BY avg_distance DESC;
```
*Shows which vehicle categories are used for longer trips and how satisfied customers are with each.*

**5. Who are the top 5 customers by ride activity?**
```sql
SELECT
    customer_id,
    COUNT(*) AS total_rides
FROM ride_bookings
WHERE booking_status = 'Success'
GROUP BY customer_id
ORDER BY total_rides DESC
LIMIT 5;
```
*Identifies the most engaged riders — useful for loyalty programs or churn monitoring.*

**6. What is the total revenue from successful bookings?**
```sql
SELECT
    SUM(booking_value) AS total_successful_booking_value
FROM ride_bookings
WHERE booking_status = 'Success';
```
*A single headline revenue figure for reporting.*

**7. How does revenue break down by payment method?**
```sql
SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    SUM(booking_value) AS total_revenue
FROM ride_bookings
WHERE booking_status = 'Success'
GROUP BY payment_method
ORDER BY total_revenue DESC;
```
*Highlights which payment channels drive the most volume and revenue.*

**8. Which vehicle type generates the most revenue per ride?**
```sql
SELECT
    vehicle_type,
    ROUND(AVG(booking_value), 2) AS avg_revenue_per_ride,
    COUNT(*) AS total_rides
FROM ride_bookings
WHERE booking_status = 'Success'
GROUP BY vehicle_type
ORDER BY avg_revenue_per_ride DESC;
```
*Helps compare vehicle categories on efficiency, not just volume.*

**9. How do driver ratings compare across vehicle types?**
```sql
SELECT
    vehicle_type,
    ROUND(AVG(driver_rating), 2) AS avg_driver_rating,
    COUNT(*) AS total_rides
FROM ride_bookings
WHERE booking_status = 'Success'
GROUP BY vehicle_type
ORDER BY avg_driver_rating DESC;
```
*Flags vehicle segments where driver service quality may need attention.*

**10. Reusable view: successful bookings summary**
```sql
CREATE VIEW vw_successful_bookings_summary AS
SELECT
    vehicle_type,
    COUNT(*) AS total_rides,
    ROUND(AVG(ride_distance), 2) AS avg_distance,
    ROUND(AVG(booking_value), 2) AS avg_booking_value,
    ROUND(AVG(customer_rating), 2) AS avg_customer_rating
FROM ride_bookings
WHERE booking_status = 'Success'
GROUP BY vehicle_type;
```
*Packages the most-used metrics into a view so they can be queried directly without rewriting the logic each time.*

## 🚀 How to Use

1. Clone this repository
2. Set up a MySQL database and create/import a `ride_bookings` table matching the schema used in `Ola Bookings Report.sql`
3. Run the script in MySQL Workbench (or your client of choice) to recreate the queries and views
4. Adapt the queries to your own dataset as needed

## 📫 Contact

Questions or feedback? Reach out at anuragrajputetw@gmail.com
