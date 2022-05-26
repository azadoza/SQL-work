--1 List car rental companies which have a mileage of at least 27 miles/gallon
SELECT RentalCompany FROM ByCar WHERE Mileage LIKE '27';

--2 List trip IDs taken on train costing strictly more than $150
SELECT b.tid FROM ByTrain B, Trips T WHERE T.Fare  > '150' AND t.tid=b.tid;

--3 Find trip IDs and their fare that are not taken in the US i.e., `Non-US` trip
SELECT TID,fare FROM trips WHERE tripstate = 'Non-US';

--4 Find the business class plane trip IDs that are greater than $1000.
SELECT p.tid FROM ByPlane P, Trips T WHERE T.Fare  > '1000' AND t.tid=p.tid AND p.class = 'Business';

--5 Find any car trip more expensive than a trip taken on a train in the same state or outside the country.
SELECT DISTINCT * FROM Trips C1, Trips T1 WHERE C1.TripState = T1.TripState AND C1.Fare > T1.Fare AND c1.travelmode = 'Car' AND t1.travelmode = 'Train';

--6  List pairs of distinct trips that have exactly the same value of mileage
SELECT * FROM ByCar C1, ByCar C2 WHERE c2.mileage = c1.mileage AND c1.tid != c2.tid;

--7  List pairs of distinct train trips that do not have the same speed
SELECT * FROM ByTrain T1 INNER JOIN ByTrain T2 on t1.trainspeed != t2.trainspeed;

--8 Find those pair of trips in the same state with the same mode of travel. List such pairs only once. In other words, given a pair (TID1,TID2) do NOT list (TID2,TID1)
SELECT * FROM Trips T1, Trips T2 where T1.travelmode = t2.travelmode AND t1.tripstate = t2.tripstate AND t1.tid > t2.tid;

--9 Find a state in which trips have been taken by all three modes of transportation: train, plane, and car.
SELECT  t1.tripstate,t2.tripstate,t3.tripstate 
FROM Trips T1, Trips T2, Trips T3 
WHERE t1.tripstate = t2.tripstate AND t2.tripstate=t3.tripstate and t1.tripstate=t3.tripstate INTERSECT 
SELECT  t1.tripstate,t2.tripstate,t3.tripstate FROM trips T1, trips T2, trips T3 
WHERE t1.travelmode!=t2.travelmode AND t2.travelmode!=t3.travelmode AND t1.travelmode!=t3.travelmode;

--10 Find the details of a) the most costly trip, b) the cheapest trip, regardless of the travel mode. Write two separate queries for (a) and (b). Write both (a) and (b) as a self-join with basic SQL operators (Filter, Project, Rename, Join (cross-join, natural join), Union, Intersect, and Difference). Do not use ALL, ANY, DISTINCT, GROUP BY, HAVING, MAX, MIN, ORDER BY
SELECT TID, FARE from Trips
MINUS
(SELECT T1.TID, T1.fare FROM Trips T1, Trips T2
WHERE T1.TID != T2.TID AND T1.fare <= T2.fare);