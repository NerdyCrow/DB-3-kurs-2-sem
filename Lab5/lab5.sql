--1

ALTER TABLE Contacts
ADD ParentId INT NULL REFERENCES Contacts(Id)

-- 2
select * from Contacts
CREATE PROCEDURE ShowSubordinates(@Id INT)
AS
BEGIN
    WITH Subordinates AS (
        SELECT Id, Name, Email, Address, Phone, ParentId, 0 AS Level
        FROM Contacts
        WHERE Id = @Id
        UNION ALL
        SELECT c.Id, c.Name, c.Email, c.Address, c.Phone, c.ParentId, s.Level + 1
        FROM Contacts c
        JOIN Subordinates s ON c.ParentId = s.Id
    )
    SELECT Id, Name, Email, Address, Phone, ParentId, Level
    FROM Subordinates
    ORDER BY Level, Name;
END


exec ShowSubordinates 12;

-- 3

CREATE PROCEDURE AddSubordinate (@ParentId INT, @Name NVARCHAR(75), @Email NVARCHAR(75), @Address NVARCHAR(75), @Phone NVARCHAR(75))
AS
BEGIN
    INSERT INTO Contacts (Name, Email, Address, Phone, ParentId)
    VALUES (@Name, @Email, @Address, @Phone, @ParentId);
END


EXEC AddSubordinate 2, 'Ивановedd Иван', 'ivanov@mail.com', 'Москва', '123-45-67';



-- 4
create PROCEDURE MoveSubtree
    @sourceID int,
    @destinationID int
AS
BEGIN
    -- Получаем все дочерние элементы для верхнего перемещаемого узла
    WITH CTE AS (
        SELECT Id
        FROM Contacts
        WHERE ParentId = @sourceID
        
      UNION ALL
        
       SELECT T.Id
        FROM Contacts T
       JOIN CTE C ON T.ParentId = C.Id
    )
    -- Перемещаем каждый дочерний элемент
    UPDATE Contacts
    SET ParentId = @destinationID
    WHERE Id IN (SELECT Id FROM CTE)
    

END
select * from Contacts
EXEC MoveSubtree 12, 19




