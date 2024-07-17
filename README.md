# University Hospital Recruitment System
This project aims to develop a comprehensive recruitment database system for a University Medical Center, enhancing the efficiency and transparency of the recruitment process.

## Table of Contents
- [Introduction](#introduction)
- [Problem Definition](#problem-definition)
- [Available Data](#available-data)
- [Database Design](#database-design)
- [Implementation](#implementation)
- [Results](#results)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)

## Introduction

Efficient and empathetic recruitment processes are vital in healthcare to attract and maintain a workforce capable of delivering high-quality patient care. This project addresses recruitment challenges by developing an advanced and adaptable database system.

## Problem Definition

The objective is to develop a tailored database system for a University Medical Center to manage the recruitment process, from job applications and candidate evaluations to interviews and onboarding, ensuring data integrity and user accessibility.

## Available Data

The system includes key entities such as Candidates, Jobs, Job Openings, Applications, Interviews, Tests, and related entities. The database structure is designed to reflect real-world recruitment processes, including data for:

- Candidates
- Job Openings
- Applications
- Interviews
- Background Checks
- Drug Tests
- Reimbursements
- Onboarding

## Database Design

Key features include:

- ER Diagram: Illustrates the relationships between entities.
- Create Commands: Define the structure of tables and relationships.
- Insert Commands: Populate tables with initial data.
- View Commands: Simplify querying common data sets.
- Procedure Commands: Automate routine operations.
- Functions: Custom functions to perform specific tasks.
- Triggers: Maintain data consistency and log changes.
- Scripts: Automate data cleanup, ensure data integrity, generate reports, and manage user access.
- Transactions: Ensure atomicity and consistency in multi-step operations.
- Common Table Expressions (CTEs): Simplify complex queries.

## Implementation

The project establishes a comprehensive recruitment database using MySQL, structured to facilitate detailed tracking of job applications and recruitment processes. Security roles and permissions are implemented to safeguard sensitive data. Docker is used to containerize the database, and Azure Data Studio is used for database management and visualization.

## Results

The system provides tools for generating insightful analytics, such as reports on time-to-hire metrics, effectiveness of recruitment channels, and interviewer performance. Anticipated benefits include reduced time and resources spent on recruitment activities and improved decision-making through detailed analytical reports.

## Technologies Used

- MySQL
- Azure Data Studio
- Docker

## Installation

1.	Clone the Repository:

```
git clone https://github.com/atharvaa27/University_Hospital_Recruitment.git
cd University_Hospital_Recruitment
```

2.	Set Up MySQL Database:
- Use Docker to run a MySQL container:

```
docker run --name university_hospital_db -e MYSQL_ROOT_PASSWORD=yourpassword -d mysql:latest
```


- Use Azure Data Studio to connect to the MySQL container and execute the Create Commands script to set up the database schema.
- Execute the Insert Commands script to populate the database with initial data.

## Usage

1.	Run Views and Procedures:
  -  Execute View Commands for common queries.
  -  Execute Procedure Commands to automate operations.
  -  Use Functions and Triggers for additional functionality.
2.	Generate Reports:
  -  Use provided scripts to generate business reports.
