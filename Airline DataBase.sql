-- Drop the existing database if it exists
DROP DATABASE IF EXISTS airline_booking_system;
CREATE DATABASE IF NOT EXISTS airline_booking_system;
USE airline_booking_system;

CREATE TABLE Airline (
    AirlineCode VARCHAR(10) PRIMARY KEY,
    AirlineName VARCHAR(255),
    HeadquartersAddress VARCHAR(255)
);

CREATE TABLE MileagePrograms (
    ProgramCode VARCHAR(10) PRIMARY KEY,
    Description VARCHAR(255),
    StartDate DATE,
    AirlineCode VARCHAR(10),
    FOREIGN KEY (AirlineCode) REFERENCES Airline(AirlineCode)
);

CREATE TABLE Flights (
    FlightNumber VARCHAR(20) PRIMARY KEY,
    DayOfWeek VARCHAR(20),
    DepartureTime TIME

);

CREATE TABLE Passengers (
    PassengerNumber INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Gender VARCHAR(10)
);

CREATE TABLE TravelAgencies (
    AgencyCode VARCHAR(10) PRIMARY KEY,
    AgencyName VARCHAR(255),
    ContactPerson VARCHAR(255)   
);

CREATE TABLE Booking (
    TravelCode VARCHAR(10),
    PassengerNumber INT,
    PRIMARY KEY (TravelCode, PassengerNumber),
    FOREIGN KEY (TravelCode) REFERENCES TravelAgencies(AgencyCode),
    FOREIGN KEY (PassengerNumber) REFERENCES Passengers(PassengerNumber)
);

CREATE TABLE BookedFlights (
    FlightNumber VARCHAR(20),
    PassengerNumber INT,
    Date DATE,
    ArrivalTime TIME,
    Origin VARCHAR(255),
    Destination VARCHAR(255),
    Stops INT,
    FOREIGN KEY (FlightNumber) REFERENCES Flights(FlightNumber),
    FOREIGN KEY (PassengerNumber) REFERENCES Passengers(PassengerNumber)
);

CREATE TABLE MenuOption (
    MenuCode VARCHAR(10) PRIMARY KEY,
    PassengerNumber INT,
    Description VARCHAR(255),
    FOREIGN KEY (PassengerNumber) REFERENCES Passengers(PassengerNumber)
);

CREATE TABLE CrewDetails (
    CrewmemberID INT PRIMARY KEY,
    FlightNumber VARCHAR(20),
    PilotName VARCHAR(255),
    SeatNumber VARCHAR(10),
    PassengerNumber INT,
    FOREIGN KEY (PassengerNumber) REFERENCES Passengers(PassengerNumber)
);
DESC Airline;
DESC MileagePrograms;
DESC Flights;
DESC Passengers;
DESC TravelAgencies;
DESC Booking;
DESC BookEDflights;
DESC MenuOption;
DESC CrewDetails;



-- Populate Airline table
INSERT INTO Airline (AirlineCode, AirlineName, HeadquartersAddress) VALUES
('AA', 'American Airlines', 'Fort Worth, Texas, USA'),
('DL', 'Delta Air Lines', 'Atlanta, Georgia, USA'),
('UA', 'United Airlines', 'Chicago, Illinois, USA');

-- Populate MileagePrograms table
INSERT INTO MileagePrograms (ProgramCode, Description, StartDate, AirlineCode) VALUES
('AA01', 'AAdvantage', '2020-01-01', 'AA'),
('DL01', 'SkyMiles', '2019-05-01', 'DL'),
('UA01', 'MileagePlus', '2018-07-01', 'UA');

-- Populate Flights table
INSERT INTO Flights (FlightNumber, DayOfWeek, DepartureTime) 
VALUES 
    ('DL2001', 'Tuesday', '10:30:00'),
    ('UA3001', 'Wednesday', '12:45:00');


-- Populate Passengers table
INSERT INTO Passengers (Name, Gender) VALUES
('John Smith', 'Male'),
('Emily Johnson', 'Female'),
('Michael Brown', 'Male');

-- Populate TravelAgencies table
INSERT INTO TravelAgencies (AgencyCode, AgencyName, ContactPerson) VALUES
('TA001', 'Travel World', 'Sarah Johnson'),
('TA002', 'Global Travels', 'James Smith');

-- Populate Booking table
INSERT INTO Booking (TravelCode, PassengerNumber) VALUES
('TA001', 1),
('TA002', 2),
('TA002', 3);

-- Populate BookedFlights table
INSERT INTO BookedFlights (FlightNumber, PassengerNumber, Date, ArrivalTime, Origin, Destination, Stops) VALUES
('AA1001', 1, '2024-04-15', '10:30:00', 'New York', 'Los Angeles', 1),
('DL2001', 2, '2024-04-18', '13:45:00', 'Los Angeles', 'Atlanta', 0),
('UA3001', 3, '2024-04-20', '15:15:00', 'Chicago', 'Houston', 1);

-- Populate MenuOption table
INSERT INTO MenuOption (MenuCode, PassengerNumber, Description) VALUES
('M001', 1, 'Vegetarian Meal'),
('M002', 2, 'Gluten-Free Meal'),
('M003', 3, 'Child Meal');

-- Populate CrewDetails table
INSERT INTO CrewDetails (CrewmemberID, FlightNumber, PilotName, SeatNumber, PassengerNumber) VALUES
(101, 'AA1001', 'John Doe', 'CPT01', 1),
(102, 'DL2001', 'Jane Smith', 'CPT02', 2),
(103, 'UA3001', 'Michael Johnson', 'CPT03', 3);

SELECT AirlineName, HeadquartersAddress
FROM Airline;

SELECT mp.Description, a.AirlineName
FROM MileagePrograms mp
JOIN Airline a ON mp.AirlineCode = a.AirlineCode;

SELECT *
FROM Flights
WHERE DayOfWeek = 'Monday';

SELECT b.*, p.Name AS PassengerName
FROM Booking b
JOIN Passengers p ON b.PassengerNumber = p.PassengerNumber
WHERE b.TravelCode = 'TA001';

SELECT cd.FlightNumber, cd.PilotName, cd.SeatNumber, p.Name AS PassengerName
FROM CrewDetails cd
LEFT JOIN Passengers p ON cd.PassengerNumber = p.PassengerNumber;


-- Select all records from each table
SELECT * FROM Airline;
SELECT * FROM MileagePrograms;
SELECT * FROM Flights;
SELECT * FROM Passengers;
SELECT * FROM TravelAgencies;
SELECT * FROM Booking;
SELECT * FROM BookedFlights;
SELECT * FROM MenuOption;
SELECT * FROM CrewDetails;

