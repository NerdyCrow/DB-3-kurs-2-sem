select * from map;

declare @g geometry = geometry::STGeomFromText('Point(0 0)', 0);
select @g.STBuffer(5), @g.STBuffer(5).ToString() as WKT from map;

--Объединение
DECLARE @g geography;  
DECLARE @h geography;  
SET @g = geography::STGeomFromText('POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326);  
SET @h = geography::STGeomFromText('POLYGON((-122.351 47.656, -122.341 47.656, -122.341 47.661, -122.351 47.661, -122.351 47.656))', 4326);  
SELECT @g.STUnion(@h);


--Исключение
DECLARE @g geography;  
DECLARE @h geography;  
SET @g = geography::STGeomFromText('POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326);  
SET @h = geography::STGeomFromText('POLYGON((-122.351 47.656, -122.341 47.656, -122.341 47.661, -122.351 47.661, -122.351 47.656))', 4326);  
SELECT @g.STSymDifference(@h);

-- высчитывает расстояние между двумя точками
begin
    declare @a geography
    declare @b geography
    set @a=(select HOME_ADDRESS from STUDENT where STUDENT='БЛШ')
    set @b=(select HOME_ADDRESS from STUDENT where STUDENT='МНВ')
    select @a.STDistance(@b)        
end;

--Уточнение
DECLARE @g geography = 'LineString(120 45, 120.1 45.1, 199.9 45.2, 120 46)'  
SELECT @g.Reduce(10000).ToString()


CREATE SPATIAL INDEX MySpatialIndex ON STUDENT(HOME_ADDRESS) USING GEOGRAPHY_GRID;

drop index MySpatialIndex on student;



DECLARE @q geography = 'LineString(120 45, 120.1 45.1, 199.9 45.2, 120 46)';
select * from STUDENT where HOME_ADDRESS.STDistance(@q) < 6500000;