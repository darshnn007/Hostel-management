# Normalization Analysis

## Objective

Normalization reduces redundancy and helps prevent insertion, update, and deletion anomalies. The current Hostel Management System schema separates major real-world concepts into individual relations and uses keys to connect them.

## First Normal Form (1NF)

A relation is in 1NF when:

- each column stores atomic values,
- there are no repeating groups,
- each row can be uniquely identified.

The schema generally satisfies 1NF because attributes such as student name, room number, payment status, complaint description, and attendance status are stored as individual values, while each table has a primary key or composite primary key.

## Second Normal Form (2NF)

A relation is in 2NF when:

- it is already in 1NF, and
- every non-key attribute depends on the whole candidate key.

Most tables use a single-column primary key, so partial dependency does not arise.

The relations with composite keys are:

- `Visitor_Payment(visitor_id, transaction_id, type, amount)`
- `Student_Payment(student_id, transaction_id, type, amount)`
- `Attendance(student_id, date, status)`
- `Room_Allocation(student_id, room_no)`
- `HMC_Member(student_id, room_no)`

For example, in `Attendance`, the status of a student is determined for a particular date:

`(student_id, date) → status`

Therefore, `status` depends on the complete composite key.

## Third Normal Form (3NF)

A relation is in 3NF when:

- it is already in 2NF, and
- non-key attributes do not depend transitively on a candidate key through another non-key attribute.

The schema separates major concepts into independent tables:

- administrator data is stored in `Admin`,
- staff data is stored in `Staff`,
- wing data is stored in `Wing`,
- room data is stored in `Rooms`,
- student data is stored in `Student`,
- payment transaction data is stored in `Payment`,
- complaints are stored in `Complaint`,
- leave requests are stored in `Overnight_Leave`.

This separation reduces repeated storage of related entity details. For example, `Student` stores only a room reference instead of repeatedly storing wing details, and `Complaint` stores staff identifiers instead of staff names and salaries.

## BCNF Discussion

Many relations are also consistent with BCNF because their non-trivial functional dependencies have a candidate key on the left-hand side.

Examples:

- `admin_id → name, email`
- `staff_id → staff attributes`
- `wing_id → wing attributes`
- `room_no → room attributes`
- `student_id → student attributes`
- `transaction_id → payment attributes`
- `(student_id, date) → status`

## Redundancy and Improvement Opportunities

### 1. Duplicate room-allocation representation

The current schema stores room assignment in both:

- `Student.room_no`
- `Room_Allocation(student_id, room_no)`

This can cause an update anomaly. A student's room could be changed in one place but not the other.

**Recommended approach:** choose one source of truth.

- For only current allocation, keep `Student.room_no` and remove `Room_Allocation`; or
- for allocation history, redesign `Room_Allocation` with fields such as `allocation_id`, `student_id`, `room_no`, `from_date`, and `to_date`, and remove `Student.room_no`.

### 2. Payment amount duplication

`Payment` stores `amount`, while both `Student_Payment` and `Visitor_Payment` also store `amount`.

If these attributes represent the same transaction amount, the value is duplicated and may become inconsistent.

**Recommended approach:** store the transaction amount only in `Payment`, unless the junction-table amount has a distinct business meaning.

### 3. Missing visitor-to-student foreign key

`Visitor.visited_student_id` logically identifies the student being visited, but the current DDL does not declare a foreign key.

**Recommended change:**

```sql
FOREIGN KEY (visited_student_id) REFERENCES Student(student_id)
```

## Conclusion

The schema demonstrates the main stages of normalization by separating hostel entities into related tables and using primary and foreign keys to preserve relationships. The design is broadly structured around 3NF principles, while the duplicate room-allocation and payment-amount fields are useful examples of areas that can be refined further.
