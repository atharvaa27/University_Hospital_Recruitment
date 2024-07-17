USE master;
GO

IF NOT EXISTS (
      SELECT name
      FROM sys.databases
      WHERE name = N'Recruitment_Hospital'
      )
   CREATE DATABASE [Recruitment_Hospital];
GO

IF SERVERPROPERTY('ProductVersion') > '12'
   ALTER DATABASE [Recruitment_Hospital] SET QUERY_STORE = ON;
GO

-- Table creation ---


-- Creating table for Candidates
CREATE TABLE Candidates (
    CandidateID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Phone VARCHAR(50),
    ShortProfile TEXT
);

-- Creating table for Jobs
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    Position VARCHAR(255),
    Title VARCHAR(255),
    Type VARCHAR(50),
    Medium VARCHAR(50),
    StartDate DATE,
    JobDescription TEXT
);

-- Creating table for Job Openings
CREATE TABLE JobOpenings (
    OpeningID INT PRIMARY KEY,
    JobID INT,
    NumberOfPositions INT,
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID)
);

-- Creating table for Applications
CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    CandidateID INT,
    JobOpeningID INT,
    ApplicationDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID),
    FOREIGN KEY (JobOpeningID) REFERENCES JobOpenings(OpeningID)
);

-- Creating table for Interviews
CREATE TABLE Interviews (
    InterviewID INT PRIMARY KEY,
    ApplicationID INT,
    InterviewType VARCHAR(50),
    StartTime DATETIME,
    EndTime DATETIME,
    FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID)
);

-- Creating table for Tests
CREATE TABLE Tests (
    TestID INT PRIMARY KEY,
    InterviewID INT,
    TestType VARCHAR(50),
    StartTime DATETIME,
    EndTime DATETIME,
    Result VARCHAR(50),
    FOREIGN KEY (InterviewID) REFERENCES Interviews(InterviewID)
);

-- Creating table for Interviewers
CREATE TABLE Interviewers (
    InterviewerID INT PRIMARY KEY,
    Name VARCHAR(255),
    Department VARCHAR(255),
    Title VARCHAR(255)
);

-- Creating table for Documents
CREATE TABLE Documents (
    DocumentID INT PRIMARY KEY,
    CandidateID INT,
    Type VARCHAR(50),
    DocumentLink TEXT,
    FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID)
);

-- Creating table for Background Checks
CREATE TABLE BackgroundChecks (
    CheckID INT PRIMARY KEY,
    CandidateID INT,
    CriminalBackground VARCHAR(255),
    EmploymentHistory VARCHAR(255),
    CheckStatus VARCHAR(50),
    CheckDate DATE,
    FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID)
);

-- Creating table for Drug Tests
CREATE TABLE DrugTests (
    TestID INT PRIMARY KEY,
    CandidateID INT,
    TestType VARCHAR(50),
    TestDate DATE,
    Results VARCHAR(50),
    FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID)
);

-- Creating table for Reimbursements
CREATE TABLE Reimbursements (
    ReimbursementID INT PRIMARY KEY,
    ApplicationID INT,
    RequestedAmount DECIMAL(10,2),
    ProcessedAmount DECIMAL(10,2),
    Status VARCHAR(50),
    FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID)
);

-- Creating table for Onboarding
CREATE TABLE Onboarding (
    OnboardingID INT PRIMARY KEY,
    CandidateID INT,
    JobID INT,
    StartDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (CandidateID) REFERENCES Candidates(CandidateID),
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID)
);

CREATE TABLE FinancialRecords (
    TransactionID UNIQUEIDENTIFIER PRIMARY KEY,
    Amount DECIMAL(10, 2),
    TransactionDate DATETIME,
    Description NVARCHAR(255)
);


