CREATE TABLE Admin (
    admin_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_no VARCHAR(15),
    working_hours INT,
    working_days INT,
    salary DECIMAL(10,2),
    role VARCHAR(30) CHECK (role IN ('Cleaning_Staff', 'Carpenter', 'Plumber', 'Electrician', 'Warden')),
    admin_id INT,
    FOREIGN KEY (admin_id) REFERENCES Admin(admin_id)
);


CREATE TABLE Wing (
    wing_id INT PRIMARY KEY,
    wing_name VARCHAR(100) NOT NULL,
    type VARCHAR(50),
    floors INT,
    managed_by INT,
    FOREIGN KEY (managed_by) REFERENCES Staff(staff_id)
);

CREATE TABLE Rooms (
    room_no INT PRIMARY KEY,
    capacity INT CHECK (capacity > 0),
    availability VARCHAR(20) CHECK (availability IN ('Available', 'Occupied', 'Maintenance')),
    wing_id INT,
    FOREIGN KEY (wing_id) REFERENCES Wing(wing_id)
);

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    contact VARCHAR(15) UNIQUE,
    mail VARCHAR(100) UNIQUE,
    branch VARCHAR(100),
    emergency_contact VARCHAR(15),
    father_details VARCHAR(100),
    program VARCHAR(100),
    year INT,
    health_details VARCHAR(255),
    room_no INT,
    FOREIGN KEY (room_no) REFERENCES Rooms(room_no)
);

CREATE TABLE Visitor (
    visitor_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_no VARCHAR(15),
    aadhar_no VARCHAR(20) UNIQUE,
    stay_duration INT,
    check_in TIMESTAMP,
    check_out TIMESTAMP,
    request_status VARCHAR(50),
    visited_student_id INT
);

CREATE TABLE Payment (
    transaction_id INT PRIMARY KEY,
    method VARCHAR(50),
    amount DECIMAL(10,2),
    date DATE,
    payment_status VARCHAR(20) CHECK (payment_status IN ('Pending', 'Paid', 'Failed')),
    receipt_no VARCHAR(50) UNIQUE
);

CREATE TABLE Visitor_Payment (
    visitor_id INT,
    transaction_id INT,
    type VARCHAR(50),
    amount DECIMAL(10,2),
    PRIMARY KEY (visitor_id, transaction_id),
    FOREIGN KEY (visitor_id) REFERENCES Visitor(visitor_id),
    FOREIGN KEY (transaction_id) REFERENCES Payment(transaction_id)
);

CREATE TABLE Student_Payment (
    student_id INT,
    transaction_id INT,
    type VARCHAR(50),
    amount DECIMAL(10,2),
    PRIMARY KEY (student_id, transaction_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (transaction_id) REFERENCES Payment(transaction_id)
);

CREATE TABLE Suggestions (
    suggestion_id INT PRIMARY KEY,
    description VARCHAR(255),
    visitor_id INT,
    approved_by INT,
    FOREIGN KEY (visitor_id) REFERENCES Visitor(visitor_id),
    FOREIGN KEY (approved_by) REFERENCES Admin(admin_id)
);

CREATE TABLE Complaint (
    comp_id INT PRIMARY KEY,
    type VARCHAR(50),
    status VARCHAR(50),
    description VARCHAR(255),
    reporting_date DATE,
    assigned_to INT,
    student_id INT,
    solved_by INT,
    FOREIGN KEY (assigned_to) REFERENCES Staff(staff_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (solved_by) REFERENCES Staff(staff_id)
);

CREATE TABLE Overnight_Leave (
    leave_id INT PRIMARY KEY,
    request_date DATE,
    from_date DATE,
    to_date DATE,
    CHECK (from_date <= to_date),
    return_timestamp TIMESTAMP,
    status VARCHAR(50),
    student_id INT,
    approved_by INT,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (approved_by) REFERENCES Staff(staff_id)
);

CREATE TABLE Parcel (
    parcel_id INT PRIMARY KEY,
    arrival_date DATE,
    timestamp TIMESTAMP,
    status VARCHAR(50),
    received_date DATE,
    received_by INT,
    handover_by INT,
    FOREIGN KEY (received_by) REFERENCES Student(student_id),
    FOREIGN KEY (handover_by) REFERENCES Staff(staff_id)
);

CREATE TABLE Attendance (
    student_id INT,
    date DATE,
    status VARCHAR(20),
    PRIMARY KEY (student_id, date),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE Room_Allocation (
    student_id INT,
    room_no INT,
    PRIMARY KEY (student_id, room_no),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (room_no) REFERENCES Rooms(room_no)
);

CREATE TABLE HMC_Member (
    student_id INT,
    room_no INT,
    PRIMARY KEY (student_id, room_no),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (room_no) REFERENCES Rooms(room_no)
);

