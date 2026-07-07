# Functional Dependencies

This document summarizes the main functional dependencies implied by the current database schema.

## Admin

**Relation:** `Admin(admin_id, name, email)`

- `admin_id → name, email`
- `email → admin_id, name` because `email` is unique

Candidate keys: `admin_id`, `email`

## Staff

**Relation:** `Staff(staff_id, name, contact_no, working_hours, working_days, salary, role, admin_id)`

- `staff_id → name, contact_no, working_hours, working_days, salary, role, admin_id`

Candidate key: `staff_id`

## Wing

**Relation:** `Wing(wing_id, wing_name, type, floors, managed_by)`

- `wing_id → wing_name, type, floors, managed_by`

Candidate key: `wing_id`

## Rooms

**Relation:** `Rooms(room_no, capacity, availability, wing_id)`

- `room_no → capacity, availability, wing_id`

Candidate key: `room_no`

## Student

**Relation:** `Student(student_id, name, dob, contact, mail, branch, emergency_contact, father_details, program, year, health_details, room_no)`

- `student_id → name, dob, contact, mail, branch, emergency_contact, father_details, program, year, health_details, room_no`
- `contact → student_id, name, dob, mail, branch, emergency_contact, father_details, program, year, health_details, room_no`
- `mail → student_id, name, dob, contact, branch, emergency_contact, father_details, program, year, health_details, room_no`

Candidate keys: `student_id`, `contact`, `mail`

## Visitor

**Relation:** `Visitor(visitor_id, name, contact_no, aadhar_no, stay_duration, check_in, check_out, request_status, visited_student_id)`

- `visitor_id → name, contact_no, aadhar_no, stay_duration, check_in, check_out, request_status, visited_student_id`
- `aadhar_no → visitor_id, name, contact_no, stay_duration, check_in, check_out, request_status, visited_student_id`

Candidate keys: `visitor_id`, `aadhar_no`

## Payment

**Relation:** `Payment(transaction_id, method, amount, date, payment_status, receipt_no)`

- `transaction_id → method, amount, date, payment_status, receipt_no`
- `receipt_no → transaction_id, method, amount, date, payment_status`

Candidate keys: `transaction_id`, `receipt_no`

## Visitor_Payment

**Relation:** `Visitor_Payment(visitor_id, transaction_id, type, amount)`

- `(visitor_id, transaction_id) → type, amount`

Candidate key: `(visitor_id, transaction_id)`

## Student_Payment

**Relation:** `Student_Payment(student_id, transaction_id, type, amount)`

- `(student_id, transaction_id) → type, amount`

Candidate key: `(student_id, transaction_id)`

## Suggestions

**Relation:** `Suggestions(suggestion_id, description, visitor_id, approved_by)`

- `suggestion_id → description, visitor_id, approved_by`

Candidate key: `suggestion_id`

## Complaint

**Relation:** `Complaint(comp_id, type, status, description, reporting_date, assigned_to, student_id, solved_by)`

- `comp_id → type, status, description, reporting_date, assigned_to, student_id, solved_by`

Candidate key: `comp_id`

## Overnight_Leave

**Relation:** `Overnight_Leave(leave_id, request_date, from_date, to_date, return_timestamp, status, student_id, approved_by)`

- `leave_id → request_date, from_date, to_date, return_timestamp, status, student_id, approved_by`

Candidate key: `leave_id`

## Parcel

**Relation:** `Parcel(parcel_id, arrival_date, timestamp, status, received_date, received_by, handover_by)`

- `parcel_id → arrival_date, timestamp, status, received_date, received_by, handover_by`

Candidate key: `parcel_id`

## Attendance

**Relation:** `Attendance(student_id, date, status)`

- `(student_id, date) → status`

Candidate key: `(student_id, date)`

## Room_Allocation

**Relation:** `Room_Allocation(student_id, room_no)`

The current schema defines the whole pair as the primary key:

- `(student_id, room_no) → ∅`

Candidate key: `(student_id, room_no)`

If the business rule is that a student can have only one current room, then `student_id → room_no` should also hold and `student_id` should be unique.

## HMC_Member

**Relation:** `HMC_Member(student_id, room_no)`

- `(student_id, room_no) → ∅`

Candidate key: `(student_id, room_no)`

## Design Notes

1. `Visitor.visited_student_id` logically references `Student.student_id`, but the current DDL does not declare that foreign key.
2. Current room assignment is represented both by `Student.room_no` and `Room_Allocation`, which may create redundant data.
3. `amount` appears in both `Payment` and the payment junction tables. If both values represent the same amount, this is another redundancy that should be removed or clearly justified.