INSERT INTO Candidates (CandidateID, Name, Email, Phone, ShortProfile) VALUES
(1011, 'Atharvaa Rane', 'atharvaa.rane@syr.edu', '315-555-2974', 'Radiologist with a special interest in musculoskeletal imaging and sports injuries.'),
(1012, 'Nolan Case', 'nolan.case@healthnet.com', '716-555-4521', 'Epidemiologist with a strong background in infectious diseases and public health.'),
(1013, 'Lydia Bennett', 'lydia.bennett@clinic.org', '607-555-9832', 'Dermatologist focusing on pediatric and adolescent skin conditions.'),
(1014, 'Reed Morales', 'reed.morales@pioneerhealth.com', '845-555-7391', 'Biochemist with expertise in pharmaceutical developments and patient safety.'),
(1015, 'Eva Summers', 'eva.summers@welllife.com', '518-555-8264', 'Nutritionist specializing in dietetics for chronic diseases and senior health.'),
(1016, 'Hugo Ross', 'hugo.ross@medicalcore.com', '914-555-4930', 'General practitioner with a comprehensive approach to primary care and wellness.'),
(1017, 'Vivian Lacroix', 'vivian.lacroix@integrahealth.com', '347-555-1824', 'A seasoned physical therapist dedicated to rehabilitation and recovery processes.'),
(1018, 'Miles Archer', 'miles.archer@lifeline.com', '631-555-5010', 'Clinical research coordinator focusing on trials for cutting-edge cancer treatments.'),
(1019, 'Tara Flynn', 'tara.flynn@careplus.org', '212-555-2213', 'Anesthesiologist with a focus on perioperative care and pain management.'),
(1020, 'Leo Carver', 'leo.carver@pharmtech.com', '646-555-6668', 'Pharmaceutical technician engaged in medication therapy management and patient counseling.');

INSERT INTO Jobs (JobID, Position, Title, Type, Medium, StartDate, JobDescription) VALUES
(2011, 'Cardiologist', 'Consultant Cardiologist', 'Full-time', 'Onsite', '2024-02-20', 'Diagnoses and treats patients with heart and cardiovascular conditions.'),
(2012, 'Medical Illustrator', 'Lead Medical Illustrator', 'Contract', 'Remote', '2024-03-15', 'Creates detailed medical graphics to aid patient understanding and medical education.'),
(2013, 'Genetic Counselor', 'Senior Genetic Counselor', 'Part-time', 'Onsite', '2024-04-10', 'Provides genetic counseling and conducts risk assessments for patients.'),
(2014, 'Neurologist', 'Chief of Neurology', 'Full-time', 'Onsite', '2024-05-05', 'Heads the department of neurology and oversees treatment of neurological disorders.'),
(2015, 'Medical Coder', 'Medical Coding Specialist', 'Full-time', 'Remote', '2024-06-12', 'Ensures accurate coding of health services and procedures for billing and documentation.'),
(2016, 'Pediatric Oncologist', 'Pediatric Cancer Specialist', 'Full-time', 'Onsite', '2024-07-22', 'Specializes in diagnosing and treating cancers affecting children.'),
(2017, 'Speech Therapist', 'Speech-Language Pathologist', 'Full-time', 'Onsite', '2024-08-18', 'Assists patients in improving speech disorders and swallowing difficulties.'),
(2018, 'Health Data Analyst', 'Senior Data Analyst', 'Contract', 'Remote', '2024-09-01', 'Analyzes health data to help improve hospital systems and patient care outcomes.'),
(2019, 'Occupational Therapist', 'Lead Occupational Therapist', 'Part-time', 'Onsite', '2024-10-25', 'Helps patients develop and recover daily living and work skills.'),
(2020, 'Clinical Psychologist', 'Behavioral Health Specialist', 'Full-time', 'Onsite', '2024-11-15', 'Provides psychological assessments and therapy to patients dealing with mental health issues.');


INSERT INTO JobOpenings (OpeningID, JobID, NumberOfPositions) VALUES
(3011, 2011, 2),  -- Cardiologist
(3012, 2012, 1),  -- Medical Illustrator
(3013, 2013, 1),  -- Genetic Counselor
(3014, 2014, 1),  -- Neurologist
(3015, 2015, 2),  -- Medical Coder
(3016, 2016, 2),  -- Pediatric Oncologist
(3017, 2017, 2),  -- Speech Therapist
(3018, 2018, 1),  -- Health Data Analyst
(3019, 2019, 2),  -- Occupational Therapist
(3020, 2020, 1);  -- Clinical Psychologist


-- Inserting application data into the 'Applications' table
INSERT INTO Applications (ApplicationID, CandidateID, JobOpeningID, ApplicationDate, Status) VALUES
(4011, 1011, 3011, '2023-10-04', 'Under Review'),
(4012, 1012, 3012, '2023-09-20', 'Submitted'),
(4013, 1013, 3013, '2023-09-18', 'Under Review'),
(4014, 1014, 3014, '2023-09-15', 'Submitted'),
(4015, 1015, 3015, '2023-10-07', 'Under Review'),
(4016, 1016, 3016, '2023-09-22', 'Submitted'),
(4017, 1017, 3017, '2023-09-30', 'Under Review'),
(4018, 1018, 3018, '2023-09-21', 'Submitted'),
(4019, 1019, 3019, '2023-10-01', 'Submitted'),
(4020, 1020, 3020, '2023-09-19', 'Under Review');

