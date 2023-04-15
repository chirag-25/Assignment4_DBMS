-- drop database NEEV2;
create database NEEV2;
use NEEV2;

create table admin_password(
	EmployeeID varchar(8) primary key,
    EmployeePassword varchar(64)
);

create table staff_password(
	EmployeeID varchar(8) primary key,
    EmployeePassword varchar(64)
);

insert into admin_password(EmployeeID,EmployeePassword)
values ("1","GFfK65EW785wzCKaAA");

-- done
create table Trainers (
email_id varchar(50) primary key,
fee int default null,
name varchar(50) not null,
age int not null,
gender enum('Male', 'Female', 'Others') not null
);

-- drop table Trainers;


create table Beneficiary (
aadhar_id bigint primary key,
name varchar(50) not null,
date_of_birth date not null,
gender enum('Male', 'Female', 'Others') not null,
marital_status varchar(10) not null,
education varchar(50) not null,
photo longblob default null,
employed varchar(20) default null,
photo_caption VARCHAR(255) DEFAULT NULL
);


create table Teams (
employee_id varchar(20) primary key,
name varchar(50) not null,
email_id varchar(50) unique,
salary int not null,
position varchar(50) not null,
year_of_joining date not null,
year_of_leaving date default null,
reason_of_leaving text default null,
profile_photo longblob default null
);

INSERT INTO Teams (employee_id, name, email_id, salary, position, year_of_joining, year_of_leaving, reason_of_leaving, profile_photo) VALUES
('1', 'Ravi Kumar', 'ravi.kumar@example.com', 50000, 'Admin', '2015-01-01', null, null, null);
create table Projects (
event_name varchar(50),
start_date date,
primary key (event_name, start_date),
types varchar(50) not null,
budget int not null,
no_of_participants int not null,
duration int not null,
collection int default null,
total_expense int not null
);

CREATE TABLE ProjectPhotos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  project_event_name VARCHAR(50),
  project_start_date DATE,
  photo_url longblob default NULL,
  caption VARCHAR(255) DEFAULT NULL,
  FOREIGN KEY (project_event_name, project_start_date)
	REFERENCES Projects(event_name, start_date)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


create table Volunteers (
email_id varchar(50) primary key,
name varchar(50) not null,
phone_number bigint not null,
date_of_birth date default null,
gender enum('Male', 'Female', 'Others') not null
);

create table Funding (
email_id varchar(50) primary key,
amount int not null,
funder_name varchar(50) not null,
date date not null
);

create table Venue (
venue_id varchar(20) primary key,
place varchar(100) not null,
pincode int not null,
district varchar (50) not null,
state varchar (50) not null
);

create table VillageProfile (
pincode int primary key,
name varchar(50) not null,
no_of_beneficiaries int not null,
no_of_primary_health_center int not null,
no_of_primary_school int not null,
transport varchar(100) default null,
infrastructure varchar(100) default null,
major_occupation varchar(100) default null,
technical_literacy text default null,
year date not null
);

-- create table EmployeePhoneEntity (
-- phone_number int primary key,
-- location
-- );


create table Goods (
event_name varchar(50),
start_date date,
item_name varchar(50),
quantity int,
amount int,
primary key (event_name, start_date, item_name, quantity, amount),
foreign key (event_name, start_date)
references Projects(event_name, start_date) on delete cascade on update cascade
);

create table ProjectExpense (
event_name varchar(50),
start_date date,
description varchar(255),
amount int,
primary key (event_name, start_date, description, amount),
foreign key (event_name, start_date)
references Projects(event_name, start_date) on delete cascade on update cascade
);

create table TrainerPhoneEntity (
email_id varchar(50),
phone_number bigint not null,
primary key (email_id, phone_number),
foreign key (email_id) references Trainers(email_id) on delete cascade on update cascade
);

