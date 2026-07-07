-- Practical SQL query scenarios for the Hostel Management System

-- 1. Find all currently available rooms with wing details.
SELECT r.room_no, r.capacity, w.wing_name, w.type
FROM Rooms r
JOIN Wing w ON r.wing_id = w.wing_id
WHERE r.availability = 'Available';

-- 2. List students with their room and wing.
SELECT s.student_id, s.name, s.branch, s.room_no, w.wing_name
FROM Student s
JOIN Rooms r ON s.room_no = r.room_no
JOIN Wing w ON r.wing_id = w.wing_id
ORDER BY w.wing_name, s.room_no;

-- 3. Count students living in each wing.
SELECT w.wing_name, COUNT(s.student_id) AS student_count
FROM Wing w
LEFT JOIN Rooms r ON w.wing_id = r.wing_id
LEFT JOIN Student s ON r.room_no = s.room_no
GROUP BY w.wing_id, w.wing_name;

-- 4. Find unresolved complaints with assigned staff details.
SELECT c.comp_id, c.type, c.description, c.reporting_date,
       s.name AS student_name, st.name AS assigned_staff
FROM Complaint c
JOIN Student s ON c.student_id = s.student_id
LEFT JOIN Staff st ON c.assigned_to = st.staff_id
WHERE c.status <> 'Resolved'
ORDER BY c.reporting_date;

-- 5. Count complaints assigned to each staff member.
SELECT st.staff_id, st.name, COUNT(c.comp_id) AS assigned_complaints
FROM Staff st
LEFT JOIN Complaint c ON st.staff_id = c.assigned_to
GROUP BY st.staff_id, st.name
ORDER BY assigned_complaints DESC;

-- 6. Find students with pending payments.
SELECT s.student_id, s.name, p.transaction_id, sp.type, p.amount, p.payment_status
FROM Student s
JOIN Student_Payment sp ON s.student_id = sp.student_id
JOIN Payment p ON sp.transaction_id = p.transaction_id
WHERE p.payment_status = 'Pending';

-- 7. Calculate total paid amount by each student.
SELECT s.student_id, s.name, COALESCE(SUM(p.amount), 0) AS total_paid
FROM Student s
LEFT JOIN Student_Payment sp ON s.student_id = sp.student_id
LEFT JOIN Payment p
    ON sp.transaction_id = p.transaction_id
   AND p.payment_status = 'Paid'
GROUP BY s.student_id, s.name
ORDER BY total_paid DESC;

-- 8. List pending overnight-leave requests.
SELECT ol.leave_id, s.name, ol.from_date, ol.to_date, ol.request_date
FROM Overnight_Leave ol
JOIN Student s ON ol.student_id = s.student_id
WHERE ol.status = 'Pending'
ORDER BY ol.request_date;

-- 9. Find students currently expected to be on approved overnight leave.
-- Replace CURRENT_DATE if your DBMS uses a different current-date function.
SELECT s.student_id, s.name, ol.from_date, ol.to_date
FROM Overnight_Leave ol
JOIN Student s ON ol.student_id = s.student_id
WHERE ol.status = 'Approved'
  AND CURRENT_DATE BETWEEN ol.from_date AND ol.to_date;

-- 10. Show pending parcels with student details.
SELECT p.parcel_id, p.arrival_date, p.timestamp,
       s.student_id, s.name, s.room_no
FROM Parcel p
JOIN Student s ON p.received_by = s.student_id
WHERE p.status = 'Pending'
ORDER BY p.arrival_date;

-- 11. Calculate attendance percentage for each student.
SELECT s.student_id, s.name,
       ROUND(
           100.0 * SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END)
           / NULLIF(COUNT(a.date), 0),
           2
       ) AS attendance_percentage
FROM Student s
LEFT JOIN Attendance a ON s.student_id = a.student_id
GROUP BY s.student_id, s.name;

-- 12. Display visitor history with the student visited.
SELECT v.visitor_id, v.name AS visitor_name,
       s.name AS student_name, v.check_in, v.check_out, v.request_status
FROM Visitor v
LEFT JOIN Student s ON v.visited_student_id = s.student_id
ORDER BY v.check_in DESC;

-- 13. Find staff members responsible for hostel wings.
SELECT w.wing_name, st.staff_id, st.name, st.role
FROM Wing w
JOIN Staff st ON w.managed_by = st.staff_id;

-- 14. Find rooms whose recorded student count has reached or exceeded capacity.
SELECT r.room_no, r.capacity, COUNT(s.student_id) AS occupied_beds
FROM Rooms r
LEFT JOIN Student s ON r.room_no = s.room_no
GROUP BY r.room_no, r.capacity
HAVING COUNT(s.student_id) >= r.capacity;

-- 15. Show all payments in a unified report.
SELECT p.transaction_id, 'Student' AS payer_type,
       CAST(sp.student_id AS VARCHAR(50)) AS payer_id,
       sp.type, p.amount, p.date, p.payment_status
FROM Payment p
JOIN Student_Payment sp ON p.transaction_id = sp.transaction_id

UNION ALL

SELECT p.transaction_id, 'Visitor' AS payer_type,
       CAST(vp.visitor_id AS VARCHAR(50)) AS payer_id,
       vp.type, p.amount, p.date, p.payment_status
FROM Payment p
JOIN Visitor_Payment vp ON p.transaction_id = vp.transaction_id;