-- Inserting data into the 'Interviews' table
INSERT INTO Interviews (InterviewID, ApplicationID, InterviewType, StartTime, EndTime) VALUES
(5001, 4011, 'Initial Screening', '2023-10-05 09:00:00', '2023-10-05 10:00:00'),
(5002, 4012, 'Technical Interview', '2023-09-21 11:00:00', '2023-09-21 12:30:00'),
(5003, 4013, 'Panel Interview', '2023-09-19 14:00:00', '2023-09-19 15:30:00'),
(5004, 4014, 'HR Interview', '2023-09-16 10:00:00', '2023-09-16 11:00:00'),
(5005, 4015, 'Technical Interview', '2023-10-08 13:00:00', '2023-10-08 14:00:00'),
(5006, 4016, 'Panel Interview', '2023-09-23 10:00:00', '2023-09-23 11:30:00'),
(5007, 4017, 'HR Interview', '2023-09-01 09:00:00', '2023-09-01 10:00:00'),
(5008, 4018, 'Initial Screening', '2023-09-22 13:00:00', '2023-09-22 14:00:00'),
(5009, 4019, 'Technical Interview', '2023-10-02 10:00:00', '2023-10-02 11:00:00'),
(5010, 4020, 'HR Interview', '2023-09-20 09:00:00', '2023-09-20 10:00:00');


INSERT INTO Tests (TestID, InterviewID, TestType, StartTime, EndTime, Result) VALUES
(6001, 5001, 'Personality Test', '2023-10-05 11:00:00', '2023-10-05 12:00:00', 'Passed'),
(6002, 5002, 'Coding Test', '2023-09-21 13:30:00', '2023-09-21 15:30:00', 'Failed'),
(6003, 5003, 'Panel Review', '2023-09-19 15:00:00', '2023-09-19 16:00:00', 'Passed'),
(6004, 5004, 'Skill Assessment', '2023-09-16 10:30:00', '2023-09-16 11:30:00', 'Failed'),
(6005, 5005, 'Technical Quiz', '2023-10-08 14:30:00', '2023-10-08 15:30:00', 'Passed'),
(6006, 5006, 'Clinical Knowledge Test', '2023-09-23 11:00:00', '2023-09-23 12:00:00', 'Failed'),
(6007, 5007, 'Management Simulation', '2023-09-01 09:30:00', '2023-09-01 10:30:00', 'Passed'),
(6008, 5008, 'Communication Test', '2023-09-22 14:00:00', '2023-09-22 15:00:00', 'Failed'),
(6009, 5009, 'Problem Solving Test', '2023-10-02 11:00:00', '2023-10-02 12:00:00', 'Passed'),
(6010, 5010, 'Ethical Reasoning Test', '2023-09-20 09:30:00', '2023-09-20 10:30:00', 'Passed');

INSERT INTO Interviewers (InterviewerID, Name, Department, Title) VALUES
(7001, 'Dr. Lisa Ray', 'Cardiology', 'Senior Cardiologist'),
(7002, 'Mr. James Smith', 'IT', 'IT Manager'),
(7003, 'Ms. Nancy Drew', 'HR', 'HR Director'),
(7004, 'Dr. Alan Grant', 'Oncology', 'Lead Oncologist'),
(7005, 'Ms. Claire Dearing', 'Pediatrics', 'Pediatric Nurse Manager'),
(7006, 'Dr. Henry Wu', 'Genetics', 'Chief Geneticist'),
(7007, 'Mr. Owen Grady', 'Security', 'Security Supervisor'),
(7008, 'Ms. Ellie Sattler', 'Botany', 'Head of Botanical Research'),
(7009, 'Dr. Ian Malcolm', 'Mathematics', 'Statistical Analyst'),
(7010, 'Dr. Victor Fries', 'Cryogenics', 'Cryogenics Specialist');