create table BeneficiaryPhoneEntity (
aadhar_id bigint not null,
phone_number bigint not null,
primary key (aadhar_id, phone_number),
foreign key (aadhar_id) references Beneficiary(aadhar_id) on delete cascade on update cascade
);


# Relation Tables

create table TeamPhone (
employee_id varchar(20) not null,
phone_number bigint not null,
location text default null,
primary key (employee_id, phone_number),
foreign key (employee_id) references Teams(employee_id) on delete cascade on update cascade
);




create table Organize (
employee_id varchar(20),
event_name varchar(50),
start_date date,
role varchar(50) not null,
primary key (employee_id, event_name, start_date),
foreign key(employee_id) references Teams(employee_id) on delete cascade on update cascade,
foreign key(event_name, start_date) references Projects(event_name, start_date) on delete cascade
on update cascade
);

create table sponsors(
email_id varchar(50),
event_name varchar(50),
start_date date,
primary key (email_id, event_name, start_date),
foreign key(email_id) references Funding(email_id) on delete cascade on update cascade,
foreign key(event_name, start_date) references Projects(event_name, start_date) on delete cascade
on update cascade
);

create table volunteering(
email_id varchar(50),
event_name varchar(50),
start_date date,
primary key (email_id, event_name, start_date),
foreign key(email_id) references Volunteers(email_id) on delete cascade on update cascade,
foreign key(event_name, start_date) references Projects(event_name, start_date) on delete cascade
on update cascade
);

create table HeldAt(
venue_id varchar(20),
event_name varchar(50),
start_date date,
primary key (venue_id, event_name, start_date),
foreign key(venue_id) references Venue(venue_id) on delete cascade on update cascade,
foreign key(event_name, start_date) references Projects(event_name, start_date) on delete cascade
on update cascade
);

create table trains(
email_id varchar(50),
event_name varchar(50),
start_date date,
primary key (email_id, event_name, start_date),
foreign key(email_id) references Trainers(email_id) on delete cascade on update cascade,
foreign key(event_name, start_date) references Projects(event_name, start_date) on delete cascade
on update cascade
);

create table participants(
aadhar_id bigint,
event_name varchar(50),
start_date date,
primary key (aadhar_id, event_name, start_date),
foreign key(aadhar_id) references Beneficiary(aadhar_id) on delete cascade on update cascade,
foreign key(event_name, start_date) references Projects(event_name, start_date) on delete cascade
on update cascade
);

create table TrainerBeneficiary(
aadhar_id bigint,
email_id varchar(50),
primary key (aadhar_id),
foreign key(aadhar_id) references Beneficiary(aadhar_id) on delete cascade on update cascade,
foreign key(email_id) references Trainers(email_id) on delete cascade
on update cascade
);

create table assessment(
aadhar_id bigint,
event_name varchar(50),
start_date date,
Date date NOT NULL,
present_or_absent enum('Present', 'Absent') NOT NULL,
primary key (aadhar_id),
foreign key(aadhar_id) references Beneficiary(aadhar_id) on delete cascade on update cascade,
foreign key(event_name, start_date) references Projects(event_name, start_date) on delete cascade
on update cascade
);

create table belongs(
aadhar_id bigint,
pincode int,
primary key (aadhar_id),
foreign key(aadhar_id) references Beneficiary(aadhar_id) on delete cascade on update cascade,
foreign key(pincode) references VillageProfile(pincode) on delete cascade
on update cascade
);




