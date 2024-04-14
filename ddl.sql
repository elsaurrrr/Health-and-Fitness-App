CREATE TABLE Schedule (
    ID SERIAL PRIMARY KEY,
    member_ID SERIAL REFERENCES Member(ID),
    trainer_ID SERIAL REFERENCES Trainer(ID),
    room_ID SERIAL REFERENCES Room(ID)
)
CREATE TABLE Timeslot (
    ID SERIAL PRIMARY KEY,
    start_time time NOT NULL,
    end_time time NOT NULL,
    duration_minutes INTEGER NOT NULL, 
        foreign key schedule_ID REFERENCES Schedule(ID)
            on delete set null
)
CREATE TABLE Room (
    ID SERIAL PRIMARY KEY,
    room_number INTEGER,
    room_description varchar(20) NOT NULL,
        foreign key schedule_ID REFERENCES Schedule(ID)
            on delete set null
)
CREATE TABLE Equipment (
    ID SERIAL PRIMARY KEY,
    equipment_name varchar(20) NOT NULL,
    condition varchar(20) NOT NULL,
        foreign key room_ID REFERENCES Room(ID)
            on delete set null
)

CREATE TABLE Member (
    ID SERIAL PRIMARY KEY,
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
    home_address varchar(20) NOT NULL,
    phone_number varchar(20) NOT NULL,
    email varchar(20) NOT NULL,
    user_password varchar(20) NOT NULL,
    date_of_birth DATE DEFAULT CURRENT_DATE NOT NULL,
    gender varchar(20),
    height_CM varchar(20),
    weight_KG varchar(20),
    bmi varchar(20),
    body_fat_percentage varchar(20),
    last_login DATE,
    active boolean,
        foreign key schedule_ID REFERENCES Schedule(ID)
            on delete set null
);

CREATE TABLE Trainer (
    ID SERIAL PRIMARY KEY,
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
    phone_number varchar(20) NOT NULL,
    email varchar(20) NOT NULL,
    user_password varchar(20) NOT NULL,
    certification varchar2(80) NOT NULL,
    specialization varchar2(80) NOT NULL,
    last_login DATE,
    active boolean,
        foreign key schedule_ID REFERENCES Schedule(ID)
            on delete set null
);
CREATE TABLE Admin_Staff (
    ID SERIAL PRIMARY KEY,
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
    phone_number varchar(20) NOT NULL,
    email varchar(20) NOT NULL,
    user_password varchar(20) NOT NULL,
    title varchar(20) NOT NULL,
    last_login DATE,
    active boolean,
        foreign key schedule_ID REFERENCES Schedule(ID)
            on delete set null
);
CREATE TABLE Fitness_Goal (
    ID SERIAL PRIMARY KEY,
    metric_type varchar(20) NOT NULL,
    begin_date DATE DEFAULT CURRENT_DATE NOT NULL, 
    end_date DATE DEFAULT CURRENT_DATE NOT NULL, 
    start_value varchar(20) NOT NULL,
    target_value varchar(20) NOT NULL,
    current_value varchar(20) NOT NULL,
        foreign key member_ID REFERENCES Member(ID)
            on delete set null
);
CREATE TABLE Personal_Training_Session (
    ID SERIAL PRIMARY KEY,
    session_date DATE NOT NULL,
        foreign key member_ID REFERENCES Member(ID)
            on delete set null
        foreign key trainer_ID REFERENCES Trainer(ID)
            on delete set null
        foreign key room_ID REFERENCES Room(ID)
            on delete set null
        foreign key timeslot_ID REFERENCES Timeslot(ID)
            on delete set null
    
);
CREATE TABLE Group_Fitness_Class (
    ID SERIAL PRIMARY KEY,
    session_date DATE NOT NULL,
    difficulty_level varchar(20) NOT NULL,
    capacity INTEGER NOT NULL,
        foreign key trainer_ID REFERENCES Trainer(ID)
            on delete set null
        foreign key room_ID REFERENCES Room(ID)
            on delete set null
        foreign key timeslot_ID REFERENCES Timeslot(ID)
            on delete set null
);

CREATE TABLE Bill (
    ID SERIAL PRIMARY KEY,
    amount MONEY NOT NULL,
    bill_description varchar2(80) NOT NULL,
    bill_date DATE DEFAULT CURRENT_DATE,
        foreign key member_ID REFERENCES Member(ID)
            on delete set null    
);
CREATE TABLE Payment (
    ID SERIAL PRIMARY KEY,
    amount money NOT NULL,
    payment_description varchar2(80) NOT NULL,
    payment_date DATE DEFAULT CURRENT_DATE,
        foreign key member_ID REFERENCES Member(ID)
            on delete set null    
);