use map;
select * from map;

go
declare @g geometry = geometry::STGeomFromText('Point(0 0)', 0);
select @g.STBuffer(5), @g.STBuffer(5).ToString() as WKT from map

-------------------------------------------**********************************
-- Пользоватеь, который ближе всего к указаной точке:
DECLARE @c1 geography;
SET @c1 = geography::Point(57.6097, -124.3331, 4326);

SELECT TOP 1 u.first_name, u.last_name, ul.location.STDistance(@c1) AS distance
FROM UserLocation ul
JOIN Users u ON u.id = ul.user_id
ORDER BY ul.location.STDistance(@c1) ASC;



--Пользователи на определённом расстоянии от точки:

DECLARE @c2 geography;
SET @c2 = geography::Point(57.6097, -124.3331, 4326);

SELECT u.first_name, u.last_name, ul.location.STDistance(@c2) AS distance
FROM UserLocation ul
JOIN Users u ON u.id = ul.user_id
WHERE ul.location.STDistance(@c2) <= 2000000
ORDER BY ul.location.STDistance(@c2) ASC;

--Пересечение с полигоном:

--DECLARE @polygon geography = geography::STGeomFromText('POLYGON((-122.3321 47.6062, -122.3381 47.6062, -122.3381 47.6102, -122.3321 47.6102, -122.3321 47.6062))', 4326);

DECLARE @polygon geography = geography::STGeomFromText('POLYGON((-120.0 30.0, -120.0 40.0, -110.0 40.0, -110.0 30.0, -120.0 30.0))', 4326);

SELECT *
FROM UserLocation
WHERE @polygon.STIntersects(location) = 1;




---------------расстояние между пользователями
DECLARE @user1 geography, @user2 geography
SET @user1 = (SELECT location FROM UserLocation WHERE user_id = 1)
SET @user2 = (SELECT location FROM UserLocation WHERE user_id = 2)

SELECT @user1.STDistance(@user2) / 1000 AS DistanceInKm

-- Исключение
SELECT u.id,u.first_name, u.last_name, ul.location
FROM Users u
JOIN UserLocation ul ON u.id = ul.user_id
WHERE ul.location.STDisjoint(geography::Point(51.5072, -0.1276, 4326).STBuffer(5000)) = 1;

--Пересечение
SELECT *
FROM UserLocation
WHERE location.STIntersects(geography::Point(51.5072, -0.1276, 4326).STBuffer(5000)) = 1;

--Объединение
DECLARE @g geography;  
DECLARE @h geography;  
SET @g = geography::STGeomFromText('POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326);  
SET @h = geography::STGeomFromText('POLYGON((-122.351 47.656, -122.341 47.656, -122.341 47.661, -122.351 47.661, -122.351 47.656))', 4326);  
SELECT @g.STUnion(@h);


DECLARE @g geography;  
DECLARE @h geography;  
SET @g = geography::STGeomFromText('POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326);  
SET @h = geography::STGeomFromText('POLYGON((-122.351 47.656, -122.341 47.656, -122.341 47.661, -122.351 47.661, -122.351 47.656))', 4326);  
SELECT @g.STSymDifference(@h);


DECLARE @g geography;  
DECLARE @h geography;  
SET @g = geography::STGeomFromText('POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326);  
SET @h = geography::STGeomFromText('POLYGON((-122.351 47.656, -122.341 47.656, -122.341 47.661, -122.351 47.661, -122.351 47.656))', 4326);  
SELECT @g.STIntersection(@h);

--Уточнение
DECLARE @g geography = 'LineString(120 45, 120.1 45.1, 199.9 45.2, 120 46)'  
SELECT @g.Reduce(10000).ToString()