# Data Population
#Adding dummy values to Beneficiary
INSERT INTO Beneficiary (aadhar_id, name, date_of_birth, gender, marital_status, education, photo, employed, photo_caption)
VALUES
(123456789011, 'Asha Sharma', '1980-05-12', 'Female', 'Married', 'Master of Business Administration', NULL, 'Yes', 'Photo of Asha Sharma'),
(234567890121, 'Rahul Singh', '1995-08-02', 'Male', 'Unmarried', 'Bachelor of Engineering', NULL, 'Yes', 'Photo of Rahul Singh'),
(345678901231, 'Priya Patel', '1988-12-25', 'Female', 'Married', 'Doctor of Medicine', NULL, 'No', NULL),
(456789012341, 'Rajesh Kumar', '1976-09-18', 'Male', 'Married', 'Bachelor of Science', NULL, 'Yes', 'Photo of Rajesh Kumar'),
(567890123451, 'Sneha Gupta', '1992-04-01', 'Female', 'Unmarried', 'Master of Computer Applications', NULL, 'No', NULL),
(678901234561, 'Vikram Singh', '1985-06-21', 'Male', 'Married', 'Bachelor of Commerce', NULL, 'Yes', 'Photo of Vikram Singh'),
(789012345671, 'Anjali Reddy', '1990-03-15', 'Female', 'Unmarried', 'Bachelor of Arts', NULL, 'No', NULL),
(890123456781, 'Amit Sharma', '1983-11-08', 'Male', 'Married', 'Master of Science', NULL, 'Yes', 'Photo of Amit Sharma'),
(901234567891, 'Shalini Verma', '1987-07-14', 'Female', 'Married', 'Bachelor of Business Administration', NULL, 'No', NULL),
(123450987651, 'Sanjay Kumar', '1979-01-31', 'Male', 'Married', 'Master of Arts', NULL, 'Yes', 'Photo of Sanjay Kumar');
 
#Adding dummy values to Funding
INSERT INTO Funding (email_id, amount, funder_name, date) VALUES
('abc@gmail.com', 50000, 'Rohit Sharma', '2022-02-01'),
('def@gmail.com', 25000, 'Neha Gupta', '2022-02-03'),
('ghi@gmail.com', 100000, 'Rajesh Singh', '2022-02-06'),
('jkl@gmail.com', 75000, 'Priya Patel', '2022-02-10'),
('mno@gmail.com', 30000, 'Siddharth Reddy', '2022-02-12'),
('pqr@gmail.com', 150000, 'Amit Kumar', '2022-02-15'),
('stu@gmail.com', 5000, 'Shreya Gupta', '2022-02-17'),
('vwx@gmail.com', 80000, 'Anjali Sharma', '2022-02-20'),
('yz@gmail.com', 20000, 'Suresh Patel', '2022-02-22'),
('abc1@gmail.com', 40000, 'Manisha Singh', '2022-02-25');


#Adding dummy values to projects 
INSERT INTO Projects (event_name, start_date, types, budget, no_of_participants, duration, collection, total_expense) VALUES
('Project A', '2022-01-01', 'Conference', 500000, 100, 5, 600000, 400000),
('Project B', '2022-02-01', 'Workshop', 300000, 50, 3, null, 200000),
('Project C', '2022-03-01', 'Seminar', 200000, 30, 2, null, 150000),
('Project D', '2022-04-01', 'Exhibition', 800000, 200, 7, 900000, 700000),
('Project E', '2022-05-01', 'Hackathon', 400000, 80, 4, null, 300000),
('Project F', '2022-06-01', 'Training', 600000, 120, 6, 700000, 500000),
('Project G', '2022-07-01', 'Competition', 500000, 50, 2, null, 400000),
('Project H', '2022-08-01', 'Expo', 1000000, 300, 10, 1200000, 900000),
('Project I', '2022-09-01', 'Webinar', 100000, 200, 1, null, 80000),
('Project J', '2022-10-01', 'Symposium', 700000, 150, 8, 800000, 600000);