INSERT INTO Documents (DocumentID, CandidateID, Type, DocumentLink) VALUES
(8001, 1011, 'Resume', 'https://docs.example.com/resumes/1011'),
(8002, 1012, 'Cover Letter', 'https://docs.example.com/coverletters/1012'),
(8003, 1013, 'Portfolio', 'https://docs.example.com/portfolios/1013'),
(8004, 1014, 'Resume', 'https://docs.example.com/resumes/1014'),
(8005, 1015, 'Cover Letter', 'https://docs.example.com/coverletters/1015'),
(8006, 1016, 'Portfolio', 'https://docs.example.com/portfolios/1016'),
(8007, 1017, 'Resume', 'https://docs.example.com/resumes/1017'),
(8008, 1018, 'Cover Letter', 'https://docs.example.com/coverletters/1018'),
(8009, 1019, 'Portfolio', 'https://docs.example.com/portfolios/1019'),
(8010, 1020, 'Resume', 'https://docs.example.com/resumes/1020');


INSERT INTO BackgroundChecks (CheckID, CandidateID, CriminalBackground, EmploymentHistory, CheckStatus, CheckDate) VALUES
(9001, 1011, 'None', 'Verified', 'Completed', '2023-09-25'),
(9002, 1012, 'None', 'Verified', 'Completed', '2023-09-26'),
(9003, 1013, 'Minor', 'Verified', 'Pending', '2023-09-27'),
(9004, 1014, 'None', 'Verified', 'Completed', '2023-09-28'),
(9005, 1015, 'None', 'Verified', 'Completed', '2023-09-29'),
(9006, 1016, 'None', 'Verified', 'Completed', '2023-10-01'),
(9007, 1017, 'None', 'Verified', 'Completed', '2023-10-02'),
(9008, 1018, 'None', 'Verified', 'Completed', '2023-10-03'),
(9009, 1019, 'None', 'Verified', 'Completed', '2023-10-04'),
(9010, 1020, 'None', 'Verified', 'Completed', '2023-10-05');


INSERT INTO DrugTests (TestID, CandidateID, TestType, TestDate, Results) VALUES
(10001, 1011, 'Urine Test', '2023-09-30', 'Negative'),
(10002, 1012, 'Urine Test', '2023-10-01', 'Negative'),
(10003, 1013, 'Urine Test', '2023-10-02', 'Positive'),
(10004, 1014, 'Urine Test', '2023-10-03', 'Negative'),
(10005, 1015, 'Urine Test', '2023-10-04', 'Negative'),
(10006, 1016, 'Urine Test', '2023-10-05', 'Negative'),
(10007, 1017, 'Urine Test', '2023-10-06', 'Negative'),
(10008, 1018, 'Urine Test', '2023-10-07', 'Negative'),
(10009, 1019, 'Urine Test', '2023-10-08', 'Negative'),
(10010, 1020, 'Urine Test', '2023-10-09', 'Negative');


INSERT INTO Reimbursements (ReimbursementID, ApplicationID, RequestedAmount, ProcessedAmount, Status) VALUES
(11001, 4011, 200.00, 200.00, 'Processed'),
(11002, 4012, 150.00, 150.00, 'Processed'),
(11003, 4013, 180.00, 180.00, 'Processed'),
(11004, 4014, 300.00, 290.00, 'Processed'),
(11005, 4015, 250.00, 250.00, 'Processed'),
(11006, 4016, 190.00, 180.00, 'Processed'),
(11007, 4017, 210.00, 200.00, 'Processed'),
(11008, 4018, 100.00, 100.00, 'Processed'),
(11009, 4019, 200.00, 190.00, 'Processed'),
(11010, 4020, 250.00, 250.00, 'Processed');

INSERT INTO Onboarding (OnboardingID, CandidateID, JobID, StartDate, Status) VALUES
(12001, 1011, 2011, '2024-02-21', 'Active'),
(12002, 1012, 2012, '2024-03-16', 'Active'),
(12003, 1013, 2013, '2024-04-11', 'Pending'),
(12004, 1014, 2014, '2024-05-06', 'Active'),
(12005, 1015, 2015, '2024-06-13', 'Active'),
(12006, 1016, 2016, '2024-07-23', 'Pending'),
(12007, 1017, 2017, '2024-08-19', 'Active'),
(12008, 1018, 2018, '2024-09-02', 'Pending'),
(12009, 1019, 2019, '2024-10-26', 'Active'),
(12010, 1020, 2020, '2024-11-16', 'Active');

INSERT INTO FinancialRecords (TransactionID, Amount, TransactionDate, Description) VALUES
(NEWID(), 1500.00, '2024-05-01', 'Payment for medical equipment'),
(NEWID(), 200.00, '2024-05-02', 'Refund of overcharged fees'),
(NEWID(), 1200.00, '2024-05-03', 'Consultation fees for cardiology department'),
(NEWID(), 750.00, '2024-05-04', 'Purchase of new office furniture for clinic'),
(NEWID(), 350.00, '2024-05-05', 'Software license renewal for administrative operations');


