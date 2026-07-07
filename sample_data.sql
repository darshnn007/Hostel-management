-- Sample data for Hostel Management System
-- Inserted in dependency order so foreign-key references remain valid.

INSERT INTO Admin (admin_id, name, email) VALUES
(1, 'Amit Shah', 'amit.admin@example.com'),
(2, 'Neha Patel', 'neha.admin@example.com');

INSERT INTO Staff (staff_id, name, contact_no, working_hours, working_days, salary, role, admin_id) VALUES
(101, 'Rakesh Kumar', '9000000001', 8, 6, 35000.00, 'Warden', 1),
(102, 'Meena Joshi', '9000000002', 8, 6, 22000.00, 'Cleaning_Staff', 1),
(103, 'Vijay Parmar', '9000000003', 8, 6, 28000.00, 'Electrician', 2),
(104, 'Suresh Yadav', '9000000004', 8, 6, 27000.00, 'Plumber', 2);

INSERT INTO Wing (wing_id, wing_name, type, floors, managed_by) VALUES
(1, 'A Wing', 'Boys', 4, 101),
(2, 'B Wing', 'Boys', 3, 101);

INSERT INTO Rooms (room_no, capacity, availability, wing_id) VALUES
(101, 2, 'Occupied', 1),
(102, 2, 'Available', 1),
(201, 3, 'Occupied', 2),
(202, 3, 'Maintenance', 2);

INSERT INTO Student (student_id, name, dob, contact, mail, branch, emergency_contact, father_details, program, year, health_details, room_no) VALUES
(1001, 'Arjun Mehta', '2005-04-12', '9100000001', 'arjun@example.com', 'ICT', '9200000001', 'Rajesh Mehta', 'B.Tech', 2, 'No known allergies', 101),
(1002, 'Kunal Desai', '2005-09-21', '9100000002', 'kunal@example.com', 'CSE', '9200000002', 'Mahesh Desai', 'B.Tech', 2, 'Asthma', 101),
(1003, 'Dev Patel', '2004-11-03', '9100000003', 'dev@example.com', 'ECE', '9200000003', 'Nilesh Patel', 'B.Tech', 3, 'None', 201);

INSERT INTO Visitor (visitor_id, name, contact_no, aadhar_no, stay_duration, check_in, check_out, request_status, visited_student_id) VALUES
(501, 'Rajesh Mehta', '9300000001', '111122223333', 1, '2026-01-10 10:00:00', '2026-01-10 18:00:00', 'Approved', 1001),
(502, 'Mahesh Desai', '9300000002', '444455556666', 2, '2026-01-12 09:30:00', '2026-01-13 17:00:00', 'Approved', 1002);

INSERT INTO Payment (transaction_id, method, amount, date, payment_status, receipt_no) VALUES
(7001, 'UPI', 50000.00, '2026-01-05', 'Paid', 'RCP-7001'),
(7002, 'Bank Transfer', 50000.00, '2026-01-05', 'Pending', 'RCP-7002'),
(7003, 'Cash', 500.00, '2026-01-10', 'Paid', 'RCP-7003');

INSERT INTO Student_Payment (student_id, transaction_id, type, amount) VALUES
(1001, 7001, 'Hostel Fee', 50000.00),
(1002, 7002, 'Hostel Fee', 50000.00);

INSERT INTO Visitor_Payment (visitor_id, transaction_id, type, amount) VALUES
(501, 7003, 'Guest Stay Fee', 500.00);

INSERT INTO Suggestions (suggestion_id, description, visitor_id, approved_by) VALUES
(801, 'Add more seating in the visitor waiting area.', 501, 1);

INSERT INTO Complaint (comp_id, type, status, description, reporting_date, assigned_to, student_id, solved_by) VALUES
(901, 'Electrical', 'Open', 'Tube light not working.', '2026-01-15', 103, 1001, NULL),
(902, 'Plumbing', 'Resolved', 'Water leakage near washbasin.', '2026-01-14', 104, 1003, 104);

INSERT INTO Overnight_Leave (leave_id, request_date, from_date, to_date, return_timestamp, status, student_id, approved_by) VALUES
(10001, '2026-01-18', '2026-01-20', '2026-01-22', NULL, 'Approved', 1001, 101),
(10002, '2026-01-19', '2026-01-25', '2026-01-26', NULL, 'Pending', 1002, NULL);

INSERT INTO Parcel (parcel_id, arrival_date, timestamp, status, received_date, received_by, handover_by) VALUES
(11001, '2026-01-16', '2026-01-16 14:20:00', 'Collected', '2026-01-16', 1001, 101),
(11002, '2026-01-17', '2026-01-17 11:00:00', 'Pending', NULL, 1002, 101);

INSERT INTO Attendance (student_id, date, status) VALUES
(1001, '2026-01-20', 'Present'),
(1002, '2026-01-20', 'Present'),
(1003, '2026-01-20', 'Absent');

INSERT INTO Room_Allocation (student_id, room_no) VALUES
(1001, 101),
(1002, 101),
(1003, 201);

INSERT INTO HMC_Member (student_id, room_no) VALUES
(1003, 201);