#Adding dummy values to ProjectPhotos
INSERT INTO ProjectPhotos (project_event_name, project_start_date, photo_url, caption) 
VALUES 
  ('Project A', '2022-01-01', 'https://example.com/photo1.jpg', 'Conference photo 1'),
  ('Project A', '2022-01-01', 'https://example.com/photo2.jpg', 'Conference photo 2'),
  ('Project B', '2022-02-01', 'https://example.com/photo3.jpg', 'Workshop photo 1'),
  ('Project C', '2022-03-01', 'https://example.com/photo4.jpg', NULL),
  ('Project D', '2022-04-01', 'https://example.com/photo5.jpg', 'Exhibition photo 1'),
  ('Project E', '2022-05-01', 'https://example.com/photo6.jpg', NULL),
  ('Project F', '2022-06-01', 'https://example.com/photo7.jpg', 'Training photo 1'),
  ('Project G', '2022-07-01', 'https://example.com/photo8.jpg', NULL),
  ('Project H', '2022-08-01', 'https://example.com/photo9.jpg', 'Expo photo 1'),
  ('Project I', '2022-09-01', 'https://example.com/photo10.jpg', NULL);
  
  
INSERT INTO ProjectPhotos (project_event_name, project_start_date, photo_url, caption)
VALUES
    ('Project A', '2022-01-01', 'E:/6th Sem/OneDrive - iitgn.ac.in/6th Sem/dbms/Assignment2/image2.jpg', 'Photo of project A'),
    ('Project A', '2022-01-01', 'E:/6th Sem/OneDrive - iitgn.ac.in/6th Sem/dbms/Assignment2/image1.jpg', 'Another photo of project A'),
    ('Project B', '2022-02-01', 'E:/6th Sem/OneDrive - iitgn.ac.in/6th Sem/dbms/Assignment2/image2.jpg', 'Photo of project B'),
    ('Project B', '2022-02-01', 'E:/6th Sem/OneDrive - iitgn.ac.in/6th Sem/dbms/Assignment2/image1.jpg', NULL);







#Adding dummy values to Volunteers
INSERT INTO Volunteers (email_id, name, phone_number, date_of_birth, gender) VALUES
('john.doe@example.com', 'John Doe', 9876543210, '1990-05-15', 'Male'),
('jane.doe@example.com', 'Jane Doe', 9876543211, '1992-08-25', 'Female'),
('rohit.sharma@example.com', 'Rohit Sharma', 9876543212, '1987-04-30', 'Male'),
('priya.rai@example.com', 'Priya Rai', 9876543213, '1995-11-20', 'Female'),
('amit.kumar@example.com', 'Amit Kumar', 9876543214, '1991-02-10', 'Male'),
('divya.mishra@example.com', 'Divya Mishra', 9876543215, '1993-07-05', 'Female'),
('rahul.gupta@example.com', 'Rahul Gupta', 9876543216, '1994-09-12', 'Male'),
('pooja.shah@example.com', 'Pooja Shah', 9876543217, '1996-12-18', 'Female'),
('avinash.singh@example.com', 'Avinash Singh', 9876543218, '1992-03-22', 'Male'),
('neha.patel@example.com', 'Neha Patel', 9876543219, '1997-06-08', 'Female');