USE Recruitment_Hospital;
SELECT * FROM information_schema.tables WHERE table_type = 'BASE TABLE';

Select * from Tests



--VIEW  1--

CREATE VIEW vw_CandidateStatus AS
SELECT 
    c.CandidateID, 
    c.Name, 
    c.Email, 
    c.Phone, 
    a.ApplicationDate, 
    a.Status
FROM 
    Candidates c
JOIN 
    Applications a ON c.CandidateID = a.CandidateID;

SELECT *
FROM vw_CandidateStatus;


--VIEW 2--
CREATE VIEW vw_JobOpeningsDetails AS
SELECT 
    j.JobID, 
    j.Position, 
    j.Title, 
    j.Type, 
    j.Medium, 
    j.StartDate, 
    jo.NumberOfPositions AS AvailablePositions
FROM 
    Jobs j
JOIN 
    JobOpenings jo ON j.JobID = jo.JobID;

SELECT *
FROM vw_JobOpeningsDetails;


--VIEW 3--

CREATE VIEW vw_CandidateInterview_Details AS
SELECT 
    c.CandidateID,
    c.Name AS CandidateName,
    c.Email,
    c.Phone,
    a.ApplicationID,
    a.Status AS ApplicationStatus,
    a.ApplicationDate,
    i.InterviewID,
    i.InterviewType,
    i.StartTime,
    i.EndTime,
    iv.Name AS InterviewerName,
    iv.Department AS InterviewerDepartment
FROM 
    Candidates c
JOIN 
    Applications a ON c.CandidateID = a.CandidateID
JOIN 
    Interviews i ON a.ApplicationID = i.ApplicationID
JOIN 
    Interviewers iv ON i.InterviewID = iv.InterviewerID;



SELECT *
FROM vw_CandidateInterview_Details;

SELECT 'Candidates Count' AS Table_Name, COUNT(*) AS Count FROM Candidates UNION ALL
SELECT 'Applications Count', COUNT(*) FROM Applications UNION ALL
SELECT 'Interviews Count', COUNT(*) FROM Interviews UNION ALL
SELECT 'Interviewers Count', COUNT(*) FROM Interviewers;



--VIEW 4--


CREATE VIEW vw_ReimbursementDetails AS
SELECT 
    r.ReimbursementID,
    c.Name AS CandidateName,
    a.ApplicationDate,
    r.RequestedAmount,
    r.ProcessedAmount,
    r.Status
FROM 
    Reimbursements r
JOIN 
    Applications a ON r.ApplicationID = a.ApplicationID
JOIN 
    Candidates c ON a.CandidateID = c.CandidateID;

SELECT *
FROM vw_ReimbursementDetails;

--Procedure 1--

CREATE PROCEDURE sp_AddCandidate
    @Name NVARCHAR(255),
    @Email NVARCHAR(255),
    @Phone NVARCHAR(50),
    @ShortProfile TEXT
AS
BEGIN
    INSERT INTO Candidates (Name, Email, Phone, ShortProfile)
    VALUES (@Name, @Email, @Phone, @ShortProfile);
END;

EXEC sp_AddCandidate @Name = 'Atharvaa Rane', @Email = 'atharvaa.rane@syr.edu', @Phone = '315-555-2974', @ShortProfile = 'Radiologist with a special interest in musculoskeletal imaging and sports injuries.';

SELECT * FROM Candidates WHERE Name = 'Atharvaa Rane';


--Procedure 2--
CREATE PROCEDURE sp_UpdateApplicationStatus
    @ApplicationID INT,
    @Status NVARCHAR(50)
AS
BEGIN
    UPDATE Applications
    SET Status = @Status
    WHERE ApplicationID = @ApplicationID;
END;

EXEC sp_UpdateApplicationStatus @ApplicationID = 4011, @Status = 'Under Review';

SELECT ApplicationID, Status FROM Applications WHERE ApplicationID = 4011;

--Procedure 3--

CREATE PROCEDURE sp_ScheduleInterview
    @ApplicationID INT,
    @InterviewType NVARCHAR(50),
    @StartTime DATETIME,
    @EndTime DATETIME
AS
BEGIN
    INSERT INTO Interviews (ApplicationID, InterviewType, StartTime, EndTime)
    VALUES (@ApplicationID, @InterviewType, @StartTime, @EndTime);
