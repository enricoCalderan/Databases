CREATE TABLE Students(
    idnr VARCHAR(10) PRIMARY KEY CHECK (LENGTH(idnr)=10),
    name VARCHAR(100) NOT NULL,
    login VARCHAR(50) NOT NULL,
    program VARCHAR(100) NOT NULL
);

CREATE TABLE Branches(
    name VARCHAR(100)  NOT NULL,
    program VARCHAR(100) NOT NULL,
    PRIMARY KEY (name, program)

);
    
CREATE TABLE Courses(
    code VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits NUMERIC NOT NULL CHECK (credits > 0),
    department VARCHAR(100) NOT NULL
);

CREATE TABLE LimitedCourses(
    code VARCHAR(10) NOT NULL REFERENCES Courses(code),
    capacity INT NOT NULL CHECK (capacity > 0),
    PRIMARY KEY (code)
);
    
CREATE TABLE StudentBranches(
    student VARCHAR(10) PRIMARY KEY REFERENCES Students(idnr),
    branch VARCHAR(100) NOT NULL,
    program VARCHAR(100) NOT NULL,
    FOREIGN KEY (branch, program) REFERENCES Branches(name, program)
);

CREATE TABLE Classifications(
    name VARCHAR(100) PRIMARY KEY
);

CREATE TABLE Classified(
    course VARCHAR(10) NOT NULL REFERENCES Courses(code),
    classification VARCHAR(100) NOT NULL REFERENCES Classifications(name),
    PRIMARY KEY (course, classification)
);

CREATE TABLE MandatoryProgram(
    course VARCHAR(10) NOT NULL REFERENCES Courses(code),
    program VARCHAR(100) NOT NULL,
    PRIMARY KEY (course, program)
);

CREATE TABLE MandatoryBranch(
    course VARCHAR(10) NOT NULL REFERENCES Courses(code),
    branch VARCHAR(100) NOT NULL,
    program VARCHAR(100) NOT NULL,
    FOREIGN KEY (branch, program) REFERENCES Branches(name, program),
    PRIMARY KEY (course, branch, program)
);

CREATE TABLE RecommendedBranch(
    course VARCHAR(10) NOT NULL REFERENCES Courses(code),
    branch VARCHAR(100) NOT NULL,
    program VARCHAR(100) NOT NULL,
    FOREIGN KEY (branch, program) REFERENCES Branches(name, program),
    PRIMARY KEY (course, branch, program)
);

CREATE TABLE Registered(
    student VARCHAR(10) NOT NULL REFERENCES Students(idnr),
    course VARCHAR(10) NOT NULL REFERENCES Courses(code),
    PRIMARY KEY (student, course)
);

CREATE TABLE Taken(
    student VARCHAR(10) NOT NULL REFERENCES Students(idnr),
    course VARCHAR(10) NOT NULL REFERENCES Courses(code),
    grade CHAR(1) NOT NULL CHECK (grade  IN('U','3','4','5')),
    PRIMARY KEY (student, course)
);

CREATE TABLE WaitingList(
    student VARCHAR(10) NOT NULL REFERENCES Students(idnr),
    course VARCHAR(10) NOT NULL REFERENCES LimitedCourses(code),
    position INT NOT NULL CHECK (position > 0),
    PRIMARY KEY (student, course),
    UNIQUE (course, position)
);