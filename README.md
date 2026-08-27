# 🚕 Ola Ride Bookings Analysis

A SQL-based analysis of ride-booking data — covering successful bookings, cancellations, incomplete rides, and customer/vehicle-level performance metrics.

## 🛠️ Tools Used
- MySQL

## 📊 What the Analysis Covers 
- **10+ business-driven SQL queries and views**
- Successful bookings vs. cancellations (**customer-initiated vs. driver-initiated**)
- Reasons behind **incomplete rides**
- **Average ride distance and rating by vehicle type**
- **Top 5 customers** by ride activity
- **Total successful booking value**

## 🔍 Techniques Used
- `GROUP BY` and aggregate functions (`AVG`, `SUM`, `COUNT`, `MAX`/`MIN`)
- Filtering and conditional logic with `WHERE`, `CASE`
- Joins across booking, customer, and vehicle tables
- Views for reusable business-metric queries

## 📈 Key Insight
Segmenting cancellations by who initiated them (customer vs. driver) surfaces very different root causes — useful for separately addressing demand-side vs. supply-side issues in ride reliability.

## 📁 Files
- `ola_ride_analysis.sql` — all queries and views used in the analysis


## 💻 Sample Query

```sql
-- Average ride distance and rating by vehicle type
SELECT
    vehicle_type,
    AVG(ride_distance) AS avg_distance,
    AVG(customer_rating) AS avg_rating
FROM ride_bookings
WHERE booking_status = 'Success'
GROUP BY vehicle_type
ORDER BY avg_distance DESC;
```

---
📫 Questions or feedback? Reach me at anuragrajputetw@gmail.com