END;

EXEC sp_ScheduleInterview @ApplicationID = 4011, @InterviewType = 'Technical', @StartTime = '2023-12-01 10:00', @EndTime = '2023-12-01 11:00';

SELECT * FROM Interviews WHERE ApplicationID = 4011;


--Procedure 4--

CREATE PROCEDURE sp_ProcessReimbursement
    @ReimbursementID INT,
    @ProcessedAmount DECIMAL(10, 2),
    @Status NVARCHAR(50)
AS
BEGIN
    UPDATE Reimbursements
    SET ProcessedAmount = @ProcessedAmount,
        Status = @Status
    WHERE ReimbursementID = @ReimbursementID;
END;

EXEC sp_ProcessReimbursement @ReimbursementID = 11001, @ProcessedAmount = 200.00, @Status = 'Processed';

SELECT * FROM Reimbursements WHERE ReimbursementID = 11001;
-- Function 1 --

CREATE FUNCTION fn_DaysBetween 
(
    @StartDate DATE,
    @EndDate DATE
)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(DAY, @StartDate, @EndDate);
END;

SELECT dbo.fn_DaysBetween('2023-01-01', '2023-01-31') AS DaysBetween;

-- Function 2 --

CREATE FUNCTION fn_FormatPhoneNumber 
(
    @PhoneNumber VARCHAR(10)
)
RETURNS VARCHAR(14)
AS
BEGIN
    RETURN '(' + SUBSTRING(@PhoneNumber, 1, 3) + ') ' + SUBSTRING(@PhoneNumber, 4, 3) + '-' + SUBSTRING(@PhoneNumber, 7, 4);
END;

SELECT dbo.fn_FormatPhoneNumber('1234567890') AS FormattedPhone;

-- Function 3 --

CREATE FUNCTION fn_CountApplicationsPerJob 
(
    @JobID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*)
    FROM Applications
    WHERE JobOpeningID = @JobID;
    RETURN @Count;
END;

SELECT dbo.fn_CountApplicationsPerJob(3001) AS ApplicationCount;

-- FUNCTION 4 --

CREATE FUNCTION fn_GetLatestJobOpening
(
    @Position NVARCHAR(255)
)
RETURNS INT
AS
BEGIN
    DECLARE @JobID INT;
    SELECT TOP 1 @JobID = JobID
    FROM Jobs
    WHERE Position = @Position
    ORDER BY StartDate DESC;
    RETURN @JobID;
END;

SELECT dbo.fn_GetLatestJobOpening('Database Administrator') AS LatestJobID;

--TRIGGER 1--
CREATE TABLE Audit_Candidates (
    AuditID INT PRIMARY KEY,
    CandidateID INT,
    OldEmail NVARCHAR(255),
    NewEmail NVARCHAR(255),
    OldPhone NVARCHAR(20),
    NewPhone NVARCHAR(20),
    UpdateDate DATETIME
);

CREATE TRIGGER trg_AuditCandidateChanges
ON Candidates
AFTER UPDATE
AS
BEGIN
    IF (UPDATE(Email) OR UPDATE(Phone))
    BEGIN
        DECLARE @AuditID INT;

        -- Generate a unique value for AuditID
        SELECT @AuditID = ISNULL(MAX(AuditID), 0) + 1 FROM Audit_Candidates;

        INSERT INTO Audit_Candidates (AuditID, CandidateID, OldEmail, NewEmail, OldPhone, NewPhone, UpdateDate)
        SELECT 
            @AuditID,
            i.CandidateID,
            d.Email, i.Email,
            d.Phone, i.Phone,
            GETDATE()
        FROM 
            inserted i
        JOIN 
            deleted d ON i.CandidateID = d.CandidateID;
    END
END;


UPDATE Candidates SET Email = 'newemail@example.com' WHERE CandidateID = 1012;
SELECT * FROM Audit_Candidates;


--TRIGGER 2--