#Adding dummy values to VillageProfile
INSERT INTO VillageProfile (pincode, name, no_of_beneficiaries, no_of_primary_health_center, no_of_primary_school, transport, infrastructure, major_occupation, technical_literacy, year) VALUES 
(380001, 'Ambawadi', 2500, 2, 3, 'Bus, Train', 'Electricity, Water, Roads', 'Agriculture', 'Basic Computer Knowledge', '2022-01-01'),
(380002, 'Vastrapur', 3500, 1, 4, 'Bus, Auto', 'Electricity, Water, Drainage', 'Education', 'Basic Computer Knowledge', '2022-01-01'),
(380003, 'Navrangpura', 4000, 3, 2, 'Bus, Train, Auto', 'Electricity, Water, Roads', 'Manufacturing', 'Advanced Computer Knowledge', '2022-01-01'),
(380004, 'Naranpura', 3000, 2, 3, 'Bus, Auto', 'Electricity, Water, Roads', 'Service', 'Basic Computer Knowledge', '2022-01-01'),
(380005, 'Satellite', 5000, 1, 4, 'Bus, Auto', 'Electricity, Water, Roads', 'Software Development', 'Advanced Computer Knowledge', '2022-01-01'),
(382330, 'Gandhinagar', 4500, 3, 2, 'Bus, Train', 'Electricity, Water, Roads', 'Agriculture', 'Basic Computer Knowledge', '2022-01-01'),
(382340, 'Kalol', 2000, 1, 4, 'Bus, Auto', 'Electricity, Water, Drainage', 'Education', 'Basic Computer Knowledge', '2022-01-01'),
(382345, 'Adalaj', 3000, 2, 3, 'Bus, Auto', 'Electricity, Water, Roads', 'Service', 'Basic Computer Knowledge', '2022-01-01'),
(382350, 'Dehgam', 4000, 3, 2, 'Bus, Auto', 'Electricity, Water, Roads', 'Manufacturing', 'Advanced Computer Knowledge', '2022-01-01'),
(382355, 'Vadsar', 3500, 1, 4, 'Bus, Auto', 'Electricity, Water, Roads', 'Software Development', 'Advanced Computer Knowledge', '2022-01-01');

#Adding dummy values to Goods
INSERT INTO Goods (event_name, start_date, item_name, quantity, amount)
VALUES 
  ('Project A', '2022-01-01', 'Laptop', 10, 100000),
  ('Project A', '2022-01-01', 'Projector', 2, 50000),
  ('Project B', '2022-02-01', 'Marker', 50, 1000),
  ('Project C', '2022-03-01', 'Notebook', 30, 500),
  ('Project D', '2022-04-01', 'Painting', 5, 1000000),
  ('Project E', '2022-05-01', 'Raspberry Pi', 20, 20000),
  ('Project F', '2022-06-01', 'Whiteboard', 2, 30000),
  ('Project G', '2022-07-01', 'Chess Set', 5, 5000),
  ('Project H', '2022-08-01', 'Microphone', 10, 50000),
  ('Project I', '2022-09-01', 'Webcam', 5, 20000);


#Adding dummy values to Trainers
INSERT INTO Trainers (email_id, fee, name, age, gender)
VALUES
('trainer1@gmail.com', 2000, 'Rajesh Kumar', 35, 'Male'),
('trainer2@gmail.com', 2500, 'Anjali Sharma', 28, 'Female'),
('trainer3@gmail.com', 1800, 'Vikram Singh', 42, 'Male'),
('trainer4@gmail.com', 3000, 'Sneha Patel', 31, 'Female'),
('trainer5@gmail.com', 2200, 'Gaurav Chauhan', 29, 'Male'),
('trainer6@gmail.com', 2700, 'Priya Gupta', 27, 'Female'),
('trainer7@gmail.com', 1900, 'Ravi Mishra', 36, 'Male'),
('trainer8@gmail.com', 2800, 'Neha Singh', 33, 'Female'),
('trainer9@gmail.com', 2400, 'Rahul Sharma', 30, 'Male'),
('trainer10@gmail.com', 3200, 'Meera Shah', 26, 'Female');

#Adding dummy values to ProjectExpense
INSERT INTO ProjectExpense (event_name, start_date, description, amount)
VALUES
    ('Project A', '2022-01-01', 'Catering expenses', 150000),
    ('Project A', '2022-01-01', 'Speaker fees', 200000),
    ('Project B', '2022-02-01', 'Venue rental', 100000),
    ('Project B', '2022-02-01', 'Equipment rental', 50000),
    ('Project C', '2022-03-01', 'Printing and design', 80000),
    ('Project C', '2022-03-01', 'Speaker fees', 70000),
    ('Project D', '2022-04-01', 'Shipping expenses', 150000),
    ('Project E', '2022-05-01', 'Prize money', 100000),
    ('Project F', '2022-06-01', 'Speaker fees', 300000),
    ('Project G', '2022-07-01', 'Marketing expenses', 50000);

