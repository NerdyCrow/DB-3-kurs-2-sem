use map;
select * from map;
INSERT INTO ContactCoordinate (contact_id, location)
VALUES (1, geography::Point(47.6097, -122.3331, 4326), GETDATE());

INSERT INTO ContactCoordinate (contact_id, location)
VALUES (2, geography::Point(51.5072, -0.1276, 4326), GETDATE());

INSERT INTO ContactCoordinate (contact_id, location)
VALUES (8, geography::Point(40.7128, -74.0060, 4326), GETDATE());

INSERT INTO ContactCoordinate (contact_id, location)
VALUES (12, geography::Point(51.5074, -0.1278, 4326), GETDATE());

INSERT INTO ContactCoordinate (contact_id, location)
VALUES (13, geography::Point(34.0522, -118.2437, 4326), GETDATE());
go
--карта покрытия
declare @g geometry = geometry::STGeomFromText('Point(0 0)', 0);
select @g.STBuffer(5), @g.STBuffer(5).ToString() as WKT from map

-------------------------------------------**********************************

-- Contact, который ближе всегок указаной точке:
use SoftLicenseManagement
DECLARE @c1 geography;
SET @c1 = geography::Point(57.6097, -124.3331, 4326);

SELECT TOP 1 cntct.Name, cntct.Email, ccrd.location.STDistance(@c1) AS distance
FROM ContactCoordinate ccrd
JOIN Contacts cntct ON cntct.id = ccrd.contact_id
ORDER BY ccrd.location.STDistance(@c1) ASC;


select * from ContactCoordinate
--Contact на определённом расстоянии от точки:

DECLARE @c2 geography;
SET @c2 = geography::Point(57.6097, -124.3331, 4326);

SELECT cntct.Name, cntct.Email, ccrd.location.STDistance(@c2) AS distance
FROM ContactCoordinate ccrd
JOIN Contacts cntct ON cntct.id = ccrd.contact_id
WHERE ccrd.location.STDistance(@c2) <= 2000000
ORDER BY ccrd.location.STDistance(@c2) ASC;

--Пересечение с полигоном:


DECLARE @polygon geography = geography::STGeomFromText('POLYGON((+120.0 30.0, 120.0 40.0, 110.0 40.0, 110.0 30.0, 120.0 30.0))', 4326);

SELECT *
FROM ContactCoordinate
WHERE @polygon.STIntersects(location) = 1;




---Изменить(Уточнить)
DECLARE @g geometry;  
SET @g = geometry::STGeomFromText('POLYGON((0 0, 0 1, 1 1, 1 0, 0 0))', 0); 
SET @g = @g.STUnion(geometry::Point(2,1,0));

SELECT @g.STAsText();

---------------расстояние между контактами
DECLARE @contact1 geography, @contact2 geography
SET @contact1 = (SELECT location FROM ContactCoordinate WHERE contact_id = 1)
SET @contact2 = (SELECT location FROM ContactCoordinate WHERE contact_id = 8)

SELECT @contact1.STDistance(@contact2) / 1000 AS DistanceInKm

-- Исключение(пространственное перекрытие)
SELECT cntct.id,cntct.Name, cntct.Email, ccrd.location
FROM Contacts cntct
JOIN ContactCoordinate ccrd ON cntct.id = ccrd.contact_id
WHERE ccrd.location.STDisjoint(geography::Point(51.5072, -0.1276, 4326).STBuffer(5000)) = 1;

--Пересечение
create procedure usp_Cross
as begin
SELECT * FROM ContactCoordinate
WHERE location.STIntersects(geography::Point(51.5072, -0.1276, 4326).STBuffer(5000)) = 1;
end

DECLARE @g geography;  
DECLARE @h geography;  
SET @g = geography::STGeomFromText('POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326);  
SET @h = geography::STGeomFromText('POLYGON((-122.351 47.656, -122.341 47.656, -122.341 47.661, -122.351 47.661, -122.351 47.656))', 4326);  
SELECT @g.STIntersection(@h) as 'Точки пересечения';
--Объединение
DECLARE @g geography;  
DECLARE @h geography;  
SET @g = geography::STGeomFromText('POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326);  
SET @h = geography::STGeomFromText('POLYGON((-122.351 47.656, -122.341 47.656, -122.341 47.661, -122.351 47.661, -122.351 47.656))', 4326);  
SELECT @g.STUnion(@h) as 'Объединение экземпляров';

--Разница
DECLARE @g geography;  
DECLARE @h geography;  
SET @g = geography::STGeomFromText('POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326);  
SET @h = geography::STGeomFromText('POLYGON((-122.351 47.656, -122.341 47.656, -122.341 47.661, -122.351 47.661, -122.351 47.656))', 4326);  
SELECT @g.STSymDifference(@h);




--Уточнение


drop procedure Distancecontact
create procedure Distancecontact
@contactID1 int,
@contactID2 int,
@result float output
as
begin 
DECLARE @contact1 geography, @contact2 geography
SET @contact1 = (SELECT location FROM ContactCoordinate WHERE contact_id = @contactID1)
SET @contact2 = (SELECT location FROM ContactCoordinate WHERE contact_id = @contactID2)

set @result = (SELECT @contact1.STDistance(@contact2) / 1000 )
end
declare @result float
exec Distancecontact 1,8, @result output
print @result





select * from ContactCoordinate where id=2

select * from map

--задание 
create PROCEDURE [dbo].[GetClosestContact]
    @contactId int
AS
BEGIN
    DECLARE @targetLocation geography
    
    -- Получить координаты указанного контакта
    SELECT @targetLocation = location
    FROM ContactCoordinate
    WHERE contact_id = @contactId
    
    -- Получить координаты всех остальных контактов
    SELECT top 1 cc.contact_id, cc.location.STDistance(@targetLocation) AS distance
    FROM ContactCoordinate cc
    WHERE cc.contact_id <> @contactId
    ORDER BY distance ASC
END
EXEC GetClosestContact @contactId = 2