CREATE TRIGGER trg_PreventDeletionIfApplicationsExist
ON Candidates
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Applications a JOIN deleted d ON a.CandidateID = d.CandidateID)
    BEGIN
        RAISERROR ('Cannot delete candidates with existing applications.', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM Candidates WHERE CandidateID IN (SELECT CandidateID FROM deleted);
    END
END;

DELETE FROM Candidates WHERE CandidateID = 1012;

--TRIGGER 3--


CREATE TRIGGER trg_UpdateJobOpeningCounts
ON Applications
AFTER INSERT
AS
BEGIN
    UPDATE JobOpenings
    SET NumberOfPositions = NumberOfPositions - 1
    FROM JobOpenings jo
    JOIN inserted i ON jo.JobID = i.JobOpeningID
    WHERE i.Status = 'Accepted'
END;
SELECT JobID, NumberOfPositions FROM JobOpenings;

--TRIGGER 4--
CREATE TABLE Interview_Log (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    InterviewID INT,
    ApplicationID INT,
    InterviewType VARCHAR(100),
    ScheduledTime DATETIME
);


CREATE TRIGGER trg_LogNewInterviews
ON Interviews
AFTER INSERT
AS
BEGIN
    INSERT INTO Interview_Log (InterviewID, ApplicationID, InterviewType, ScheduledTime)
    SELECT InterviewID, ApplicationID, InterviewType, StartTime
    FROM inserted;
END;

INSERT INTO Interviews (InterviewID, ApplicationID, InterviewType, StartTime)
VALUES (5011, 4021, 'Phone Interview', '2024-05-01 10:00:00'); 

SELECT * FROM Interview_Log;  

--Transaction to Add a New Job and Corresponding Opening--

BEGIN TRANSACTION;
    BEGIN TRY
        -- Insert a new job
        INSERT INTO Jobs (JobID, Position, Title, Type, Medium, StartDate, JobDescription)
        VALUES (2021, 'Lab Technician', 'Senior Lab Technician', 'Full-time', 'Onsite', '2024-01-15', 'Responsible for managing laboratory tests.');

        -- Insert a job opening for the new job
        INSERT INTO JobOpenings (OpeningID, JobID, NumberOfPositions)
        VALUES (3021, 2021, 3);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error occurred: ' + ERROR_MESSAGE();
    END CATCH

-- 2. Transaction to Update Candidate Status and Log the Change -- 
CREATE TABLE ApplicationStatusLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    ApplicationID INT,
    Status VARCHAR(50),
    ChangeDate DATETIME
);

BEGIN TRANSACTION;
    BEGIN TRY
        -- Update the application status
        UPDATE Applications
        SET Status = 'Under Review'
        WHERE ApplicationID = 4011;

        -- Log the status change
        INSERT INTO dbo.ApplicationStatusLog (ApplicationID, Status, ChangeDate)
        VALUES (4011, 'Under Review', GETDATE());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error occurred: ' + ERROR_MESSAGE();
    END CATCH



--3. Transaction to Process a Candidate's Onboarding and Update Job Opening

BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @NewOnboardingID INT;

        -- Determine a new unique OnboardingID by finding the maximum current ID and adding 1
        SELECT @NewOnboardingID = ISNULL(MAX(OnboardingID), 0) + 1 FROM Onboarding;

        -- Insert onboarding details with a specific OnboardingID
        INSERT INTO Onboarding (OnboardingID, CandidateID, JobID, StartDate, Status)
        VALUES (@NewOnboardingID, 1020, 2021, '2024-02-21', 'Active');

        -- Update the job opening to decrease the number of positions
        UPDATE JobOpenings
        SET NumberOfPositions = NumberOfPositions - 1
        WHERE JobID = 2021 AND NumberOfPositions > 0;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error occurred: ' + ERROR_MESSAGE();
    END CATCH




--4. Transaction to Handle Reimbursements and Update Financial Records

BEGIN TRANSACTION;
    BEGIN TRY
        -- Update reimbursement status to 'Processed'
        UPDATE Reimbursements
        SET ProcessedAmount = 150.00, Status = 'Processed'
        WHERE ReimbursementID = 11001;

        -- Insert financial record for the reimbursement
        INSERT INTO FinancialRecords (TransactionID, Amount, TransactionDate, Description)
        VALUES (NEWID(), 150.00, GETDATE(), 'Reimbursement for candidate travel expenses');

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error occurred: ' + ERROR_MESSAGE();
    END CATCH


-- Script1 Cleanup Old Applications --
CREATE PROCEDURE sp_CleanupOldApplications
AS
BEGIN
    DELETE FROM Applications
    WHERE ApplicationDate < DATEADD(year, -1, GETDATE())
    AND Status IN ('Rejected', 'Withdrawn');
END;

EXEC sp_CleanupOldApplications;

