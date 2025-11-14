CREATE DATABASE week7;
use week7;

CREATE TABLE Supplier (
    sid INT PRIMARY KEY,
    sname VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Parts (
    pid INT PRIMARY KEY,
    pname VARCHAR(50),
    color VARCHAR(20)
);

CREATE TABLE Catalog (
    sid INT,
    pid INT,
    cost INT,
    PRIMARY KEY (sid, pid),
    FOREIGN KEY (sid) REFERENCES Supplier(sid),
    FOREIGN KEY (pid) REFERENCES Parts(pid)
);

INSERT INTO Supplier VALUES
(10001, 'Acme Widget', 'Bangalore'),
(10002, 'Johns', 'Kolkata'),
(10003, 'Vimal', 'Mumbai'),
(10004, 'Reliance', 'Delhi');

INSERT INTO Parts VALUES
(20001, 'Book', 'Red'),
(20002, 'Pen', 'Red'),
(20003, 'Pencil', 'Green'),
(20004, 'Mobile', 'Green'),
(20005, 'Charger', 'Black');

INSERT INTO Catalog VALUES
(10001, 20001, 10),
(10001, 20002, 10),
(10001, 20003, 30),
(10001, 20004, 10),
(10001, 20005, 10),
(10002, 20001, 10),
(10002, 20002, 20),
(10003, 20003, 30),
(10004, 20003, 40);

-- Queries to execute

SELECT DISTINCT p.pname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid;

SELECT S.SNAME
from Supplier s
Join catalog c on s.sid = c.sid
group by s.sid, s.sname
having count(distinct c.pid) = (select count(*) from parts);

SELECT S.SNAME
from Supplier s
Join catalog c on s.sid = c.sid
join parts p on c.pid = p.pid
where p.color = 'Red'
Group by s.sid,s.sname
having count(distinct p.pid) = (select count(*) from parts where color = 'Red');

SELECT p.pname
FROM Parts p
JOIN Catalog c ON p.pid = c.pid
WHERE c.sid = 10001
AND p.pid NOT IN (
    SELECT pid
    FROM Catalog
    WHERE sid != 10001
);

SELECT DISTINCT c1.sid
FROM Catalog c1
JOIN (
    SELECT pid, AVG(cost) AS avg_cost
    FROM Catalog
    GROUP BY pid
) avg_table ON c1.pid = avg_table.pid
WHERE c1.cost > avg_table.avg_cost;

SELECT c.pid, s.sname
FROM Catalog c
JOIN Supplier s ON c.sid = s.sid
WHERE (c.pid, c.cost) IN (
    SELECT pid, MAX(cost)
    FROM Catalog
    GROUP BY pid
);