#Adding dummy values to TrainerPhoneEntity
INSERT INTO TrainerPhoneEntity (email_id, phone_number)
VALUES
('trainer1@gmail.com', 9876543210),
('trainer1@gmail.com', 8765432109),
('trainer2@gmail.com', 7654321098),
('trainer2@gmail.com', 6543210987),
('trainer3@gmail.com', 5432109876),
('trainer4@gmail.com', 4321098765),
('trainer5@gmail.com', 3210987654),
('trainer6@gmail.com', 2109876543),
('trainer8@gmail.com', 1098765432),
('trainer10@gmail.com', 1234567890);


-- #Adding dummy values to BeneficiaryPhoneEntity

INSERT INTO BeneficiaryPhoneEntity (aadhar_id, phone_number)
VALUES 
(123450987651, 9876543210);

#Adding dummy values to EmployeePhoneEntity
INSERT INTO TeamPhone (employee_id, phone_number, location) VALUES
('1', 9876543210, 'Delhi');

-- Relational Tables 
#Adding dummy values to Organize
INSERT INTO Organize (employee_id, event_name, start_date, role)
VALUES 
('1', 'Project A', '2022-01-01', 'Manager');

#Adding dummy values to Sponsors
INSERT INTO sponsors (email_id, event_name, start_date)
VALUES ('abc@gmail.com', 'Project B', '2022-02-01');

#Adding dummy values to Volunteering
INSERT INTO volunteering (email_id, event_name, start_date) VALUES
('john.doe@example.com', 'Project A', '2022-01-01');

#Adding dummy values to HeldAt

#Adding dummy values to trains
INSERT INTO trains (email_id, event_name, start_date)
VALUES
('trainer1@gmail.com', 'Project A', '2022-01-01');

-- #Adding dummy values to trains
INSERT INTO participants (aadhar_id, event_name, start_date)
VALUES
(123456789011, 'Project A', '2022-01-01');

#Adding dummy values to TrainerBeneficiary
INSERT INTO TrainerBeneficiary (aadhar_id, email_id) VALUES
(123456789011, 'trainer1@gmail.com');

-- #Adding dummy values to assessment
INSERT INTO assessment (aadhar_id, event_name, start_date, Date, present_or_absent)
VALUES
(123456789011, 'Project A', '2022-01-01', '2022-01-01', 'Present'),
(234567890121, 'Project A', '2022-01-01', '2022-01-01', 'Absent');

INSERT INTO belongs (aadhar_id, pincode)
VALUES 
(123450987651, 380001);


create table requestDetails (
Sr_No int,
Apply_for enum('trainer', 'volunteer') not null,
Applied_on date,
Name varchar(50),
Status enum('Pending', 'Accepted', 'Rejected') not null,
Query varchar(255),
QueryRelationship varchar(255),
event_name varchar(50),
start_date date
);

INSERT INTO requestDetails (Sr_No, Apply_for, Applied_on, Name, Status, Query, QueryRelationship,event_name, start_date) VALUES
(1, 'trainer', '2023-03-31', 'John Smith', 'Pending', 'SELECT * FROM users', 'Query 2', 'Project A', '2022-01-01'),
(2, 'volunteer', '2023-03-31', 'Jane Doe', 'Accepted', 'INSERT INTO events (title, date) VALUES ("Charity Walk", "2023-04-15")', 'Query 2', 'Project A', '2022-01-01'),
(3, 'trainer', '2023-04-01', 'Michael Johnson', 'Rejected', 'UPDATE inventory SET quantity = quantity - 10 WHERE item_id = 5', 'Query 2', 'Project A', '2022-01-01'),
(4, 'volunteer', '2023-04-01', 'Jessica Lee', 'Accepted', 'DELETE FROM tasks WHERE task_id = 15', 'Query 2', 'Project A', '2022-01-01');

-- select * from requestDetails;