-- Ensure Job Openings Count Integrity
CREATE TRIGGER trg_EnsurePositiveOpenings
ON JobOpenings
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM JobOpenings WHERE NumberOfPositions < 0)
    BEGIN
        RAISERROR ('Number of positions cannot be negative.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;  

-- Report on Applications Per Job
CREATE PROCEDURE sp_ReportApplicationsPerJob
AS
BEGIN
    SELECT j.Position, COUNT(a.ApplicationID) AS TotalApplications
    FROM Jobs j
    JOIN Applications a ON j.JobID = a.JobOpeningID
    GROUP BY j.Position;
END;

EXEC sp_ReportApplicationsPerJob;

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'hr_assistant')
    CREATE ROLE hr_assistant;
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'hr_manager')
    CREATE ROLE hr_manager;

-- Grant read-only access to HR assistants
GRANT SELECT ON dbo.Candidates TO hr_assistant;
GRANT SELECT ON dbo.Applications TO hr_assistant;

-- Grant full access to HR managers
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Candidates TO hr_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Applications TO hr_manager;  

-- Create user linked to an existing login for HR assistant
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'user_hr_assistant')
    CREATE USER user_hr_assistant FOR LOGIN login_hr_assistant;
ALTER ROLE hr_assistant ADD MEMBER user_hr_assistant;

-- Create user linked to an existing login for HR manager
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'user_hr_manager')
    CREATE USER user_hr_manager FOR LOGIN login_hr_manager;
ALTER ROLE hr_manager ADD MEMBER user_hr_manager;

-- CTE 1. Report on Candidate Application Status --

WITH CandidateStatus AS (
    SELECT
        c.CandidateID,
        c.Name,
        c.Email,
        a.ApplicationDate,
        a.Status,
        DENSE_RANK() OVER (PARTITION BY a.CandidateID ORDER BY a.ApplicationDate DESC) AS Rank
    FROM
        Candidates c
    JOIN
        Applications a ON c.CandidateID = a.CandidateID
)
SELECT
    CandidateID,
    Name,
    Email,
    ApplicationDate,
    Status
FROM
    CandidateStatus
WHERE
    Rank = 1;


--CTE 2. Report on Interview Scheduling Efficiency --

SELECT
    a.CandidateID,
    c.Name,
    MIN(i.StartTime) AS FirstInterviewDate,
    a.ApplicationDate,
    DATEDIFF(DAY, a.ApplicationDate, MIN(i.StartTime)) AS DaysToFirstInterview
FROM
    Applications a
JOIN
    Candidates c ON a.CandidateID = c.CandidateID
JOIN
    Interviews i ON a.ApplicationID = i.ApplicationID
GROUP BY
    a.CandidateID,
    c.Name,
    a.ApplicationDate
HAVING
    DATEDIFF(DAY, a.ApplicationDate, MIN(i.StartTime)) IS NOT NULL; 


--CTE 3. Report on Job Openings and Fill Rate -- 

SELECT
    j.JobID,
    j.Position,
    j.Title,
    jo.NumberOfPositions AS InitialOpenings,
    (jo.NumberOfPositions - COUNT(a.ApplicationID)) AS CurrentOpenings,
    COUNT(a.ApplicationID) AS PositionsFilled,
    CAST(COUNT(a.ApplicationID) AS FLOAT) / jo.NumberOfPositions * 100 AS FillPercentage
FROM
    JobOpenings jo
JOIN
    Jobs j ON jo.JobID = j.JobID
LEFT JOIN
    Applications a ON jo.JobID = a.JobOpeningID AND a.Status = 'Accepted'
GROUP BY
    j.JobID, j.Position, j.Title, jo.NumberOfPositions;

-- CTE 4. Report on Recruitment Expenses -- 

SELECT
    c.CandidateID,
    c.Name,
    SUM(r.ProcessedAmount) AS TotalExpenses,
    a.Status
FROM
    Reimbursements r
JOIN
    Applications a ON r.ApplicationID = a.ApplicationID
JOIN
    Candidates c ON a.CandidateID = c.CandidateID
GROUP BY
    c.CandidateID, c.Name, a.Status;


SELECT 
    j.JobID, 
    j.Position, 
    jo.NumberOfPositions AS TotalOpenings,
    COUNT(a.ApplicationID) AS ApplicationsReceived,
    SUM(CASE WHEN a.Status = 'Accepted' THEN 1 ELSE 0 END) AS PositionsFilled
FROM 
    Jobs j
JOIN 
    JobOpenings jo ON j.JobID = jo.JobID
LEFT JOIN 
    Applications a ON jo.OpeningID = a.JobOpeningID
GROUP BY 
    j.JobID, j.Position, jo.NumberOfPositions;
