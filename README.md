# Hostel Management System

A relational database project designed to model and manage the major operations of a university hostel. The system covers student accommodation, staff and administration, visitors, payments, complaints, overnight leave, parcels, attendance, room allocation, and suggestions.

This project was developed as part of a Database Management Systems course and focuses on relational schema design, functional dependencies, normalization, integrity constraints, and practical SQL query scenarios.

## Project Overview

The database consists of **16 interconnected tables** representing the core entities and relationships involved in hostel administration. Primary keys, foreign keys, composite keys, `UNIQUE` constraints, and `CHECK` constraints are used to maintain consistency and data integrity.

## Main Modules

- **Student and Room Management** — student records, hostel wings, rooms, availability, and allocation
- **Staff and Administration** — administrators, staff roles, and wing management
- **Visitor Management** — visitor details, stay duration, check-in/check-out, and visit requests
- **Payment Management** — transactions associated with students and visitors
- **Complaint Management** — complaint reporting, staff assignment, status tracking, and resolution
- **Overnight Leave Management** — leave requests, approval, duration, and return details
- **Parcel Management** — parcel arrival, handover, and student collection
- **Attendance Management** — daily student attendance records
- **Suggestions** — visitor suggestions and administrative approval

## Database Design Concepts Used

- Relational schema design
- Functional dependency analysis
- Schema normalization
- Primary and foreign keys
- Composite keys
- Entity relationships
- `UNIQUE` constraints
- `CHECK` constraints
- Referential integrity
- SQL query scenarios

## Repository Structure

```text
Hostel-Management-System/
├── README.md
├── schema.sql
├── sample_data.sql
├── queries.sql
├── functional_dependencies.md
├── normalization.md
└── diagrams/
    └── er-diagram.md
```

## How to Use

1. Create an empty SQL database.
2. Run `schema.sql` to create the tables.
3. Run `sample_data.sql` to insert demonstration data.
4. Run the statements in `queries.sql` to test common hostel-management scenarios.

> The SQL is written using standard relational database concepts. Minor syntax changes may be required depending on the DBMS used.

## Current Scope

This repository contains the database-design portion of the Hostel Management System. It does not include a frontend or backend application.

## Possible Future Improvements

- Add authentication and role-based access
- Connect the database to a backend API
- Build dashboards for administrators, wardens, and students
- Add automated room-allocation logic
- Add payment and attendance reports
- Add indexes after testing realistic workloads
