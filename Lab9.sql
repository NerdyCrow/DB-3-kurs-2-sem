----Вычисление итогов стоимости определенного вида ПО за период:
--	количество и стоимость лицензий;
--	сравнение их с общим количество лицензий (в %);
--	сравнение их с общей стоимостью лицензий (в %).


--1.1
SELECT COUNT(*) AS LicenseCount, SUM(s.Price) AS LicenseCost
FROM Licenses l
INNER JOIN Software s ON l.SoftwareId = s.Id
WHERE l.PaymentDate >= '02-05-2023' AND l.PaymentDate <= '15-04-2024';
select * from licenses

--1.2
SELECT 
    COUNT(*) AS LicenseCount,
    SUM(s.Price) AS LicenseCost,
    CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM Licenses) * 100 AS LicensePercentage
FROM Licenses l
INNER JOIN Software s ON l.SoftwareId = s.Id
WHERE l.PaymentDate >= '02-05-2023' AND l.PaymentDate <= '15-04-2024';

--1.3
SELECT 
    COUNT(*) AS LicenseCount,
    SUM(s.Price) AS LicenseCost,
    SUM(s.Price) / (SELECT SUM(Price) FROM Software) * 100 AS LicensePercentage
FROM Licenses l
INNER JOIN Software s ON l.SoftwareId = s.Id
WHERE l.PaymentDate >= '02-05-2023' AND l.PaymentDate <= '15-04-2024';

--3
---3.	Продемонстрируйте применение функции ранжирования 
--ROW_NUMBER() для разбиения результатов запроса на страницы (по 20 строк на каждую страницу).
select * from Contacts

DECLARE @i INT = 1;
WHILE (@i <= 20)
BEGIN
    INSERT INTO Contacts(Name,Email,Address,Phone)
   VALUES ('user'+CAST(@i AS VARCHAR), 'user'+CAST(@i AS VARCHAR)+'@mail.com','UserCity' + CAST(@i AS VARCHAR), RAND());    
    SET @i = @i + 1;
END
select * from Contacts
SELECT * FROM Contacts ORDER BY id OFFSET 11 ROWS FETCH NEXT 11 ROWS ONLY;
--------------5-------------------------------------------
SELECT *
FROM (
  SELECT ROW_NUMBER() OVER (ORDER BY Name DESC) AS RowNum, *
  FROM Contacts
) AS ContactRownum
WHERE RowNum BETWEEN 1 AND 10
ORDER BY Name DESC;


DECLARE @items_per_page INT = 15;
DECLARE @current_page INT = 2  ;
 
-- Запрос с использованием функции OFFSET FETCH и ROW_NUMBER()
SELECT *
FROM (
  SELECT ROW_NUMBER() OVER (ORDER BY Name DESC) AS RowNum, Name
  FROM Contacts
) AS ContactsWithRowNum
WHERE RowNum > (@current_page - 1) * @items_per_page
ORDER BY Name DESC
OFFSET 0 ROWS FETCH NEXT @items_per_page ROWS ONLY;

--4.  Продемонстрируйте применение функции ранжирования ROW_NUMBER() для удаления дубликатов.

INSERT INTO Contacts(Name,Email,Address,Phone)
   VALUES ('user'+CAST(20 AS VARCHAR), 'user'+CAST(20 AS VARCHAR)+'@mail.com','UserCity' + CAST(20 AS VARCHAR), RAND())
WITH NumberedRows AS (
  SELECT ROW_NUMBER() OVER (
    PARTITION BY Name, Email
    ORDER BY ID
  ) as RowNum, *
  FROM Contacts
)
DELETE FROM NumberedRows
WHERE RowNum > 1;
select * from Contacts

--5
---Вернуть для каждого вендора суммы затраченных на лицензирование средств за последние 6 месяцев помесячно
select * from Licenses

-----5
SELECT
    DATEPART(YEAR, L.PaymentDate) AS Year,
    DATEPART(MONTH, L.PaymentDate) AS Month,
    O.ContactId,
    SUM(S.Price) AS TotalSpent
FROM
    Licenses L
    INNER JOIN Software S ON L.SoftwareId = S.Id
    INNER JOIN Owners O ON S.OwnerId = O.Id
WHERE
    L.PaymentDate >= DATEADD(MONTH, -6, GETDATE()) and  L.PaymentDate<=GETDATE()
GROUP BY
    DATEPART(YEAR, L.PaymentDate),
    DATEPART(MONTH, L.PaymentDate),
    O.ContactId;

	
	
	--6
	select * from Software
WITH RankedSoftware AS (
    SELECT
        s.Type,
        s.DeviceType,
        ROW_NUMBER() OVER (
            PARTITION BY s.DeviceType
            ORDER BY COUNT(*) DESC
        ) AS Rank
    FROM
        Software s
    GROUP BY
        s.Type, s.DeviceType
)
SELECT
    Type,
    DeviceType
FROM
    RankedSoftware
WHERE
    Rank = 1;





	





